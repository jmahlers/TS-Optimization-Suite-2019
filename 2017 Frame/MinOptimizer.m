function OptimizedFrameData = MinOptimizer(m,n,TargetTS,plotThicknesses,plotGraphs,squareTubes)
% Optimizes tube thicknesses by starting at minimum possible thickness values and changing one
% tube at a time. Sim selects the tube to increase in thickness according to the best TS-to-Weight Ratio
% gain found in each round after testing every tube. Note: Calls WeightOptimizer after its job is done.

% Number of possible tube thickness options minus the solid 1" tube
numberOfTubeThicknessOptions = 13;

% Initializing storage matrices and variables
initSize = 5;
TSStorage=zeros(1,initSize);
WeightStorage=zeros(1,initSize);
RatioStorage=zeros(1,initSize);
TubeThatWasIncreased=zeros(1,initSize);
IntMatrixStorage = zeros(initSize,m);

trigger = false;
counter = 1;

% Getting initial values for minimum thickness frame
min = GenerateMinThicknessMatrix(m,squareTubes);
[initialTS,initialWeight,initialRatio] = TestFrame(min,m,squareTubes);
TSStorage(1)=initialTS;WeightStorage(1)=initialWeight;RatioStorage(1)=initialRatio;
IntMatrixStorage(1,:)=min;

% Printing initial values
PrintRoundInfo(TSStorage(1),WeightStorage(1),RatioStorage(1),counter);

% Begin main loop
while TSStorage(counter) < TargetTS
    counter=counter+1;
    
    % Initializing variables specific to each "round"
    currMaxTS = 0;
    currMaxRatio = 0;
    currRatioMatrix = zeros(1,m-15);
    associatedIndex = 0;
    
    % Tests stiffness/weight ratio that results from increasing the
    % thickness of each tube one-by-one
    while (1==1)
        for i=1:m-15
            if min(i) < numberOfTubeThicknessOptions
                min(i) = min(i)+1;
                min = MakeMinSymmetrical(min,i);
                
                % Testing a thickness increase in one tube
                [currTS,currWeight,currRatio] = TestFrame(min,m,squareTubes);
                currRatioMatrix(i) = currRatio;
                % End testing
                
                if currRatio > currMaxRatio && ~trigger 
                    currMaxRatio = currRatio;
                    associatedIndex = i;
                end
                
                min(i) = min(i)-1;
                min = MakeMinSymmetrical(min,i);
            end
        end
        
        % Error catching
        if associatedIndex ~=0
            trigger = false;
            break;
        else
            trigger = true;
        end
        
    end
    
    % Calculating values for the frame with the best tube to increase in
    % thickness selected.(i.e. the tube that resulted in the largest ratio found in the
    % for-loop above)
    
    min(associatedIndex) = min(associatedIndex)+1;
    min = MakeMinSymmetrical(min,associatedIndex);
    [roundBestTS,roundBestWeight,roundBestRatio]=TestFrame(min,m,squareTubes);
    TSStorage(counter)=roundBestTS;WeightStorage(counter)=roundBestWeight;
    RatioStorage(counter)=roundBestRatio;TubeThatWasIncreased(counter)=associatedIndex;
    IntMatrixStorage(counter,:)=min;
    
    % Print statements for round results
    PrintRoundInfo(TSStorage(counter),WeightStorage(counter),RatioStorage(counter),counter);
end
    
if plotGraphs
    % Plot Stiffness/Weight/Ratio vs Iterations
    figure('Name','Stiffness vs Iterations (MinOptimizer)');
    plot(TSStorage);
    clear title xlabel ylabel;
    title('Stiffness vs Iterations (MinOptimizer)');
    xlabel('Iterations');
    ylabel('Stiffness (N*m/deg)')
    grid ON; grid MINOR;
    
    figure('Name','Weight vs Iterations (MinOptimizer)');
    plot(WeightStorage);
    title('Weight vs Iterations (MinOptimizer)');
    xlabel('Iterations');
    ylabel('Weight (lbs)')
    grid ON; grid MINOR;
    
    figure('Name','Ratio vs Iterations (MinOptimizer)');
    plot(RatioStorage);
    title('Ratio vs Iterations (MinOptimizer)');
    xlabel('Iterations');
    ylabel('Ratio (TS/Weight)')
    grid ON; grid MINOR;
