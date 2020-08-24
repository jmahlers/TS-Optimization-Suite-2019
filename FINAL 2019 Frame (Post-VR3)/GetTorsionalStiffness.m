function TS = GetTorsionalStiffness(FrameData)

[~,V,~] = DirectStiffnessSolver(FrameData);

% Compute angle of twist
% frontLower = rad2deg(asin(V(3,5)/(FrameData.Coord(2,5))));
% frontUpper = rad2deg(asin(V(3,7)/(FrameData.Coord(2,7))));
% backLower  = rad2deg(asin(V(3,14)/(FrameData.Coord(2,14))));
% backUpper  = rad2deg(asin(V(3,16)/(FrameData.Coord(2,16))));

heightAxis = 6.35; % 6.35 % inches 

% Front Lower
Y = FrameData.Coord(2,5);
Z = FrameData.Coord(3,5);
deltaY = V(2,5);
deltaZ = V(3,5);
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
%frontLower = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));
frontLower=rad2deg(atan((abs(V(3,5))+abs(V(3,6)))/abs(2*FrameData.Coord(2,5))))

% Front Upper
Y = FrameData.Coord(2,7);
Z = FrameData.Coord(3,7);
deltaY = V(2,7);
deltaZ = V(3,7);
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
%frontUpper = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));
frontUpper=rad2deg(atan((abs(V(3,7))+abs(V(3,8)))/abs(2*FrameData.Coord(2,7))))

% Back Lower
Y = FrameData.Coord(2,14);
Z = FrameData.Coord(3,14);
deltaY = V(2,14);
deltaZ = V(3,14);
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
%backLower = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));
backLower=rad2deg(atan((abs(V(3,14))+abs(V(3,15)))/abs(2*FrameData.Coord(2,14))))


% Back Upper
Y = FrameData.Coord(2,16);
Z = FrameData.Coord(3,16);
deltaY = V(2,16);
deltaZ = V(3,16);
d0 = sqrt((Y)^2+(heightAxis-Z)^2);
totalDelta = sqrt((deltaY)^2+(deltaZ)^2);
d1 = sqrt((Y+deltaY)^2+(Z+deltaZ-heightAxis)^2);
%backUpper = rad2deg(acos(-((totalDelta)^2-(d1)^2-(d0)^2)/(2*d1*d0)));
backUpper=rad2deg(atan((abs(V(3,16))+abs(V(3,17)))/abs(2*FrameData.Coord(2,16))))

averageTwist = (frontLower+frontUpper+backLower+backUpper)/4;

% Compute torque
upperFrontBoxTorque = (FrameData.Coord(2,8)-FrameData.Coord(2,7))*FrameData.nodeLoad;
lowerFrontBoxTorque = (FrameData.Coord(2,6)-FrameData.Coord(2,5))*FrameData.nodeLoad;
upperBackBoxTorque  = (FrameData.Coord(2,17)-FrameData.Coord(2,16))*FrameData.nodeLoad;
lowerBackBoxTorque  = (FrameData.Coord(2,15)-FrameData.Coord(2,14))*FrameData.nodeLoad;

torque = abs(lowerFrontBoxTorque+upperFrontBoxTorque+upperBackBoxTorque+lowerBackBoxTorque);

% Divide for torsional stiffness
TS = (torque/averageTwist)*.112984788; % unit conversion factor for N*m/deg
