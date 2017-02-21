function [LaneGPS,Lane_curv] =  FindLaneGPS(Current_Lane_Stuct)



Lane_curv = Current_Lane_Stuct.curvature';   % NEED TO VERIFY CURVATURE HERE AS Curvature <> No of Points
seg_samp_num_target = length(Lane_curv);
lane_start_pt = Current_Lane_Stuct.start_end_point(1,:);
lane_end_pt   = Current_Lane_Stuct.start_end_point(2,:);


lane_start_pt_lat = lane_start_pt(1,1);
lane_end_pt_lat = lane_end_pt(1,1);


lane_poly_GPS = Current_Lane_Stuct.poly_para_GPS;


Lane_x = zeros(seg_samp_num_target,1);
Lane_y = zeros(seg_samp_num_target,1);


lane_x_space = (lane_end_pt_lat - lane_start_pt_lat)/(seg_samp_num_target -1);


for n = 1:seg_samp_num_target
    Lane_x(n,1) = lane_start_pt_lat + lane_x_space*(n-1);
    
    %%%% FOR 5 polynomial Coeffecients
    Lane_y(n,1) = lane_poly_GPS(1)*Lane_x(n)^4 + lane_poly_GPS(2)*Lane_x(n)^3 + ...
        lane_poly_GPS(3)*Lane_x(n)^2 + lane_poly_GPS(4)*Lane_x(n) + lane_poly_GPS(5);   
    
    % FOR 3 Polynomial Coeffecients
    %Lane_y(n,1) = lane_poly_GPS(1)*Lane_x(n)^2 + lane_poly_GPS(2)*Lane_x(n)^1 + lane_poly_GPS(3);
      
end

LaneGPS = [Lane_x Lane_y];

end