end
if plotThicknesses
    % Plot thicknesses
    PlotFrame(min,5);
end   
    
    fprintf("\nMIN OPTIMIZER RESULTS AT TARGET TS:\n");
    fprintf("Torsional Stiffness:\t"+TSStorage(counter)+" N*m/deg\n");
    fprintf("Associated Weight:\t\t"+WeightStorage(counter)+" lbs\n");
    fprintf("Ratio (TS/Weight):\t\t"+RatioStorage(counter)+"\n\n");
    
    % Calculate best ratio and corresponding stiffness, weight
    toSortRatios = RatioStorage;
    [sortedRatios, indices] = sort(toSortRatios,'descend');
    
    fprintf("\nMIN OPTIMIZER BEST RESULTS IN TERMS OF RATIO:\n");
    fprintf("Torsional Stiffness:\t"+TSStorage(indices(1))+" N*m/deg\n");
    fprintf("Associated Weight:\t\t"+WeightStorage(indices(1))+" lbs\n");
    fprintf("Ratio (TS/Weight):\t\t"+sortedRatios(1)+"\n\n");
    
    OptimizedFrameData = GeometryAndLoadingForThicknessOptimizers_2017Frame(IntToThicknessMatrix(IntMatrixStorage(counter,:),m,squareTubes));
end

    function symmetricalMin = MakeMinSymmetrical(min,associatedIndex)
        symmetricalPairs = [54 64 67 19 27 2 30 48 36 42 44 38 46 40 69 4 13 3 21 25  8 23 58 60 11 15 33 50 56 72 62 76 77 81 85 85 85 91 89
                            55 65 66 20 28 5 31 49 37 43 45 39 47 41 71 7 14 6 22 26 10 24 59 61 12 18 35 52 57 73 63 78 79 84 86 88 87 92 90];
        
        if ismember(associatedIndex, symmetricalPairs)
            index = find(symmetricalPairs==associatedIndex);
            toChangeIndex = index;
            if mod(index,2) == 0 % index is even
                toChangeIndex=toChangeIndex-1;
            else
                toChangeIndex=toChangeIndex+1;
            end
            min(symmetricalPairs(toChangeIndex)) = min(symmetricalPairs(index));
        end
        symmetricalMin = min;
    end

    function isItSymmetrical = TestSymmetry(intMatrix)
        symmetricalPairs = [54 64 67 19 27 2 30 48 36 42 44 38 46 40 69 4 13 3 21 25  8 23 58 60 11 15 33 50 56 72 62 76 77 81 85 85 85 91 89
                            55 65 66 20 28 5 31 49 37 43 45 39 47 41 71 7 14 6 22 26 10 24 59 61 12 18 35 52 57 73 63 78 79 84 86 88 87 92 90];
        isItSymmetrical = true;
        for i=1:length(symmetricalPairs)
            if intMatrix(symmetricalPairs(1,i)) ~= intMatrix(symmetricalPairs(2,i))
                isItSymmetrical = false;
            end
        end
    end

    function [TS, Weight, Ratio] = TestFrame(intMatrix,m,squareTubes)
        tubeThicknessMatrix = IntToThicknessMatrix(intMatrix,m,squareTubes);
        FrameData = GeometryAndLoadingForThicknessOptimizers_2017Frame(tubeThicknessMatrix);
        TS = GetTorsionalStiffness(FrameData);
        Weight = GetWeight(FrameData);
        Ratio = TS/Weight;
    end

    function PrintRoundInfo(TS,Weight,Ratio,counter)
        fprintf("\nRound #"+counter+"\n");
        fprintf("Torsional Stiffness:\t"+TS+" N*m/deg\n");
        fprintf("Associated Weight:\t\t"+Weight+" lbs\n");
        fprintf("Ratio (TS/Weight):\t\t"+Ratio+"\n\n");
    end

    function PlotFrame(intMatrix, scaleFactor)
        tubeThicknessMatrix = IntToThicknessMatrix(intMatrix);
        FrameData = GeometryAndLoadingForThicknessOptimizers_2017Frame(tubeThicknessMatrix);
        [~,V,~] = DirectStiffnessSolver(FrameData);
        PlotDisplacement(FrameData,V,scaleFactor,false,true)
    end

