function [ left_lane_x, left_lane_y, right_lane_x, right_lane_y, vehicle_location_xy] =...
    cal_lane_xy_coordinate( D_PV_Lat, D_PV_Long, LL_Position,...
    RR_Position,D_Head,DS_index)

%% Convert GPS locations to xy
row = length(D_Head);
vehicle_location_xy = zeros(row,2);
vehicle_location_xy(1,1) = 0;
vehicle_location_xy(1,2) = 0;

for j = 2:row
    vehicle_location_xy(j,2) = (D_PV_Lat(j,1) - D_PV_Lat(1,1))*(110.575*1000);
    vehicle_location_xy(j,1) = (D_PV_Long(j,1) - D_PV_Long(1,1))*(82.4102*1000);
end

%% Lane Marker relative position generation
left_lane_location_xy = zeros(row,2);
right_lane_location_xy = zeros(row,2);

for k = 1:row
    
    left_lane_location_xy(k,1) = vehicle_location_xy(k,1) + 1.6*sin(deg2rad(D_Head(k)))...
        + LL_Position(DS_index(k))*cos(deg2rad(D_Head(k)));
    left_lane_location_xy(k,2) = vehicle_location_xy(k,2) + 1.6*cos(deg2rad(D_Head(k)))...
        - LL_Position(DS_index(k))*sin(deg2rad(D_Head(k))); %left lane
    
    right_lane_location_xy(k,1) = vehicle_location_xy(k,1) + 1.6*sin(deg2rad(D_Head(k)))...
        + RR_Position(DS_index(k))*cos(deg2rad(D_Head(k)));
    right_lane_location_xy(k,2) = vehicle_location_xy(k,2) + 1.6*cos(deg2rad(D_Head(k))) ...
        - RR_Position(DS_index(k))*sin(deg2rad(D_Head(k)));%right_lane

end

left_lane_x = left_lane_location_xy(:,1);
left_lane_y = left_lane_location_xy(:,2);
right_lane_x = right_lane_location_xy(:,1);
right_lane_y = right_lane_location_xy(:,2);


end

