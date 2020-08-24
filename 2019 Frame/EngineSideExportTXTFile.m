function EngineSideExportTXTFile(CoordMatrix)
    CoordMatrix = abs(CoordMatrix);
    framePoints = CoordMatrix(:);
    dlmwrite('toSolidworksEngineSide.txt', framePoints','delimiter','\t')
end