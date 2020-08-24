
% Runs simulation once and plots displacement

% Solve for displacments
FrameData = SteeringSupportsGeometryAndLoading_2019Frame;
[~,V,~] = DirectStiffnessSolver(FrameData);

xDisp = V(1,3);
zDisp = V(3,3);
totalDisp = sqrt((xDisp^2)+(zDisp^2));

fprintf("\nSteering Supports Displacement:\t"+totalDisp+" inches\n");

% Plot displacement
scaleFactor = 5;
PlotDisplacement(FrameData,V,scaleFactor,true,true);