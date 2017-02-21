% Arc Distance(meters) between two GPS Locations (Elevations are not considered)
% Version-1.0 
% Copyrights Changan US R&D Center Inc,2016.
function D = Distance_bw_2_GPSposition(lat1,long1,lat2,long2,degorrad)
% This function used haversine's formula to caluculate the ARC Distance
R = 6371000; % Eart Radius in meteres
if (strcmp(degorrad,'deg'))
    dlat = degtorad(lat2-lat1);
    dlong = degtorad(long2-long1);
    lat1 = degtorad(lat1);
    lat2 = degtorad(lat2);
elseif (strcmp(degorrad,'rad'))
    dlat = lat2-lat1;
    dlong = long2-long1;  
else
    error('Input String Must be either ''deg'' or ''rad''');
end
a = (sin(dlat/2))^2 + (cos(lat1)*cos(lat2)*(sin(dlong/2)^2));
c = 2* atan2(sqrt(a),sqrt(1-a));
D = R*c; %Distance is in meters
end