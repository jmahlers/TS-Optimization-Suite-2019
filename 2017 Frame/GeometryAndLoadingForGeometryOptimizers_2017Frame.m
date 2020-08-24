function D = GeometryAndLoadingForGeometryOptimizers_2017Frame(tubeThicknessMatrix, coordinateMatrix)
% Definition of Data

% Number of members and nodes
m = 107; n = 44;

% Nodal Coordinates (Organized in rows of 5)
Coord = coordinateMatrix';

% Connectivity (Organized in rows of 10)
Con=[ 1  2 1 1; 1  3 1 1; 1  5 1 1; 1  7 1 1; 2  4 1 1; 2  6 1 1; 2  8 1 1; 3  5 1 1; 3  4 1 1; 4  6 1 1;
      5  7 1 1; 6  8 1 1; 7  9 1 1; 8 10 1 1; 7 11 1 1; 8 11 1 1; 9 11 1 1;10 11 1 1; 9 12 1 1;10 13 1 1;
      5 12 1 1; 6 13 1 1; 3 14 1 1; 4 15 1 1; 5 14 1 1; 6 15 1 1;12 14 1 1;13 15 1 1;14 15 1 1; 9 16 1 1;
     10 17 1 1; 9 18 1 1;10 18 1 1;18 17 1 1;18 16 1 1; 9 19 1 1;10 20 1 1;12 19 1 1;13 20 1 1;14 19 1 1;
     15 20 1 1;16 19 1 1;17 20 1 1;19 22 1 1;20 23 1 1;19 24 1 1;20 25 1 1;16 22 1 1;17 23 1 1;16 21 1 1;
     17 21 1 1;21 23 1 1;21 22 1 1;22 24 1 1;23 25 1 1;22 26 1 1;23 27 1 1;22 28 1 1;23 29 1 1;24 28 1 1;
     25 29 1 1;26 28 1 1;27 29 1 1;24 36 1 1;25 37 1 1;37 33 1 1;36 32 1 1;36 37 1 1;28 32 1 1;33 32 1 1;
     29 33 1 1;26 30 1 1;27 31 1 1;28 34 1 1;29 35 1 1;28 30 1 1;30 34 1 1;29 31 1 1;31 35 1 1;30 31 1 1;
     26 44 1 1;30 44 1 1;41 44 1 1;31 44 1 1;37 39 1 1;25 39 1 1;24 38 1 1;36 38 1 1;26 40 1 1;27 41 1 1;
     34 42 1 1;35 43 1 1;
   %      1         2         3         4         5         6         7         8        9          0 
     % Tubes to simulate engine block
     39 38 1 1;39 41 1 1;39 40 1 1;39 43 1 1;39 42 1 1;
     38 41 1 1;38 40 1 1;38 43 1 1;38 42 1 1;
     40 42 1 1;40 43 1 1;40 41 1 1;
     41 42 1 1;41 43 1 1;
     42 43 1 1];

% Definition of Degree of freedom (free=0 &  fixed=1) (Organized in rows of 10)
Re= [0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
     0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
     0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;1 1 1 1 1 1;1 1 1 1 1 1;1 1 1 1 1 1;1 1 1 1 1 1;1 1 1 1 1 1;
     1 1 1 1 1 1;0 0 0 0 0 0;0 0 0 0 0 0;1 1 1 1 1 1;1 1 1 1 1 1;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
     0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;];
     
% Definition of Point Loads (Load) and Distributed Loads (w) (Organized in rows of 10)
nodeLoad = 250;
Load= [0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 nodeLoad 0 0 0;0 0 -nodeLoad 0 0 0;0 0 nodeLoad 0 0 0;0 0 -nodeLoad 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
       0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;];

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
D=struct('m',m,'n',n,'Coord',Coord','Con',Con','Re',Re','Load',Load','w',w','E',E','G',G','A',A','Iz',Iz','Iy',Iy','J',J','St',St','be',be','nodeLoad',nodeLoad');


