
% Run full optimizer suite from draft of frame
m=107; n=44;                    % # of members, # of nodes
TargetTS = 1200;                % Aim low b/c the simulation shoots high
includeSquareTubes = false;     

% Global parameters for Weight Optimizer
weightI = 25;  % Number of generations
weightG = 100; % Generation size
weightS = 3;   % Number of surviving frames per generation

% Global parameters for Geometry Optimizer
geomI = 25;    % Number of generations
geomG = 100;   % Generation size
geomS = 5;     % Number of surviving frames per generation

% Max displacement from original node positions for Geometry Optimizer
maxChangeX = 1; % inches
maxChangeY = 2; % inches
maxChangeZ = 1; % inches

% Begin optimizing suite

% Running MinOptimizer
%(Iterative optimizer that picks "lowest hanging fruit" tubes to increase
% in thickness first; runs until TargetTS is met)
fprintf("\n\nBEGINNING MIN OPTIMIZER\n\n");
DraftFrameData = GeometryAndLoading_2017Frame;
OptimizedFrameData = MinOptimizer(DraftFrameData.m,DraftFrameData.n,TargetTS,false,false,false);

% Running WeightOptimizer 
%(GA that tries to decrease tube thicknesses while maintaining a specified stiffness)
OptimizedFrameData.A = OptimizedFrameData.A';
fprintf("\n\nBEGINNING WEIGHT OPTIMIZER SIM\n\n");
[~,~,~,~,OptimizedFrameData]=WeightOptimizer(DraftFrameData,OptimizedFrameData,weightI,weightG,weightS,TargetTS-500,false,includeSquareTubes);

% Running GeometryOptimizer
%(GA that changes node positions by specified maxChange values; keeps frame
% with best TS/Weight ratio.)
fprintf("\n\nBEGINNING GEOMETRY OPTIMIZER SIM\n\n");
[CoordMatrix,~,~,~,OptimizedFrameData] = GeometryOptimizer(OptimizedFrameData,OptimizedFrameData,geomI,geomG,geomS,maxChangeX,maxChangeY,maxChangeZ);

% Running WeightOptimizer on frame with optimized geometry
fprintf("\n\nBEGINNING WEIGHT OPTIMIZER SIM\n\n");
[AreaMatrix,Weight,Stiffness,Ratio,OptimizedFrameData]=WeightOptimizer(DraftFrameData,OptimizedFrameData,weightI,weightG,weightS,TargetTS-500,false,includeSquareTubes);

% Exports optimized frame to TXT file for Solidworks macro
FinalOutputUtil(OptimizedFrameData,5);

fprintf("\nOPTIMIZATION SUITE HAS FINISHED OPTIMIZING YOUR SHITTY FRAME DRAFT\n\n");





