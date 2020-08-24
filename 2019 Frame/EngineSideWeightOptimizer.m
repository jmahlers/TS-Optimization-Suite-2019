function [AreaMatrix,Weight,Stiffness,OptimizedFrameData]=EngineSideWeightOptimizer(refFrame,Seed,NumGens,GenSize,numSurv,TargetTS,plotThicknesses,squareTubes)
%Arguments original Frame, Frame to iterate off of, Number of
%Iterations/Kill cycles, mutated frames per each input frame, Surviving
%frames after each cycle (also the first cycle runs this many copies of the
%starting frame), and the minimum stiffness allowed

Dup = ones(1,numSurv);   % Duplicates the single input thickness matrix into S copies of itself
AWorking=Seed.A*Dup;
ASWorking=Seed.A*Dup;
bestFrame=Seed;


%Generates a minimum rule compliant frame.
min = GenerateMinThicknessMatrix(refFrame.m,squareTubes);
thicknesses = IntToThicknessMatrix(min,Seed.m,squareTubes);
minRefFrame = EngineSideGeometryAndLoadingForThicknessOptimizers_2019Frame(thicknesses);
symmetricalPairs = [2 3 4  9 10 13 14 15 19 20 21 22 27 28 29 33 35 36 39 40 41 42 47 48 51 52 56 58 60 61 64 65 66 70 71 72 73 78 79 82 83 87 90 91 92  96  97  98  99 104 107 108 111 112 115 116 117 120 122        
                    6 5 7 12 11 16 17 18 26 25 24 23 30 31 32 34 37 38 43 45 44 46 49 50 53 54 57 59 62 63 67 68 69 74 75 76 77 80 81 84 85 89 93 95 94 100 102 103 101 106 109 110 113 114 126 118 119 121 124];
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
    %Should NOT sort by ratio 
    %RatioWorking = TWorking./WWorking;
    %[SortedByRatio, RatioIndex] = sort(RatioWorking,'descend');
    [SortedBW,BWIndex] = sort(WWorking, 'ascend');
    WSWorking=WWorking(:,BWIndex);
    ASWorking=AWorking(:,BWIndex);
    TSWorking=TWorking(:,BWIndex);
    %fprintf("\n\tGeneration Best Ratio:\t"+(SortedByRatio(1))+"\n");
    fprintf("\tAssociated Stiffness:\t"+TSWorking(1)+" N*m/deg\n");
    fprintf("\tAssociated Weight:\t\t"+WSWorking(1)+" lbs\n");
    
    %Sets this cycles output to be next cycles input
    ASWorking=ASWorking(:,1:numSurv);
    k=k+1;
end
%Returns/plots the final best frame
%Ratio = SortedByRatio(1);
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

 fprintf("\nWEIGHT OPTIMIZER FINAL RESULTS:\n");
 fprintf("Torsional Stiffness:\t"+Stiffness+" N*m/deg\n");
 fprintf("Associated Weight:\t\t"+Weight+" lbs\n");
 fprintf("Ratio (TS/Weight):\t\t"+(Stiffness/Weight)+"\n\n");
end
%Takes arguments: orginal frame, frame to iterate from, matrix of thickness to iterate from,
%how many different frames to create, surviving frames, and minimum stiffness allowed 
function [AM2,SW2,TS2]=Iterator(DoG,DW,DMinA,ASWorking,G,S,TargetTS,symmetricalPairs,squareTubes)


DW.A=ASWorking;

Mutations=5;

TSMissed=0;
RIndex=2;
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

%Ensures that the previous frame is at least one of the checked frames
        TS1 = GetEngineSideTorsionalStiffness(DW);
        Weight1 = GetWeight(DW);
        Result(:,1)=DW.A;
        W(1,1)=Weight1;
        TSM(1,1)=TS1;
for g=1:G
    while 1==1
%         [~,VV,~] = DirectStiffnessSolver(DW);
%         scaleFactor = 20;
%         PlotDisplacement(DW,VV,scaleFactor, false, true);            

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
%             [~,VV,~] = DirectStiffnessSolver(DW);
%             scaleFactor = 20;
%              PlotDisplacement(DW,VV,scaleFactor, false, true);
%              
             
             
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
%                    [~,VV,~] = DirectStiffnessSolver(DW);
%         scaleFactor = 20;
%         PlotDisplacement(DW,VV,scaleFactor, false, true);
%         
%         
        
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
            
%                     [~,VV,~] = DirectStiffnessSolver(DW);
%         scaleFactor = 20;
%         PlotDisplacement(DW,VV,scaleFactor, false, true);
%         
        end
        
        TS = GetEngineSideTorsionalStiffness(DW);
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
[SortedW,Windex] =sort(W, 'ascend');
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