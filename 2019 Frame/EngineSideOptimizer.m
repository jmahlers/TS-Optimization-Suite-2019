function [tubeThicknessMatrix,coordMatrix] = EngineSideOptimizer(tubeThicknessMatrix,coordMatrix,tradeOffIterations,maxChangeX,maxChangeY,maxChangeZ,geomI,geomG,geomS,weightI,weightG,weightS,TargetTS,includeSquareTubes)

AreaMatrix=[];
Weight=[];
Stiffness=[];
CoordMatrix=[];

OptimizedFrameData = EngineSideGeometryAndLoadingForGeometryOptimizers_2019Frame(tubeThicknessMatrix',coordMatrix);

 for i=1:tradeOffIterations
    if(i==1)
        [AreaMatrix,Weight,Stiffness,~]=EngineSideWeightOptimizer(OptimizedFrameData,OptimizedFrameData,weightI,weightG,weightS,TargetTS-10,false,includeSquareTubes);
    else
        [AreaMatrix,Weight,Stiffness,~]=EngineSideWeightOptimizer(OptimizedFrameData,OptimizedFrameData,weightI,weightG,weightS,Stiffness-10,false,includeSquareTubes);
    end
    OptimizedFrameData.A=AreaMatrix;
    fprintf("\n\nBEGINNING GEOMETRY OPTIMIZER SIM NUMBER: "+i+"\n\n");
    [CoordMatrix,~,Stiffness,~,OptimizedFrameData] = EngineSideGeometryOptimizer(OptimizedFrameData,OptimizedFrameData,geomI,geomG,geomS,maxChangeX,maxChangeY,maxChangeZ);
 end

tubeThicknessMatrix = OptimizedFrameData.A;
coordMatrix = OptimizedFrameData.Coord;





