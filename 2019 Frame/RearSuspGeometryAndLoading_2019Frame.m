function D = RearSuspGeometryAndLoading_2019Frame
% Definition of Data

% Number of members and nodes
m = 141; n = 58;

% Nodal Coordinates
Coord=[16.0102500000000,-7,4.84913720000000;16.0102500000000,7,4.84913720000000;16.0102500000000,-7,16.8491370000000;16.0102500000000,7,16.8491370000000;33.7601000000000,-7.20940000000000,4.84350000000000;33.7601000000000,7.20940000000000,4.84350000000000;33.3202000000000,-8.90550000000000,8.98060000000000;33.3202000000000,8.90550000000000,8.98060000000000;40.2000000000000,-7.18490000000000,4.84140000000000;40.2000000000000,7.18490000000000,4.84140000000000;37.8496500000000,0,3.84140000000000;40.2000000000000,-9.15000000000000,17;40.2000000000000,9.15000000000000,17;43.9119000000000,-7.17080000000000,4.84020000000000;43.9119000000000,7.17080000000000,4.84020000000000;44.1331000000000,-8.82040000000000,8.96120000000000;44.1331000000000,8.82040000000000,8.96120000000000;44.6600000000000,-8.69710000000000,12.5000000000000;44.6600000000000,8.69710000000000,12.5000000000000;46.2965890000000,-6.59067900000000,22.6329950000000;46.2965890000000,6.59067900000000,22.6329950000000;58.9150800000000,0,3.15839000000000;58.8976500000000,-13.5537000000000,13.7336500000000;58.8976500000000,13.5537000000000,13.7336500000000;72.7500000000000,-14,2;72.7500000000000,14,2;72.7500000000000,-12.7646987870029,11.9958000000000;72.7500000000000,12.7646987870029,11.9958000000000;72.7500000000000,-10.6250000000000,22;72.7500000000000,10.6250000000000,22;72.7500000000000,-4.03610000000000,37.2000000000000;72.7500000000000,4.03610000000000,37.2000000000000;72.7500000000000,-2.66660000000000,43;72.7500000000000,2.66660000000000,43;75.4773400000000,-9.85235000000000,22;75.4773400000000,9.85235000000000,22;79.3059500000000,-8.01750000000000,14.8750000000000;78.6299500000000,7.99802000000000,14.3800000000000;91.6254000000000,-6.23783300000000,5.93862000000000;91.6254000000000,6.23783000000000,5.93862000000000;93.7682700000000,-9.05647000000000,10.9688500000000;93.7682700000000,9.05647000000000,10.9688500000000;93.1412500000000,-3.65650000000000,7.17710000000000;93.1412500000000,3.65650000000000,7.17710000000000;93.1232500000000,-4.26250000000000,16.4000000000000;93.1232550000000,4.52500000000000,16.4000000000000;97.4434400000000,-6.23783000000000,4.93862000000000;97.4434400000000,6.23783000000000,4.93860000000000;98.0065483050527,0,4.93860000000000;99.5000000000000,-6.71813000000000,13.6179800000000;99.5000000000000,6.71813000000000,13.6179800000000;99.5000000000000,0,17;103.443440000000,-6.23783000000000,5.93860000000000;103.443400000000,6.23783000000000,5.93860000000000;105.572100000000,-9.05647000000000,10.9688000000000;105.572100000000,9.05647000000000,10.9688000000000;16,-7,4.84913720000000;16,7,4.84913720000000];

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
Re= [0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;1 1 1 1 1 1;1 1 1 1 1 1;1 1 1 1 1 1;1 1 1 1 1 1;0 0 0 0 0 0;0 0 0 0 0 0;
     0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;1 1 1 1 1 1;1 1 1 1 1 1;1 1 1 1 1 1;1 1 1 1 1 1;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
     0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
     0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;1 1 1 1 1 1;1 1 1 1 1 1;
     0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
     0 0 0 0 0 0;0 0 0 0 0 0;1 1 1 1 1 1;1 1 1 1 1 1;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;];
     
