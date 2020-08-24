function ExportTXTFile(CoordMatrix)
    CoordMatrix = abs(CoordMatrix);
    framePoints = CoordMatrix(:);
    dlmwrite('toSolidworks.txt', framePoints','delimiter','\t')
end