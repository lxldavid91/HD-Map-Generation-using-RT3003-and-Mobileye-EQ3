function [Center_GPS_Points, LL_xy, RL_xy, Current_NLL_GPS, Current_NRL_GPS...
    ,LL_curv, RL_curv] =  Lane_Regeneration...
    (Current_LL_Stuct, Current_RL_Stuct, Current_NL_Struct_1, Current_NL_Struct_2,...
    current_gps_lat,current_gps_long)

seg_samp_num = 20;
seg_samp_num_target = Current_LL_Stuct.seg_samp_num_target;

LL_curv = Current_LL_Stuct.curvature';
RL_curv = Current_RL_Stuct.curvature';

ll_start_pt = Current_LL_Stuct.start_end_point(1,:);
ll_end_pt   = Current_LL_Stuct.start_end_point(2,:);

rl_start_pt = Current_RL_Stuct.start_end_point(1,:);
rl_end_pt   = Current_RL_Stuct.start_end_point(2,:);

NLL_start_1 = Current_NL_Struct_1.NLL_start_end_point(1,:);
NLL_end_1 = Current_NL_Struct_1.NLL_start_end_point(2,:);
NLL_start_2 = Current_NL_Struct_2.NLL_start_end_point(1,:);
NLL_end_2 = Current_NL_Struct_2.NLL_start_end_point(2,:);

NRL_start_1 = Current_NL_Struct_1.NRL_start_end_point(1,:);
NRL_end_1 = Current_NL_Struct_1.NRL_start_end_point(2,:);
NRL_start_2 = Current_NL_Struct_2.NRL_start_end_point(1,:);
NRL_end_2 = Current_NL_Struct_2.NRL_start_end_point(2,:);

ll_start_pt_lat = ll_start_pt(1,1);
ll_end_pt_lat = ll_end_pt(1,1);

rl_start_pt_lat = rl_start_pt(1,1);
rl_end_pt_lat = rl_end_pt(1,1);

ll_poly_GPS = Current_LL_Stuct.poly_para_GPS;
rl_poly_GPS = Current_RL_Stuct.poly_para_GPS;

NLL_poly_GPS_1 = Current_NL_Struct_1.NLL_poly_para_GPS;
NRL_poly_GPS_1 = Current_NL_Struct_1.NRL_poly_para_GPS;
NLL_poly_GPS_2 = Current_NL_Struct_2.NLL_poly_para_GPS;
NRL_poly_GPS_2 = Current_NL_Struct_2.NRL_poly_para_GPS;

NLL_x_1 = zeros(seg_samp_num,1);
NLL_y_1 = zeros(seg_samp_num,1);
NRL_x_1 = zeros(seg_samp_num,1);
NRL_y_1 = zeros(seg_samp_num,1);
NLL_x_2 = zeros(seg_samp_num,1);
NLL_y_2 = zeros(seg_samp_num,1);
NRL_x_2 = zeros(seg_samp_num,1);
NRL_y_2 = zeros(seg_samp_num,1);
    
LL_x = zeros(seg_samp_num_target,1);
LL_y = zeros(seg_samp_num_target,1);
RL_x = zeros(seg_samp_num_target,1);
RL_y = zeros(seg_samp_num_target,1);

ll_x_space = (ll_end_pt_lat - ll_start_pt_lat)/(seg_samp_num_target -1);
rl_x_space = (rl_end_pt_lat - rl_start_pt_lat)/(seg_samp_num_target -1);

NLL_x_space_1 = (NLL_end_1(1,1) - NLL_start_1(1,1))/(seg_samp_num -1);
NRL_x_space_1 = (NRL_end_1(1,1) - NRL_start_1(1,1))/(seg_samp_num -1);
NLL_x_space_2 = (NLL_end_2(1,1) - NLL_start_2(1,1))/(seg_samp_num -1);
NRL_x_space_2 = (NRL_end_2(1,1) - NRL_start_2(1,1))/(seg_samp_num -1);


