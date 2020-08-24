function thicknessMatrix = IntToThicknessMatrix(intMatrix,numTubes,squareTubes)

% Tranforms integer matrix to thickness matrix

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

for i=1:numTubes
    if intMatrix(i) == 1
        intMatrix(i) = RD5x35;
    end
    if intMatrix(i) == 2
        intMatrix(i) = RD5x49;
    end
    if intMatrix(i) == 3
        intMatrix(i) = R75x35;
    end
    if intMatrix(i) == 4
        intMatrix(i) = R75x49;
    end
    if intMatrix(i) == 5
        intMatrix(i) = RD1x35;
    end
    if intMatrix(i) == 6
        if squareTubes
            intMatrix(i) = SQ1x35;
        else
            intMatrix(i) = RD1x49;
        end
    end
    if intMatrix(i) == 7
        intMatrix(i) = RD1x49;
    end
    if intMatrix(i) == 8
        if squareTubes
            intMatrix(i) = SQ1x49;
        else
            intMatrix(i) = RD1x65;
        end
    end
    if intMatrix(i) == 9
        intMatrix(i) = RD1x65;
    end
    if intMatrix(i) == 10
        if squareTubes
            intMatrix(i) = SQ1x65;
        else
            intMatrix(i) = RD1x83;
        end
    end
    if intMatrix(i) == 11
        intMatrix(i) = RD1x83;
    end
    if intMatrix(i) == 12
        intMatrix(i) = RD1x95;
    end
    if intMatrix(i) == 13
        intMatrix(i) = RD1120;
    end
    if intMatrix(i) == 14
        intMatrix(i) = RD1xSD;
    end
end
thicknessMatrix = intMatrix;