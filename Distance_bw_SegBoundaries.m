function D = Distance_bw_SegBoundaries(inputGPSVector)

% inputGPSVector should be of nx2 [lat,Lon]

% We can use method 2 if we have heading information. then inpu vector
% should be nx3 [lat lon heading]

Data = inputGPSVector;
% Method 1 : Caluculate the Arc distance based on accumulating distance
%                       
temp = 0;
for i= 1: length(Data)-1
Dtemp = Distance_bw_2_GPSposition(Data(i,1),Data(i,2),Data(i+1,1),Data(i+1,2),'deg');
temp = temp + Dtemp;
end
D = temp;   % in meters


% % % % Method 2 : Caluculate based on X-Y meters     %%% THIS NEEDS HEADING INFORMATION
% temp3 = 0
% % % for i = 1:length(Data)-1
% % % [x(i), y(i)] = tc_convert_lat_lon_to_xy(deg2rad(Data(i,1)), deg2rad(Data(i,2)),deg2rad(Data(1,3)),deg2rad(Data(i+1,1)),deg2rad(Data(i+1,2)));
% % % d(i) =  sqrt(x(i)^2 + y(i)^2);
% % % temp3 = temp3+d(i);
% % % end
% % % D = temp3;



end