for n = 1:seg_samp_num_target
    
    LL_x(n,1) = ll_start_pt_lat + ll_x_space*(n-1);
    LL_y(n,1) = ll_poly_GPS(1)*LL_x(n)^4 + ll_poly_GPS(2)*LL_x(n)^3 + ...
        ll_poly_GPS(3)*LL_x(n)^2 + ll_poly_GPS(4)*LL_x(n) + ll_poly_GPS(5);
    RL_x(n,1) = rl_start_pt_lat + rl_x_space*(n-1);
    RL_y(n,1) = rl_poly_GPS(1)*RL_x(n)^4 + rl_poly_GPS(2)*RL_x(n)^3 + ...
        rl_poly_GPS(3)*RL_x(n)^2 + rl_poly_GPS(4)*RL_x(n) + rl_poly_GPS(5);
    
end
    
    
for n = 1:seg_samp_num 
    
    NLL_x_1(n,1) = NLL_start_1(1,1) + NLL_x_space_1*(n-1);
    NLL_y_1(n,1) = NLL_poly_GPS_1(1)*NLL_x_1(n)^4 + NLL_poly_GPS_1(2)*NLL_x_1(n)^3 +...
        NLL_poly_GPS_1(3)*NLL_x_1(n)^2 + NLL_poly_GPS_1(4)*NLL_x_1(n) + NLL_poly_GPS_1(5);
    
    NRL_x_1(n,1) = NRL_start_1(1,1) + NRL_x_space_1*(n-1);
    NRL_y_1(n,1) = NRL_poly_GPS_1(1)*NRL_x_1(n)^4 + NRL_poly_GPS_1(2)*NRL_x_1(n)^3 +...
        NRL_poly_GPS_1(3)*NRL_x_1(n)^2 + NRL_poly_GPS_1(4)*NRL_x_1(n) + NRL_poly_GPS_1(5);
    
    NLL_x_2(n,1) = NLL_start_2(1,1) + NLL_x_space_2*(n-1);
    NLL_y_2(n,1) = NLL_poly_GPS_2(1)*NLL_x_2(n)^4 + NLL_poly_GPS_2(2)*NLL_x_2(n)^3 +...
        NLL_poly_GPS_2(3)*NLL_x_2(n)^2 + NLL_poly_GPS_2(4)*NLL_x_2(n) + NLL_poly_GPS_2(5);
    
    NRL_x_2(n,1) = NRL_start_2(1,1) + NRL_x_space_2*(n-1);
    NRL_y_2(n,1) = NRL_poly_GPS_2(1)*NRL_x_2(n)^4 + NRL_poly_GPS_2(2)*NRL_x_2(n)^3 +...
        NRL_poly_GPS_2(3)*NRL_x_2(n)^2 + NRL_poly_GPS_2(4)*NRL_x_2(n) + NRL_poly_GPS_2(5);
    
    
end

LL_xy = [LL_x LL_y];
RL_xy = [RL_x RL_y];

NLL_xy_1 = [NLL_x_1 NLL_y_1];
NRL_xy_1 = [NRL_x_1 NRL_y_1];
NLL_xy_2 = [NLL_x_2 NLL_y_2];
NRL_xy_2 = [NRL_x_2 NRL_y_2];

%To choose which part of highway should we use
dis_hgw_1 = sqrt(((current_gps_lat - NLL_x_1(1))*(110.575*1000))^2 + ...
    ((current_gps_long - NLL_y_1(1))*(82.4102*1000))^2) + sqrt(((current_gps_lat...
    - NRL_x_1(1))*(110.575*1000))^2 + ...
    ((current_gps_long - NRL_y_1(1))*(82.4102*1000))^2);

dis_hgw_2 = sqrt(((current_gps_lat - NLL_x_2(1))*(110.575*1000))^2 + ...
    ((current_gps_long - NLL_y_2(1))*(82.4102*1000))^2) + sqrt(((current_gps_lat...
    - NRL_x_2(1))*(110.575*1000))^2 + ...
    ((current_gps_long - NRL_y_2(1))*(82.4102*1000))^2);

if(dis_hgw_1<dis_hgw_2)
    
    Current_NLL_GPS = NLL_xy_1;
    Current_NRL_GPS = NRL_xy_1; 
 
else
    
    Current_NLL_GPS = NLL_xy_2;
    Current_NRL_GPS = NRL_xy_2; 
    
end


Center_GPS_Points = (LL_xy + RL_xy)/2;


end

