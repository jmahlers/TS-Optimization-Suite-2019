function minIntMatrix = GenerateMinThicknessMatrix(numTubes,squareTubes)

minIntMatrix = ones(1,numTubes);

RD5x35 = .051129; % 1
RD5x49 = .0694261;% 2
R75x35 = .078618; % 3
R75x49 = .1079106;% 4
RD1x35 = .106107; % 5
SQ1x35 = .1321857;% 6
RD1x49 = .146395; % 7
SQ1x49 = .179735; % 8 
RD1x65 = .19093;  % 9
SQ1x65 = .2330008;%10
RD1x83 = .239110; %11
RD1x95 = .270098; %12
RD1120 = .331752; %13
RD1xSD = .785398; %14

SquareTubeList = [6 8 10];

tubes95OrMore = [54 64 67 70 66 65 55 68 19 27 29 28 20];
    
tubes65OrMoreOr47Square = [1 5 9 2 30 48 36 42 44 38 46 40 31 49 37 43 45 39 47 41 69 71];

tubes47OrMore = [4 13 3 21 25 8 23 7 14 6 22 26 10 24 58 60 59 61];

engineTubes = numTubes-14:numTubes;

for i=1:length(tubes95OrMore)
    minIntMatrix(tubes95OrMore(i)) = 12;
end

for i=1:length(tubes65OrMoreOr47Square)
    if squareTubes
        minIntMatrix(tubes65OrMoreOr47Square(i)) = 8;
    else
        minIntMatrix(tubes65OrMoreOr47Square(i)) = 9;
    end
end

for i=1:length(tubes47OrMore)
    minIntMatrix(tubes47OrMore(i)) = 7;
end

for i=1:length(engineTubes)
    minIntMatrix(engineTubes(i)) = 14;
end

% for i=1:numTubes
%     if ~squareTubes
%         for j=1:length(SquareTubeList)
%             if minIntMatrix(i) == SquareTubeList(j)
%                 minIntMatrix(i) = minIntMatrix(i)+1;
%             end
%         end
%     end
% end
%     

end