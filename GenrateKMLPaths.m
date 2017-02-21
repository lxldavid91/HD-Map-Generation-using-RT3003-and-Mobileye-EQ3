function GenrateKMLPaths(Data)
OutputKML = 'VehiclePath';
fID = fopen(OutputKML,'wt');  % Open file in Write-mode
% XML Header
fprintf(fID, '<?xml version="1.0" encoding="UTF-8"?>\n<kml xmlns="http://earth.google.com/kml/2.2">\n');
fprintf(fID,'\t<Document>\n');
KMLName = 'VehiclePathLanes';
%Name of KML
fprintf(fID,strcat('\t\t<name>',KMLName,'</name>\n'));
% Style -TX
fprintf(fID,strcat('\t\t<Style id="',KMLName,'">\n'));
Code = 'ffff0000';
fprintf(fID,strcat('\t\t\t<LineStyle>\n\t\t\t\t<color>',Code,'</color>\n\t\t\t\t<width>4</width>\n'));      % RED COLOR
fprintf(fID,'\t\t\t</LineStyle>\n\t\t\t<PolyStyle>\n\t\t\t\t<color>7f00ff00</color>\n\t\t\t</PolyStyle>\n\t\t</Style>\n');

fprintf(fID,'\t\t<Placemark>\n');
fprintf(fID,strcat('\t\t\t<styleUrl>#',KMLName,'</styleUrl>\n')); 
fprintf(fID,'\t\t\t<LineString>\n\t\t\t\t<extrude>1</extrude>\n');
fprintf(fID,'\t\t\t\t<tessellate>1</tessellate>\n');
fprintf(fID,'\t\t\t\t<altitudeMode>absolute</altitudeMode>\n');
fprintf(fID,'\t\t\t\t<coordinates>');
for i = 1:length(Data)    
    Points = strcat(num2str(Data(i,2),9),',',num2str(Data(i,1),9),'\n');
    if (i==1)
        fprintf(fID,Points);
    else
        fprintf(fID,strcat('\t\t\t\t\t\t\t',Points));
    end
end
fprintf(fID,'\t\t\t\t</coordinates>\n');
fprintf(fID,'\t\t\t</LineString>\n');
fprintf(fID,'\t\t</Placemark>\n');
fprintf(fID,'\t\t</Document>\n');
fprintf(fID,'</kml>');
fclose('all');
end