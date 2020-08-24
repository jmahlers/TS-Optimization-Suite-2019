function newCoord = CoordShiftUtil(oldCoord)

newCoord = oldCoord;
for i = 1:length(oldCoord)
    newCoord(i,:)=newCoord(i,:)+30;
end

newCoord;