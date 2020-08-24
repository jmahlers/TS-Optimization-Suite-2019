function TS = GetTorsionalStiffness(FrameData)

[~,V,~] = DirectStiffnessSolver(FrameData);

% Compute angle of twist
frontLower = rad2deg(asin(V(3,7)/((FrameData.Coord(2,8)-FrameData.Coord(2,7))/2)));
frontUpper = rad2deg(asin(V(3,5)/((FrameData.Coord(2,6)-FrameData.Coord(2,5))/2)));
averageTwist = (frontLower+frontUpper)/2;

% Compute torque
upperBoxTorque = (FrameData.Coord(2,6)-FrameData.Coord(2,5))*FrameData.nodeLoad;
lowerBoxTorque = (FrameData.Coord(2,8)-FrameData.Coord(2,7))*FrameData.nodeLoad;
% backLower = rad2deg(asin(V(3,11)/((D.Coord(2,8)-D.Coord(2,7))/2)));
% backUpper = rad2deg(asin(V(3,16)/((D.Coord(2,6)-D.Coord(2,5))/2)));
torque = lowerBoxTorque+upperBoxTorque;

% Divide for torsional stiffness
TS = (torque/averageTwist)*.112984788; % unit conversion factor for N*m/deg
