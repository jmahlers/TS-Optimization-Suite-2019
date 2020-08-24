% Compute angle of twist
% frontLower = rad2deg(asin(V(3,5)/(FrameData.Coord(2,5))));
% frontUpper = rad2deg(asin(V(3,7)/(FrameData.Coord(2,7))));
% backLower  = rad2deg(asin(V(3,14)/(FrameData.Coord(2,14))));
% backUpper  = rad2deg(asin(V(3,16)/(FrameData.Coord(2,16))));

heightAxis = 6.35; % 8.3; % inches

% Front Lower
Y = 8.45;
Z = 5.511;
deltaY = .22455;
deltaZ = .195116;
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
frontLower = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));

% Front Upper
Y = 10.247;
Z = 13.115;
deltaY = .37155;
deltaZ = .229593;
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
frontUpper = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));

% Back Lower
Y = 8.45;
Z = 5.511;
deltaY = .20716;
deltaZ = .14957;
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
backLower = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));

% Back Upper
Y = 10.247;
Z = 13.115;
deltaY = .33431;
deltaZ = .179588;
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
backUpper = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));

averageTwist = (frontLower+frontUpper+backLower+backUpper)/4;

load = 100;
upperFrontBoxTorque = 2*10.247*load;
lowerFrontBoxTorque = 2*8.45*load;
upperBackBoxTorque  = 2*10.247*load;
lowerBackBoxTorque  = 2*8.45*load;

torque = abs(lowerFrontBoxTorque+upperFrontBoxTorque+upperBackBoxTorque+lowerBackBoxTorque);

% Divide for torsional stiffness
TS = (torque/averageTwist)*.112984788 % unit conversion factor for N*m/deg











