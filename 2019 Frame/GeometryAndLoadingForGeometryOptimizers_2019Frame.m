function D = GeometryAndLoadingForGeometryOptimizers_2019Frame(tubeThicknessMatrix, coordinateMatrix)
% Definition of Data

% Number of members and nodes
m = 141; n = 58;

% Nodal Coordinates
Coord = coordinateMatrix';

% Connectivity (Organized in rows of 10)
Con = [1 2 1 1
    1 5 1 1
    1 7 1 1
    2 4 1 1
    2 8 1 1
    2 6 1 1
    1 3 1 1
    3 4 1 1
    3 7 1 1
    3 20 1 1
    4 21 1 1
    4 8 1 1
    5 7 1 1
    5 9 1 1
    5 11 1 1
    6 8 1 1
    6 10 1 1
    6 11 1 1
    5 16 1 1 % delete
    7 16 1 1
    7 18 1 1
    7 12 1 1
    8 13 1 1
    8 19 1 1
    8 17 1 1
    6 17 1 1 % delete
    9 11 1 1
    9 14 1 1
    1 57 1 1 % delete
    10 11 1 1
    10 15 1 1
    2 58 1 1 % delete
    11 14 1 1
    11 15 1 1
    12 20 1 1
    12 18 1 1
    13 21 1 1
    13 19 1 1
    14 16 1 1
    14 25 1 1
    14 23 1 1
    14 22 1 1
    15 17 1 1
    15 24 1 1
    15 26 1 1
    15 22 1 1
    16 18 1 1
    16 23 1 1
    17 19 1 1
    17 24 1 1
    18 23 1 1
    18 20 1 1
    19 24 1 1
    19 21 1 1
    20 21 1 1
    20 23 1 1
    21 24 1 1
    22 25 1 1
    22 26 1 1
    23 25 1 1
    23 27 1 1
    24 26 1 1
    24 28 1 1
    25 27 1 1
    25 39 1 1
    25 41 1 1
    26 28 1 1
    26 40 1 1
    26 42 1 1
    27 29 1 1
    27 35 1 1
    27 37 1 1
    27 41 1 1
    28 30 1 1
    28 36 1 1
    28 38 1 1
    28 42 1 1
    29 31 1 1
    29 35 1 1
    30 32 1 1
    30 36 1 1
    31 33 1 1
    31 41 1 1
    32 34 1 1
    32 42 1 1
    33 34 1 1
    35 37 1 1
    35 36 1 1
    36 38 1 1
    39 41 1 1
    39 43 1 1
    39 47 1 1
    40 42 1 1
    40 48 1 1
    40 44 1 1
    41 45 1 1
    41 50 1 1
    41 55 1 1
    41 47 1 1
    42 46 1 1
    42 48 1 1
    42 51 1 1
    42 56 1 1
    43 47 1 1
    44 49 1 1
    44 48 1 1
    45 52 1 1
    45 50 1 1
    46 52 1 1
    46 51 1 1
    47 55 1 1
    47 53 1 1
    48 56 1 1
    48 54 1 1
    49 54 1 1
    50 52 1 1
    50 55 1 1
    51 52 1 1
    51 56 1 1
    52 55 1 1
    52 56 1 1
    53 55 1 1
    53 54 1 1
    54 56 1 1
    55 56 1 1
    39 49 1 1
    37 38 1 1
    37 43 1 1
    37 44 1 1
    37 45 1 1
    37 46 1 1
    38 43 1 1
    38 44 1 1
    38 45 1 1
    38 46 1 1
    43 44 1 1
    43 45 1 1
    43 46 1 1
    44 45 1 1
    44 46 1 1
    45 46 1 1];

% Definition of Degree of freedom (free=0 &  fixed=1) (Organized in rows of 10)
Re= [0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
     0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
     0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
     0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
     0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
     0 0 0 0 0 0;0 0 0 0 0 0;1 1 1 1 1 1;1 1 1 1 1 1;1 1 1 1 1 1;1 1 1 1 1 1;0 0 0 0 0 0;0 0 0 0 0 0;];
     
% Definition of Point Loads (Load) and Distributed Loads (w) (Organized in rows of 10)
nodeLoad = 100;
Load= [0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 -nodeLoad 0 0 0;0 0 nodeLoad 0 0 0;0 0 -nodeLoad 0 0 0;0 0 nodeLoad 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 -nodeLoad 0 0 0;0 0 nodeLoad 0 0 0;0 0 -nodeLoad 0 0 0;0 0 nodeLoad 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;];    

w = zeros(size(Con,1),3); 

% Definition of Modulus of Elasticity and Shear Modulus
% Material: 4130 Steel
E=ones(1,size(Con,1))*2.97e7;
G=ones(1,size(Con,1))*1.16e7;

% Std Areas (in^2)
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

% Change this matrix to experiment with different tube thicknesses
 A= tubeThicknessMatrix;

% DONT CHANGE ANYTHING BELOW THIS POINT
%--------------------------------------
% Std I-y, I-z (in^4)
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


