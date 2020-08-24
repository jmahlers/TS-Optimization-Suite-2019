
% Run full optimizer suite from draft of frame
m=107; n=44;
numSims = 10;
TargetTS = 1200; % Aim low b/c the simulation shoots high

% Global parameters for genetic algorithms
maxChange = 3;
globalI = 15;
globalG = 75;
globalS = 5;

% Storage vars
RatioStorageGeom = zeros(1,numSims);
RatioStorageWeight = zeros(1,numSims);
TSStorage = zeros(1,numSims);
CoordMatrixStorageGeom = zeros(n,3,numSims);
AreaMatrixStorageWeight = zeros(numSims,m);

for i=1:numSims
    
    fprintf("\n\nBEGINNING GEOMETRY OPTIMIZER SIM "+i+"\n\n");
    
    DraftFrameData = GeometryAndLoading_2017Frame;
    FrameData = MinOptimizer(DraftFrameData.m,DraftFrameData.n,
    
    [CoordMatrix,Weight,Stiffness,Ratio] = GeometryOptimizer(FrameData,FrameData,globalI,globalG,globalS,i/(numSims/maxChange),i/(numSims/maxChange),i/(numSims/maxChange));
    FrameDataFromGeometry = GeometryAndLoadingForGeometryOptimizers_2017Frame(FrameData.A', CoordMatrix);
    FrameDataFromGeometry.Coord = FrameDataFromGeometry.Coord';
    TargetTS = GetTorsionalStiffness(FrameDataFromGeometry);
    [~,V,~] = DirectStiffnessSolver(FrameDataFromGeometry);
    PlotDisplacement(FrameDataFromGeometry,V,10,false,true);
    
    RatioStorageGeom(1,i) = Ratio;
    CoordMatrixStorageGeom(:,:,i) = CoordMatrix;
    TSStorage(1,i)=Stiffness;
end

for i=1:numSims
    
    fprintf("\n\nBEGINNING WEIGHT OPTIMIZER SIM "+i+"\n\n");
    
    min = GenerateMinThicknessMatrix(m);
    tubeThicknessMatrix = IntToThicknessMatrix(min);
    FrameData = GeometryAndLoadingForThicknessOptimizers_2017Frame(tubeThicknessMatrix);
    
    FrameDataFromGeometry = GeometryAndLoadingForGeometryOptimizers_2017Frame(FrameData.A', CoordMatrixStorageGeom(:,:,i)');
    [AreaMatrix,Weight,Stiffness,Ratio]=WeightOptimizer(FrameData,FrameDataFromGeometry,globalI,globalG,globalS,TSStorage(1,i)-1000);
    
    RatioStorageWeight(1,i) = Ratio;
    AreaMatrixStorageWeight(i,:) = AreaMatrix';
end


clear title xlabel ylabel;
figure('Name','Ratio vs Simulation Number (GeometryOptimizer)');
plot(RatioStorageGeom);
title('Ratio vs Simulation Number (GeometryOptimizer)');
xlabel('Iterations');
ylabel('Ratio (TS/Weight)')
grid ON; grid MINOR;

figure('Name','Ratio vs Simulation Number (WeightOptimizer)');
plot(RatioStorageWeight);
title('Ratio vs Simulation Number (WeightOptimizer)');
xlabel('Iterations');
ylabel('Ratio (TS/Weight)')
grid ON; grid MINOR;





