function [AreaMatrix,Weight,Stiffness,Ratio,OptimizedFrameData]=WeightOptimizer(refFrame,Seed,NumGens,GenSize,numSurv,TargetTS,plotThicknesses,squareTubes)
%Arguments original Frame, Frame to iterate off of, Number of
%Iterations/Kill cycles, mutated frames per each input frame, Surviving
%frames after each cycle (also the first cycle runs this many copies of the
%starting frame), and the minimum stiffness allowed

Dup = ones(1,numSurv);   % Duplicates the single input thickness matrix into S copies of itself
AWorking=Seed.A'*Dup;
ASWorking=Seed.A'*Dup;
bestFrame=Seed;


%Generates a minimum rule compliant frame.
min = GenerateMinThicknessMatrix(refFrame.m,squareTubes);
thicknesses = IntToThicknessMatrix(min,Seed.m,squareTubes);
minRefFrame = GeometryAndLoadingForThicknessOptimizers_2017Frame(thicknesses);
symmetricalPairs = [54 64 67 19 27 2 30 48 36 42 44 38 46 40 69 4 13 3 21 25  8 23 58 60 11 15 33 50 56 72 62 76 77 81 85 85 85 91 89                
                    55 65 66 20 28 5 31 49 37 43 45 39 47 41 71 7 14 6 22 26 10 24 59 61 12 18 35 52 57 73 63 78 79 84 86 88 87 92 90];


%The WHILE loops are functionally equivalent to FOR loops. While loops
%allow for prematurely ending the loop (not a current feature)

%Runs the I cycles of: taking S frames, making G frames per each of those S
%frames, then sorts by weight, and reruns the cycle with the best S of the
%sorted output frames now used as the input frames
k=1;
while k < (NumGens+1)
    fprintf("\nCurrent cyle: "+k+"\n");   %Constant in front of aa will make it print once every constant
    
    for i=1:numSurv
        
        [AM2,WM2,TM2]=Iterator(refFrame,Seed,minRefFrame.A,ASWorking(:,i),GenSize,numSurv,TargetTS,symmetricalPairs,squareTubes);
        
        %       if isnan(AM2(1,S-3))
        %         k=I+1;             %This would end the code after the current
        %cycle if there are not enough frames
        %meeting the Target TS
        %      end
        AWorking(:,(numSurv*i-(numSurv-1)):numSurv*i)=AM2(:,1:numSurv); %Stores all G*S output frames
        WWorking(:,(numSurv*i-(numSurv-1)):numSurv*i)=WM2(:,1:numSurv);
        TWorking(:,(numSurv*i-(numSurv-1)):numSurv*i)=TM2(:,1:numSurv);
        
        
        
    end
    %Sorts by ratio. Then sorts thickness, stiffness and weight accordingly
    RatioWorking = TWorking./WWorking;
    [SortedByRatio, RatioIndex] = sort(RatioWorking,'descend');
   % [SortedBW,BWindex] = sort(WWorking);
    WSWorking=WWorking(:,RatioIndex);
    ASWorking=AWorking(:,RatioIndex);
    TSWorking=TWorking(:,RatioIndex);
    fprintf("\n\tGeneration Best Ratio:\t"+(SortedByRatio(1))+"\n");
    fprintf("\tAssociated Stiffness:\t"+TSWorking(1)+" N*m/deg\n");
    fprintf("\tAssociated Weight:\t\t"+WSWorking(1)+" lbs\n");
    
    %Sets this cycles output to be next cycles input
    ASWorking=ASWorking(:,1:numSurv);
    k=k+1;
end
%Returns/plots the final best frame
Ratio = SortedByRatio(1);
AreaMatrix=ASWorking(:,1);
Stiffness=TSWorking(:,1);
Weight=WSWorking(:,1);

bestFrame.A=AreaMatrix;
[~,V,~] = DirectStiffnessSolver(bestFrame);
scaleFactor = 5;
if plotThicknesses
    PlotDisplacement(bestFrame,V,scaleFactor,false,true);
end
OptimizedFrameData = bestFrame;

% fprintf("\nWEIGHT OPTIMIZER FINAL RESULTS:\n");
% fprintf("Torsional Stiffness:\t"+Stiffness+" N*m/deg\n");
% fprintf("Associated Weight:\t\t"+Weight+" lbs\n");
% fprintf("Ratio (TS/Weight):\t\t"+Ratio+"\n\n");
end
%Takes arguments: orginal frame, frame to iterate from, matrix of thickness to iterate from,
%how many different frames to create, surviving frames, and minimum stiffness allowed 
function [AM2,SW2,TS2]=Iterator(DoG,DW,DMinA,ASWorking,G,S,TargetTS,symmetricalPairs,squareTubes)


