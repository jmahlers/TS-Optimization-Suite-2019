function ExportTXTFile(CoordMatrix)
    framePoints = CoordMatrix(:);
    dlmwrite('toSolidworks.txt', framePoints','delimiter','\t')
end