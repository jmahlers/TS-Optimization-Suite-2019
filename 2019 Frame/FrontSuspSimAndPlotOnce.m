
% Runs simulation once and plots displacement

% Solve for displacments
FrameData = FrontSuspGeometryAndLoading_2019Frame;
[~,V,~] = DirectStiffnessSolver(FrameData);
Weight = GetWeight(FrameData);

DamperY = V(2,12);
DamperZ = V(3,12);
DamperTotal = sqrt((DamperY)^2+(DamperZ)^2);

RockerY = V(2,9);
RockerZ = V(3,9);
RockerTotal = sqrt((RockerY)^2+(RockerZ)^2);

fprintf("\nDamper Total Displacement\t"+DamperTotal+" inches\n");
fprintf("\nRocker Total Displacement\t"+RockerTotal+" inches\n");
fprintf("\nWeight\t"+Weight+" lbs\n");

% Plot displacement
scaleFactor = 30;
PlotDisplacement(FrameData,V,scaleFactor,true,true);