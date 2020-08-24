function D = SteeringSupportsGeometryAndLoading_2019Frame
% Definition of Data

% Number of members and nodes
m = 2; n = 3;

% Nodal Coordinates
Coord = [46.5444, -2.5, 23.75;
    46.5444, 2.5, 23.75;
    49.6479, 0, 17.6024;];
    

% Connectivity (Organized in rows of 10)
Con = [1 3 1 1; 2 3 1 1;];

% Definition of Degree of freedom (free=0 &  fixed=1) (Organized in rows of 10)
Re= [1 1 1 1 1 1;1 1 1 1 1 1;0 0 0 0 0 0;];
     
% Definition of Point Loads (Load) and Distributed Loads (w) (Organized in rows of 10)
nodeLoad = 200;
xLoad = nodeLoad*cos(deg2rad(26));
zLoad = nodeLoad*sin(deg2rad(26));
Load= [0 0 0 0 0 0;0 0 0 0 0 0;-xLoad 0 -zLoad 0 0 0;];   

w = zeros(size(Con,1),3); 

% Definition of Modulus of Elasticity and Shear Modulus
% Material: 4130 Steel
E=ones(1,size(Con,1))*2.97e7;
G=ones(1,size(Con,1))*1.16e7;

% Std Areas (in^2)
DELETE = .0000001;
RD5x35 = .051129;
RD5x49 = .0694261;
R75x35 = .078618;
R75x49 = .1079106;
RD1x35 = .106107;
RD1x49 = .146395;
RD1x65 = .19093;
RD1x83 = .239110;
RD1x95 = .270098;
RD1120 = .331752;
RD1xSD = .785398;
SQ1x35 = 0.1321857;
SQ1x49 = 0.1806335;
SQ1x65 = 0.2330008;







% Definition of Area (Organized in rows of 10)
A= [RD1x49 RD1x49];


% DONT CHANGE ANYTHING BELOW THIS POINT
%--------------------------------------
% Std I-y, I-z (in^4)
IELETE = 0.0000001;
ID5x35 = 0.0013898;
ID5x49 = 0.0017860;
I75x35 = 0.0050360;
I75x49 = 0.0066608;
ID1x35 = 0.0123675;
ID1x49 = 0.0165939;
ID1x65 = 0.0209653;
ID1x83 = 0.0253390;
ID1x95 = 0.0279569;
ID1120 = 0.0327108;
ID1xSD = 0.0490874;
IQ1x35 = 0.0202877;
IQ1x49 = 0.0267870;
IQ1x65 = 0.0331999;

% Std J
JELETE = 0.0000001;
JD5x35 = 0.0027795;
JD5x49 = 0.0035720;
J75x35 = 0.0100720;
J75x49 = 0.0133216;
JD1x35 = 0.0247349;
JD1x49 = 0.0331878;
JD1x65 = 0.0419307;
JD1x83 = 0.0506780;
JD1x95 = 0.0559138;
JD1120 = 0.0654215;
JD1xSD = 0.0981748;
JQ1x35 = 0.0405755;
JQ1x49 = 0.0535739;
JQ1x65 = 0.0663999;

Iy=zeros(1,m);Iz=zeros(1,m);J=zeros(1,m);

for i=1:m
    if A(i) == DELETE
        Iy(i)=IELETE;Iz(i)=IELETE;J(i)=JELETE;
    end
    if A(i) == RD5x35
        Iy(i)=ID5x35;Iz(i)=ID5x35;J(i)=JD5x35;
    end
    if A(i) == RD5x49
        Iy(i)=ID5x49;Iz(i)=ID5x49;J(i)=JD5x49;
    end
    if A(i) == R75x35
        Iy(i)=I75x35;Iz(i)=I75x35;J(i)=J75x35;
    end
    if A(i) == R75x49
        Iy(i)=I75x49;Iz(i)=I75x49;J(i)=J75x49;
    end
    if A(i) == RD1x35
        Iy(i)=ID1x35;Iz(i)=ID1x35;J(i)=JD1x35;
    end
    if A(i) == RD1x49
        Iy(i)=ID1x49;Iz(i)=ID1x49;J(i)=JD1x49;
    end
    if A(i) == RD1x65
        Iy(i)=ID1x65;Iz(i)=ID1x65;J(i)=JD1x65;
    end
    if A(i) == RD1x83
        Iy(i)=ID1x83;Iz(i)=ID1x83;J(i)=JD1x83;
    end
    if A(i) == RD1x95
        Iy(i)=ID1x95;Iz(i)=ID1x95;J(i)=JD1x95;
    end
    if A(i) == RD1120
        Iy(i)=ID1120;Iz(i)=ID1120;J(i)=JD1120;
    end
    if A(i) == RD1xSD
        Iy(i)=ID1xSD;Iz(i)=ID1xSD;J(i)=JD1xSD;
    end
    if A(i) == SQ1x35
        Iy(i)=IQ1x35;Iz(i)=IQ1x35;J(i)=JQ1x35;
    end
    if A(i) == SQ1x49
        Iy(i)=IQ1x49;Iz(i)=IQ1x49;J(i)=JQ1x49;
    end
    if A(i) == SQ1x65
        Iy(i)=IQ1x65;Iz(i)=IQ1x65;J(i)=JQ1x65;
    end
end

% Refer to Help_DirectStiffnessSolver for help with these:
St=zeros(n,6);
be=zeros(1,m);

% Convert to structure array
D=struct('m',m,'n',n,'Coord',Coord','Con',Con','Re',Re','Load',Load','w',w','E',E','G',G','A',A','Iz',Iz','Iy',Iy','J',J','St',St','be',be','nodeLoad',nodeLoad);


