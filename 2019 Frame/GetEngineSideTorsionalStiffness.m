function TS = GetEngineSideTorsionalStiffness(FrameData)

[~,V,~] = DirectStiffnessSolver(FrameData);

% Compute angle of twist
% frontLower = rad2deg(asin(V(3,5)/(FrameData.Coord(2,5))));
% frontUpper = rad2deg(asin(V(3,7)/(FrameData.Coord(2,7))));
% backLower  = rad2deg(asin(V(3,14)/(FrameData.Coord(2,14))));
% backUpper  = rad2deg(asin(V(3,16)/(FrameData.Coord(2,16))));

heightAxis = 6.35; % 4.4; % inches

% Front Lower
Y = FrameData.Coord(2,39);
Z = FrameData.Coord(3,39);
deltaY = V(2,39);
deltaZ = V(3,39);
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
frontLower = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));

% Front Upper
Y = FrameData.Coord(2,41);
Z = FrameData.Coord(3,41);
deltaY = V(2,41);
deltaZ = V(3,41);
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
frontUpper = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));

% Back Lower
Y = FrameData.Coord(2,53);
Z = FrameData.Coord(3,53);
deltaY = V(2,53);
deltaZ = V(3,53);
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
backLower = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));

% Back Upper
Y = FrameData.Coord(2,55);
Z = FrameData.Coord(3,55);
deltaY = V(2,55);
deltaZ = V(3,55);
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
backUpper = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));

averageTwist = (frontLower+frontUpper+backLower+backUpper)/4;

% Compute torque
upperFrontBoxTorque = (FrameData.Coord(2,42)-FrameData.Coord(2,41))*FrameData.nodeLoad;
lowerFrontBoxTorque = (FrameData.Coord(2,40)-FrameData.Coord(2,39))*FrameData.nodeLoad;
upperBackBoxTorque  = (FrameData.Coord(2,56)-FrameData.Coord(2,55))*FrameData.nodeLoad;
lowerBackBoxTorque  = (FrameData.Coord(2,54)-FrameData.Coord(2,53))*FrameData.nodeLoad;

torque = abs(lowerFrontBoxTorque+upperFrontBoxTorque+upperBackBoxTorque+lowerBackBoxTorque);

% Divide for torsional stiffness
TS = (torque/averageTwist)*.112984788; % unit conversion factor for N*m/deg
