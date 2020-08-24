
% Run full optimizer suite from draft of frame by twisting the back box
m = 141; n = 58;                % # of members, # of nodesGeneration
TargetTS = 1200;                % Aim low b/c the simulation shoots high
includeSquareTubes = false;     
tradeOffIterations = 4;

% Global parameters for Weight Optimizer
weightI = 10;  % Number of generations
weightG = 100; % Generation size
weightS = 5;   % Number of surviving frames per generation

% Global parameters for Geometry Optimizer
geomI = 10;    % Number of generations
geomG = 100;   % Generation size
geomS = 5;     % Number of surviving frames per generation

% Max displacement from original node positions for Geometry Optimizer
maxChangeX = 1.5  /tradeOffIterations; % inches
maxChangeY = 3.5  /tradeOffIterations; % inches
maxChangeZ = 1.5  /tradeOffIterations; % inches

% Begin optimizing suite

% Running MinOptimizer
%(Iterative optimizer that picks "lowest hanging fruit" tubes to increase
% in thickness first; runs until TargetTS is met)
fprintf("\n\nBEGINNING MIN OPTIMIZER\n\n");

min = GenerateMinThicknessMatrix(m,includeSquareTubes);
tubeThicknessMatrix = IntToThicknessMatrix(min,m,includeSquareTubes);
DraftFrameData = EngineSideGeometryAndLoadingForThicknessOptimizers_2019Frame(tubeThicknessMatrix);

OptimizedFrameData = EngineSideMinOptimizer(DraftFrameData.m,DraftFrameData.n,TargetTS,false,false,false);

% %OptimizedFrameData.A = OptimizedFrameData.A';
% 
% % Running WeightOptimizer 
% %(GA that tries to decrease tube thicknesses while maintaining a specified stiffness)
% % OptimizedFrameData.A = OptimizedFrameData.A';
% % fprintf("\n\nBEGINNING WEIGHT OPTIMIZER SIM\n\n");
% % [~,~,~,~,OptimizedFrameData]=WeightOptimizer(DraftFrameData,OptimizedFrameData,weightI,weightG,weightS,TargetTS-500,false,includeSquareTubes);
% 
% % % % Running WeightOptimizer on frame with optimized geometry
%  fprintf("\n\nBEGINNING WEIGHT OPTIMIZER SIM\n\n");
%  [AreaMatrix,Weight,Stiffness,OptimizedFrameData]=WeightOptimizer(DraftFrameData,OptimizedFrameData,weightI,weightG,weightS,TargetTS-300,false,includeSquareTubes);
% 
% % Running GeometryOptimizer
% %(GA that changes node positions by specified maxChange values; keeps frame
% % with best TS/Weight ratio.)
% fprintf("\n\nBEGINNING GEOMETRY OPTIMIZER SIM\n\n");
% [CoordMatrix,~,~,~,OptimizedFrameData] = GeometryOptimizer(OptimizedFrameData,OptimizedFrameData,geomI,geomG,geomS,maxChangeX,maxChangeY,maxChangeZ);
% 
% % % % Running WeightOptimizer on frame with optimized geometry
%  fprintf("\n\nBEGINNING WEIGHT OPTIMIZER SIM\n\n");
%  [AreaMatrix,Weight,Stiffness,OptimizedFrameData]=WeightOptimizer(DraftFrameData,OptimizedFrameData,weightI,weightG,weightS,TargetTS-300,false,includeSquareTubes);

AreaMatrix=[];
Weight=[];
Stiffness=[];
CoordMatrix=[];

 for i=1:tradeOffIterations
    fprintf("\n\nBEGINNING WEIGHT OPTIMIZER SIM NUMBER: "+i+"\n\n");
    [AreaMatrix,Weight,Stiffness,~]=EngineSideWeightOptimizer(DraftFrameData,OptimizedFrameData,weightI,weightG,weightS,TargetTS-102,false,includeSquareTubes);
    OptmizedFrameData.A=AreaMatrix;
    fprintf("\n\nBEGINNING GEOMETRY OPTIMIZER SIM NUMBER: "+i+"\n\n");
    [CoordMatrix,~,~,~,OptimizedFrameData] = EngineSideGeometryOptimizer(OptimizedFrameData,OptimizedFrameData,geomI,geomG,geomS,maxChangeX,maxChangeY,maxChangeZ);
 end

% Exports optimized frame to TXT file for Solidworks macro
OptimizedFrameData.A = OptimizedFrameData.A';
EngineSideFinalOutputUtil(OptimizedFrameData,15);

fprintf("\nOPTIMIZATION SUITE HAS FINISHED OPTIMIZING YOUR FRAME DRAFT\n\n");