% Definition of Point Loads (Load) and Distributed Loads (w) (Organized in rows of 10)
nodeLoad = 100;
Load= [0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 -166.3 638.4 0 0 0;
       0 0 0 0 0 0;0 893.5 -108.12 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;];   

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
A= [SQ1x49,     0.146395,   0.146395,   SQ1x49,     0.146395,   0.146395,   SQ1x49,     SQ1x49,     0.146395,   0.23911...
    0.23911,    0.146395,   0.146395,   0.146395,   0.051129,   0.146395,   0.146395,   0.051129,   0.19093,    0.19093...
    0.146395,   0.146395,   0.146395,   0.146395,   0.19093,    0.19093,    0.051129,   0.146395,   0.051129,   0.051129...
    0.146395,   0.051129,   0.051129,   0.051129,   0.146395,   0.051129,   0.146395,   0.051129,   0.270098,   0.19093...
    0.19093,    0.051129,   0.270098,   0.19093,    0.19093,    0.051129,   0.270098,   0.051129,   0.270098,   0.051129...
    0.19093,    0.270098,   0.19093,    0.270098,   0.270098,   0.1079106,  0.1079106,  0.051129,   0.051129,   0.19093...
    0.23911,    0.19093,    0.23911,    0.270098,   0.106107,   0.146395,   0.270098,   0.106107,   0.146395,   0.270098...
    0.270098,   0.051129,   0.146395,   0.270098,   0.270098,   0.051129,   0.146395,   0.270098,   0.270098,   0.270098...
    0.270098,   0.270098,   0.19093,    0.270098,   0.19093,    0.270098,   0.051129,   0.270098,   0.051129,   0.051129...
    0.146395,   0.051129,   0.051129,   0.051129,   0.146395,   RD1x35,     RD1x35,     0.146395,   0.051129,   RD1x35...
    0.051129,   RD1x35,     0.146395,   0.051129,   0.051129,   0.051129,   RD1x35,     RD1x35,     RD1x35,     RD1x35...
    0.051129,   0.051129,   0.051129,   0.051129,   0.0694261,  0.051129,   RD1x35,     0.051129,   RD1x35,     RD1x35...
    RD1x35,     0.051129,   RD1x35,     0.051129,   RD1x35,     0.0694261...
    0.785398,   0.785398,0.785398,0.785398,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000];



% % Original from Final Geometry Simulations
% 
% A=[0.146395,0.146395,0.146395,0.146395,0.146395, 0.146395,0.146395,0.19093,0.146395,0.23911...
%    0.23911, 0.146395,0.146395,0.146395,0.051129, 0.146395,0.146395,0.051129,0.19093,0.19093...
%    0.146395,0.146395,0.146395,0.146395,0.19093,  0.19093,0.051129,0.146395,0.051129,0.051129...
%    0.146395,0.051129,0.051129,0.051129,0.146395, 0.051129,0.146395,0.051129,0.270098,0.19093...
%    0.19093, 0.051129,0.270098,0.19093, 0.19093,  0.051129,0.270098,0.051129,0.270098,0.051129...
%    0.19093, 0.270098,0.19093, 0.270098,0.270098, 0.1079106,0.1079106,0.051129,0.051129,0.19093...
%    0.23911, 0.19093, 0.23911, 0.270098,0.106107, 0.146395,0.270098,0.106107,0.146395,0.270098...
%    0.270098,0.051129,0.146395,0.270098,0.270098, 0.051129,0.146395,0.270098,0.270098,0.270098...
%    0.270098,0.270098,0.19093, 0.270098,0.19093,  0.270098,0.051129,0.270098,0.051129,0.051129...
%    0.146395,0.051129,0.051129,0.051129,0.146395, 0.051129,0.051129,0.146395,0.051129,0.051129...
%    0.051129,0.051129,0.146395,0.051129,0.051129, 0.051129,0.051129,0.051129,0.051129,0.051129...
%    0.051129,0.051129,0.051129,0.051129,0.0694261,0.051129,0.051129,0.051129,0.051129,0.051129...
%    0.051129,0.051129,0.051129,0.051129,0.051129, 0.0694261...
%    
%    
%    0.785398,0.785398,0.785398,0.785398,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000,0.785398000000000];


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


