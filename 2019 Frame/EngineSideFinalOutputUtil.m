function EngineSideFinalOutputUtil(FrameData,scaleFactor)

% Prints final facts, figures, values and writes TXT file for output to Solidworks

TS = GetEngineSideTorsionalStiffness(FrameData);
W = GetWeight(FrameData);
Ratio = TS/W;
[~,V,~] = DirectStiffnessSolver(FrameData);
PlotDisplacement(FrameData,V,scaleFactor,true,true)

fprintf("\n\n\nFINAL OUTPUT\n");
fprintf("Torsional Stiffness:\t"+TS+" N*m/deg\n");
fprintf("Associated Weight:\t\t"+W+" lbs\n");
fprintf("Ratio (TS/Weight):\t\t"+Ratio+"\n\n");

EngineSideExportTXTFile(FrameData.Coord);

end