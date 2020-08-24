function [CoordMatrix,Weight,Stiffness,Ratio,OptimizedFrameData]=GeometryOptimizer(refFrame,Seed,NumGens,GenSize,numSurv,maxChangeX,maxChangeY,maxChangeZ)
%Arguments: original Frame, Frame to iterate off of, Number of
%Iterations/Kill cycles, mutated frames per each input frame, Surviving
%frames after each cycle (also the first cycle runs this many copies of the
%starting frame), and the minimum stiffness allowed

%Duplicates the single input coordinate matrix into S copies of itself
CWorking = zeros(Seed.n,3,numSurv*numSurv);
CSWorking = zeros(Seed.n,3,numSurv);
TWorking = zeros(1,numSurv*numSurv);
WWorking= zeros(1,numSurv*numSurv);
for i=1:numSurv*numSurv+numSurv
    CWorking(:,:,i)=Seed.Coord';
    CSWorking(:,:,i)=Seed.Coord';
end
bestFrame=Seed;

toggle = true;

% Symmetrical and fixed nodes
symmetricalNodes = [1 3 5 7  9 12 14 16 18 20 23 25 27 29 31 33 35 39 41 47 45 43 50 53 55                                     
                    2 4 6 8 10 13 15 17 19 21 24 26 28 30 32 34 36 40 42 48 46 44 51 54 56];

fixedNodes = [1 2 3 4 5 6 7 8 9 10 12 13 14 15 16 17 18 19 29 30 35 36 37 38 39 40 41 42 43 44 45 46 50 51 52 53 54 55 56 57 58];
fixedPosX = [20 21 47 48 25 26 27 28 31 32 33 34];
fixedNegX = [20 21 49 25 26 27 28 31 32 33 34];
fixedPosY = [11 20 22 23 25 27 47 48 49 ];
fixedNegY = [11 21 22 24 26 28 47 48 49 ];
fixedPosZ = [20 21 31 32 33 34 47 48 49 25 26 11];
fixedNegZ = [20 21 31 32 33 34 25 26];

%The WHILE loops are functionally equivalent to FOR loops. While loops
%allow for prematurely ending the loop (not a current feature)

