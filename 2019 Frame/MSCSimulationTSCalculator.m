% Compute angle of twist
% frontLower = rad2deg(asin(V(3,5)/(FrameData.Coord(2,5))));
% frontUpper = rad2deg(asin(V(3,7)/(FrameData.Coord(2,7))));
% backLower  = rad2deg(asin(V(3,14)/(FrameData.Coord(2,14))));
% backUpper  = rad2deg(asin(V(3,16)/(FrameData.Coord(2,16))));

format shortg;

heightAxis = 6.35; % 8.3; % inches

% Front Lower
Y = 6.9285;
Z = 4.8199;
deltaY = 0.02275015;
deltaZ = 0.1482921;
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
frontLower = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));

% Front Upper
Y = 8.6903;
Z = 8.93157;
deltaY = 0.03056864;
deltaZ = 0.1726878;
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
frontUpper = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));

% Back Lower
Y = 6.928541;
Z = 4.8199;
deltaY = 0.01729197;
deltaZ = 0.1129116;
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
backLower = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));

% Back Upper
Y = 8.583848;
Z = 8.907314;
deltaY = 0.02469699;
deltaZ = 0.1290311;
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
backUpper = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));

averageTwist = (frontLower+frontUpper+backLower+backUpper)/4;


upperFrontBoxTorque = 2*8.6903*250;
lowerFrontBoxTorque = 2*6.9285*250;
upperBackBoxTorque  = 2*8.5838*250;
lowerBackBoxTorque  = 2*6.9285*250;

%Torque in inlbs
torque = abs(lowerFrontBoxTorque+upperFrontBoxTorque+upperBackBoxTorque+lowerBackBoxTorque)

% Divide for torsional stiffness
TS = (torque/averageTwist)*.112984788 % unit conversion factor for N*m/deg











