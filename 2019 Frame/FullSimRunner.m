
% Parameters for Running the Full Simulation
% ------------------------------------------
m =141; n = 58;                % # of members, # of nodesGeneration
TargetTS = 1600;
includeSquareTubes = false;     
tradeOffIterations = 25;       % How many back-and-forths between Weight And Geometry Optimizer
toggle = true;                 % Start with front twist (true) or rear twist (false)

% Global parameters for Weight Optimizer
weightI = 5;        % Number of generations
weightG = 100;      % Generation size
weightS = 3;        % Number of surviving frames per generation

allowable = 3;     % Offset from Target Stiffness

% Global parameters for Geometry Optimizer
geomI = 10;          % Number of generations
geomG = 100;        % Generation size
geomS = 6;          % Number of surviving frames per generation

% Max displacement from original node positions for Geometry Optimizer
maxChangeX = 1;  %/tradeOffIterations;    % inches
maxChangeY = 3; %/tradeOffIterations;    % inches
maxChangeZ = 1;  %/tradeOffIterations;    % inches

% Begin optimizing suite
% ----------------------

% Running MinOptimizer
fprintf("\n\nBEGINNING MIN OPTIMIZER\n\n");
min = GenerateMinThicknessMatrix(m,includeSquareTubes);
tubeThicknessMatrix = IntToThicknessMatrix(min,m,includeSquareTubes);
DraftFrameData = GeometryAndLoadingForThicknessOptimizers_2019Frame(tubeThicknessMatrix);
[OptimizedFrameData,FrontSideStiffness,EngineSideStiffness] = MinOptimizer(DraftFrameData.m,DraftFrameData.n,TargetTS,false,false,false);

% Dummy Variables
AreaMatrix=[];
Weight=[];
Stiffness=[];
CoordMatrix=[];

 for i=1:tradeOffIterations
        if toggle
            %toggle = ~toggle;
            
%             % Get Front-Side Starting Stiffness for Weight Optimizer
%             TestFrameForStartingStiffness = GeometryAndLoadingForGeometryOptimizers_2019Frame(OptimizedFrameData.A,OptimizedFrameData.Coord);
%             startStiffness = GetTorsionalStiffness(TestFrameForStartingStiffness);
%             
%             % Run Front-Side Weight Optimizer
%             fprintf("\n\nFRONT-SIDE WEIGHT OPTIMIZER SIM NUMBER: "+i+"\n\n");
%             OptimizedFrameData = GeometryAndLoadingForGeometryOptimizers_2019Frame(OptimizedFrameData.A',OptimizedFrameData.Coord);
%             [AreaMatrix,Weight,Stiffness,OptimizedFrameData]=WeightOptimizer(OptimizedFrameData,OptimizedFrameData,weightI,weightG,weightS,startStiffness-allowable,false,includeSquareTubes);
            
            % Run Front-Side Geometry Optimizer
            fprintf("\n\nFRONT-SIDE GEOMETRY OPTIMIZER SIM NUMBER: "+i+"\n\n");
%            OptimizedFrameData.A = AreaMatrix;
            OptimizedFrameData = GeometryAndLoadingForGeometryOptimizers_2019Frame(OptimizedFrameData.A',OptimizedFrameData.Coord);
            [CoordMatrix,~,Stiffness,~,OptimizedFrameData] = GeometryOptimizer(DraftFrameData,OptimizedFrameData,geomI,geomG,geomS,maxChangeX,maxChangeY,maxChangeZ);
            FrontSideStiffness = Stiffness;
        else
            %toggle = ~toggle;
            
%             % Get Engine-Side Starting Stiffness for Weight Optimizer
%             TestFrameForStartingStiffness = EngineSideGeometryAndLoadingForGeometryOptimizers_2019Frame(OptimizedFrameData.A,OptimizedFrameData.Coord);
%             startStiffness = GetEngineSideTorsionalStiffness(TestFrameForStartingStiffness);
%             
%             % Run Engine-Side Weight Optimizer
%             fprintf("\n\nENGINE-SIDE WEIGHT OPTIMIZER SIM NUMBER: "+i+"\n\n");
%             OptimizedFrameData = EngineSideGeometryAndLoadingForGeometryOptimizers_2019Frame(OptimizedFrameData.A',OptimizedFrameData.Coord);
%             [AreaMatrix,Weight,Stiffness,OptimizedFrameData]=EngineSideWeightOptimizer(OptimizedFrameData,OptimizedFrameData,weightI,weightG,weightS,startStiffness-allowable,false,includeSquareTubes);
            
            % Run Engine-Side Geometry Optimizer
            fprintf("\n\nENGINE-SIDE GEOMETRY OPTIMIZER SIM NUMBER: "+i+"\n\n");
%            OptimizedFrameData.A = AreaMatrix;
            OptimizedFrameData = EngineSideGeometryAndLoadingForGeometryOptimizers_2019Frame(OptimizedFrameData.A',OptimizedFrameData.Coord);
            [CoordMatrix,~,Stiffness,~,OptimizedFrameData] = EngineSideGeometryOptimizer(DraftFrameData,OptimizedFrameData,geomI,geomG,geomS,maxChangeX,maxChangeY,maxChangeZ);
            EngineSideStiffness = Stiffness;
        end
        if FrontSideStiffness < EngineSideStiffness
            toggle = true;
        else
            toggle = false;
        end
 end

% Exports optimized frame to TXT file for Solidworks macro
OptimizedFrameData.A = OptimizedFrameData.A';
FinalOutputUtil(OptimizedFrameData,15);

fprintf("\nDONE\n\n");