DW.A=ASWorking;

Mutations=3;

TSMissed=0;
RIndex=1;
W=1;

RD5x35 = .051129; % 1
RD5x49 = .0694261;% 2
R75x35 = .078618; % 3
R75x49 = .1079106;% 4
RD1x35 = .106107; % 5
SQ1x35 = .1321857;% 6
RD1x49 = .146395; % 7
SQ1x49 = .179735; % 8 
RD1x65 = .19093;  % 9
SQ1x65 = .2330008;%10
RD1x83 = .239110; %11
RD1x95 = .270098; %12
RD1120 = .331752; %13
RD1xSD = .785398; %14
format short g;
%The for loop generates G frames for the given input frame. The WHILE loop
%serves as a DO WHILE. The only time it repeats is when every frame fails
%the stiffness test and Result is never initialized
for g=1:G
    while 1==1
        
        for q=1:Mutations
            %Picks one random member. Sets it to a random thickness
            r=randi(DW.m,1);
            t=randi(13,1);
            switch t
                case 1
                    DW.A(r)= RD5x35;
                case 2
                    DW.A(r)= RD5x49;
                case 3
                    DW.A(r)= R75x35;
                case 4
                    DW.A(r)= R75x49;
                case 5
                    DW.A(r)= RD1x35;
                case 6
                    if squareTubes
                        DW.A(r)= SQ1x35;
                    else
                        DW.A(r)= RD1x49;
                    end
                
                case 7
                    DW.A(r)=RD1x49;
                case 8
                    if squareTubes
                        DW.A(r)=SQ1x49;
                    else
                        DW.A(r)=RD1x65;
                    end
                case 9
                    DW.A(r)=RD1x65;
                case 10
                    if squareTubes
                        DW.A(r)=SQ1x65;
                    else
                        DW.A(r)=RD1x83;
                    end
                case 11
                    DW.A(r)=RD1x83;
                case 12
                    DW.A(r)=RD1x95;
                case 13
                    DW.A(r)=RD1120;
                    
            end
            %CONSTRAINTS GO HERE. If the changed member must be something
            %different change it after the fact by either setting it to the
            %original or setting it to the minimum allowed
            if DoG.A(r)==RD1xSD
                DW.A(r)=RD1xSD;
%             elseif DoG.A(r)==SQ1x49
%                 DW.A(r)=SQ1x49;
            end
            if DW.A(r)<DMinA(r)
                DW.A(r)=DMinA(r);
            end
           
           % Enforces symmetry --- Jeff, we will have to go thru and ensure this is correct 
            if ismember(r, symmetricalPairs)
                index = find(symmetricalPairs==r);
                toChangeIndex = index;
                if mod(index,2) == 0 % index is even
                    toChangeIndex=toChangeIndex-1;
                else
                    toChangeIndex=toChangeIndex+1;
                end  
                DW.A(symmetricalPairs(toChangeIndex)) = DW.A(symmetricalPairs(index));
            end
            
            
        end
        
        TS = GetTorsionalStiffness(DW);
        Weight = GetWeight(DW);
        if TS>(TargetTS)            %Only keeps the frame if it meets minimum stiffness requirement
            Result(:,RIndex)=DW.A;
            W(1,RIndex)=Weight;
            TSM(1,RIndex)=TS;
            RIndex=RIndex+1;
            TSMissed=0;
        else
            TSMissed=TSMissed+1;
        end
        if TSMissed<G
            break;                  %Ends while loop whenever there is at least one passing frame
        end
    end
end
%Sorts the results by weight. If there are less than S frames that pass,
%they are replaced with null. It then returns the best S frames
[SortedW,Windex] =sort(W);
SortedA=Result(:,Windex);
SortedTSM=TSM(1,Windex);
e=size(SortedA);
if e(2)<S
    SortedA(:,(e(2)+1):S)=nan;
    SortedW(:,(e(2)+1):S)=nan;
    SortedTSM(:,(e(2)+1):S)=nan;
    AM2=SortedA(:,1:S);
    SW2 =SortedW(1:S);
    TS2=SortedTSM(1:S);
    
else
    AM2=SortedA(:,1:S);
    SW2 =SortedW(1:S);
    TS2=SortedTSM(1:S);
end
end