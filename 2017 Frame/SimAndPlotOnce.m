
% Runs simulation once and plots displacement

% Solve for displacments
FrameData = GeometryAndLoading_2017Frame;
[Q,V,R] = DirectStiffnessSolver(FrameData);
TS = GetTorsionalStiffness(FrameData);
Weight = GetWeight(FrameData);

fprintf("\nTorsional Stiffness:\t"+TS+" N*m/deg\n");
fprintf("Weight:\t\t\t\t\t"+Weight+" lbs\n\n");
 
% Plot displacement
scaleFactor = 5;
PlotDisplacement(FrameData,V,scaleFactor, true, true);

%Exports the frame coordinates to a .txt file for the SolidWorks Macro
ExportTXTFile(FrameData.Coord)