%Runs the I cycles of: taking S frames, making G frames per each of those S
%frames, then sorts by weight, and reruns the cycle with the best S of the
%sorted output frames now used as the input frames
k=1;
testSeed = Seed;
while k < (NumGens+1)
    toggle = ~toggle;
    fprintf("\nCurrent cyle: "+k+"\n");
    for j=1:numSurv
          CWorking(:,:,j) = CSWorking(:,:,j);
          testSeed.Coord = CWorking(:,:,j)';
          TWorking(:,j) = GetTorsionalStiffness(testSeed);
          WWorking(:,j) = GetWeight(testSeed);
    end
    for i=1:numSurv
        
        [CM2,WM2,TM2]=Iterator(refFrame.Coord',Seed,CSWorking(:,:,i),GenSize,numSurv,symmetricalNodes,fixedNodes,fixedPosX,fixedNegX,fixedPosY,fixedNegY,fixedPosZ,fixedNegZ,maxChangeX,maxChangeY,maxChangeZ,toggle);
        
        CWorking(:,:,(numSurv*(i+1)-((numSurv)-1)):numSurv*(i+1))=CM2(:,:,1:numSurv); %Stores all G*S output frames
        WWorking(:,(numSurv*(i+1)-(numSurv-1)):numSurv*(i+1))=WM2(:,1:numSurv);
        TWorking(:,(numSurv*(i+1)-(numSurv-1)):numSurv*(i+1))=TM2(:,1:numSurv);
        
    end
    %Sorts by ratio. Then sorts thickness, stiffness and weight accordingly
    RatioWorking = TWorking./WWorking;
    [SortedByRatio, RatioIndex] = sort(RatioWorking,'descend');
    % [SortedBW,BWindex] = sort(WWorking);
    WSWorking=WWorking(:,RatioIndex);
    CSWorking=CWorking(:,:,RatioIndex);
    TSWorking=TWorking(:,RatioIndex);
    fprintf("\tAssociated Stiffness:\t"+TSWorking(1)+" N*m/deg\n");
    fprintf("\tAssociated Weight:\t\t"+WSWorking(1)+" lbs\n");
    fprintf("\n\tGeneration Best Ratio:\t"+(SortedByRatio(1))+"\n");
    
    %Sets this cycles output to be next cycles input
    
    
    k=k+1;
end

%Returns/plots the final best frame
Ratio = SortedByRatio(1);
CoordMatrix=CSWorking(:,:,1);
Stiffness=TSWorking(:,1);
Weight=WSWorking(:,1);
OptimizedFrameData = GeometryAndLoadingForGeometryOptimizers_2019Frame(Seed.A',CoordMatrix');
end
%Takes arguments: orginal frame, frame to iterate from, matrix of thickness to iterate from,
%how many different frames to create, surviving frames, and minimum stiffness allowed
function [CM2,SW2,TS2,toggle]=Iterator(refFrameCoord,Seed,CSWorking,G,S,symmetricalNodes,fixedNodes,fixedPosX,fixedNegX,fixedPosY,fixedNegY,fixedPosZ,fixedNegZ,maxChangeX,maxChangeY,maxChangeZ,toggle)

copyOfCSWorking = CSWorking;
nodes = Seed.n;
Mutations=2;
W=zeros(1,G);
Result=zeros(nodes,3,G);
didYChange = false;
format short g;
%The for loop generates G frames for the given input frame. The WHILE loop
%serves as a DO WHILE. The only time it repeats is when every frame fails
%the stiffness test and Result is never initialized
for g=1:G
    CSWorking = copyOfCSWorking;
    for q=1:Mutations
        %Picks one random node. Randomizes in x, y, z.
        
        n=randi(Seed.n,1);
        if ~ismember(n, fixedNodes)
            if ismember(n, fixedNegX) && ~ismember(n, fixedPosX)
                x=rand;
                CSWorking(n,1)=CSWorking(n,1)+(x*maxChangeX);
            elseif ismember(n,fixedPosX) && ~ismember(n, fixedNegX)
                x=rand;
                CSWorking(n,1)=CSWorking(n,1)-(x*maxChangeX);
            elseif ~ismember(n,fixedPosX) && ~ismember(n, fixedNegX)
                x=rand;
                xsign = randi([0 1],1);
                if xsign == 0
                    CSWorking(n,1)=CSWorking(n,1)-(x*maxChangeX);
                else
                    CSWorking(n,1)=CSWorking(n,1)+(x*maxChangeX);
                end
            end
            
            ysign = -1;
            if ismember(n, fixedNegY) && ~ismember(n, fixedPosY)
                y=rand;
                ysign = 1;
                didYChange = true;
                CSWorking(n,2)=CSWorking(n,2)+(y*maxChangeY);
            elseif ismember(n,fixedPosY) && ~ismember(n, fixedNegY)
                y=rand;
                ysign = 0;
                didYChange = true;
                CSWorking(n,2)=CSWorking(n,2)-(y*maxChangeY);
            elseif ~ismember(n,fixedPosY) && ~ismember(n, fixedNegY)
                y=rand;
                didYChange = true;
                ysign = randi([0 1],1);
                if ysign == 0
                    CSWorking(n,2)=CSWorking(n,2)-(y*maxChangeY);
                else
                    CSWorking(n,2)=CSWorking(n,2)+(y*maxChangeY);
                end
            end
            
            if ismember(n, fixedNegZ) && ~ismember(n, fixedPosZ)
                z=rand;
                CSWorking(n,3)=CSWorking(n,3)+(z*maxChangeZ);
            elseif ismember(n,fixedPosZ) && ~ismember(n, fixedNegZ)
                z=rand;
                CSWorking(n,3)=CSWorking(n,3)-(z*maxChangeZ);
            elseif ~ismember(n,fixedPosZ) && ~ismember(n, fixedNegZ)
                z=rand;
                zsign = randi([0 1],1);
                if zsign == 0
                    CSWorking(n,3)=CSWorking(n,3)-(z*maxChangeZ);
                else
                    CSWorking(n,3)=CSWorking(n,3)+(z*maxChangeZ);
                end
            end
            
            % Enforces symmetry --- Jeff, we will have to go thru and ensure this is correct
            if ismember(n, symmetricalNodes)
                index = find(symmetricalNodes==n);
                toChangeIndex = index;
                if mod(index,2) == 0 % index is even
                    toChangeIndex=toChangeIndex-1;
                else
                    toChangeIndex=toChangeIndex+1;
                end
                CSWorking(symmetricalNodes(toChangeIndex),1) = CSWorking(symmetricalNodes(index),1);
                
                if ysign == 0 && didYChange
                    CSWorking(symmetricalNodes(toChangeIndex),2) = CSWorking(symmetricalNodes(toChangeIndex),2) + y*maxChangeY;
                elseif ysign ~= 0 && didYChange
                    CSWorking(symmetricalNodes(toChangeIndex),2) = CSWorking(symmetricalNodes(toChangeIndex),2) - y*maxChangeY;
                end
                
                CSWorking(symmetricalNodes(toChangeIndex),3) = CSWorking(symmetricalNodes(index),3);
            end
            
            
            for s=1:Seed.n
                if CSWorking(s,1)-refFrameCoord(s,1) > maxChangeX
                    CSWorking(s,1)=refFrameCoord(s,1)+maxChangeX;
                elseif refFrameCoord(s,1)-CSWorking(s,1) > maxChangeX
                    CSWorking(s,1)=refFrameCoord(s,1)-maxChangeX;
                end
                
                if CSWorking(s,2)-refFrameCoord(s,2) > maxChangeY
                    CSWorking(s,2)=refFrameCoord(s,2)+maxChangeY;
                elseif refFrameCoord(s,2)-CSWorking(s,2) > maxChangeY
                    CSWorking(s,2)=refFrameCoord(s,2)-maxChangeY;
                end
                
                if CSWorking(s,3)-refFrameCoord(s,3) > maxChangeZ
                    CSWorking(s,3)=refFrameCoord(s,3)+maxChangeZ;
                elseif refFrameCoord(s,3)-CSWorking(s,3) > maxChangeZ
                    CSWorking(s,3)=refFrameCoord(s,3)-maxChangeZ;
                end
            end
            
        end
        
       didYChange = false; 
    end
    
    newFrameData = GeometryAndLoadingForGeometryOptimizers_2019Frame(Seed.A',CSWorking');
    TS = GetTorsionalStiffness(newFrameData);
    Weight = GetWeight(newFrameData);
    Result(:,:,g)=CSWorking;
    W(1,g)=Weight;
    TSM(1,g)=TS;
    
end
%Sorts the results by ratio
Ratios = TSM./W;
[SortedRatios,Rindex] = sort(Ratios,'descend');
SortedW = W(1,Rindex);
SortedC = Result(:,:,Rindex);
SortedTSM = TSM(1,Rindex);

CM2 = SortedC;
SW2 = SortedW;
TS2 = SortedTSM;

% e=size(SortedC);   % Broken debugging code
% if e(2)<S
%     SortedC(:,:,(e(2)+1):S)=nan;
%     SortedW(:,(e(2)+1):S)=nan;
%     SortedTSM(:,(e(2)+1):S)=nan;
%     CM2=SortedC(:,:,1:S);
%     SW2 =SortedW(1:S);
%     TS2=SortedTSM(1:S);
%
% else
%     CM2=SortedC(:,:,1:S);
%     SW2 =SortedW(1:S);
%     TS2=SortedTSM(1:S);
% end
end