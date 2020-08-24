
% Runs simulation once and plots displacement

% Solve for displacments
FrameData = SeatGeometryAndLoading_2019Frame;
[~,V,~] = DirectStiffnessSolver(FrameData);
Weight = GetWeight(FrameData);

zDisp = V(3,22);

fprintf("\nSeat Crossbrace Displacement:\t"+zDisp+" inches\n");
fprintf("\nWeight\t"+Weight+" lbs\n");

% Plot displacement
scaleFactor = 30;
PlotDisplacement(FrameData,V,scaleFactor,true,true);