
% Runs simulation once and plots displacement on the engine side

% Solve for displacments
FrameData = EngineSideGeometryAndLoading_2019Frame;
[~,V,~] = DirectStiffnessSolver(FrameData);
TS = GetEngineSideTorsionalStiffness(FrameData);
Weight = GetWeight(FrameData);

fprintf("\nTorsional Stiffness:\t"+TS+" N*m/deg\n");
fprintf("Weight:\t\t\t\t\t"+Weight+" lbs\n\n");
 
% Plot displacement
scaleFactor = 10;
PlotDisplacement(FrameData,V,scaleFactor, false,false);

%Exports the frame coordinates to a .txt file for the SolidWorks Macro
% ExportTXTFile(FrameData.Coord)