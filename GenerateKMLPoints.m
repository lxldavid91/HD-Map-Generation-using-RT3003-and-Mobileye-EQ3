% Generates Vehicle Points in KML Format
% Version-1.0
% Copyrights 2016-Changan US R&D Center Inc.
%This Function Generates KML Files with Locations 
KMLName = 'VehiclePoints11';
disp('Vehicle:-BLUE: ffff0000 , lane :- RED: ff0000ff \n')
Code = 'ff0000ff';
fID = fopen(strcat(KMLName,'.txt'),'wt');  % Open file in Write-mode
% XML Header
fprintf(fID, '<?xml version="1.0" encoding="UTF-8"?>\n<kml xmlns="http://earth.google.com/kml/2.2">\n');
fprintf(fID,'\t<Document>\n');
%Name of KML
fprintf(fID,strcat('\t\t<name>',KMLName,'</name>\n'));
% Style 
fprintf(fID,strcat('\t\t<Style id="',KMLName,'">\n'));
fprintf(fID,strcat('\t\t\t<IconStyle>\n\t\t\t\t<color>',Code,'</color>\n\t\t\t\t<scale>0.2</scale>\n'));      
fprintf(fID,'\t\t\t\t<Icon>\n\t\t\t\t\t<href>http://maps.google.com/mapfiles/kml/shapes/shaded_dot.png</href>\n');
fprintf(fID,'\t\t\t\t</Icon>\n\t\t\t\t<hotSpot x="0.5" y="0" xunits="fraction" yunits="fraction"/>\n');
fprintf(fID,'\t\t\t</IconStyle>\n\t\t</Style>\n');


for i = 1:length(Data)
    if (~isnan(Data(i,1)) || ~isnan(Data(i,2)))
    fprintf(fID,'\t\t<Placemark>\n');
    fprintf(fID,strcat('\t\t\t<styleUrl>#',KMLName,'</styleUrl>\n'));
    fprintf(fID,'\t\t\t<Point>\n');
    fprintf(fID,'\t\t\t\t<coordinates>');
    Points = strcat(num2str(Data(i,2),10),',',num2str(Data(i,1),10),'\n');   % Here 10 represents Precision of number being converted.. 
    fprintf(fID,Points);
    fprintf(fID,'</coordinates>\n');
    fprintf(fID,'\t\t\t</Point>\n');
    fprintf(fID,'\t\t</Placemark>\n');
    end
end
fprintf(fID,'\t\t</Document>\n');
fprintf(fID,'</kml>');
fclose('all');
