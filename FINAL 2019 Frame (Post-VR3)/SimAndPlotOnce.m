
% Runs simulation once and plots displacement

% Solve for displacments
FrameData = GeometryAndLoading_2019FinalFrame;
[~,V,~] = DirectStiffnessSolver(FrameData);
TS = GetTorsionalStiffness(FrameData);
Weight = GetWeight(FrameData);

fprintf("\nTorsional Stiffness:\t"+TS+" N*m/deg\n");
fprintf("Weight:\t\t\t\t\t"+Weight+" lbs\n\n");

% Plot displacement
scaleFactor = 10;
PlotDisplacement(FrameData,V,scaleFactor, true, true);

