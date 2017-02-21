% HD map generation based on Mobileye IQ3 camera and RT3003 with DGPS
% The data is recorded through Micro-Autobox and synchrozed.
% 
 seg_distance = 0.5; % in meters
 
 %load('conbined_highway_without_lanewidth.mat');
 load('LaneCominedData.mat');
 
 DS_index = 1:length(LaneCombinedData);
 left_lane_x = LaneCombinedData(:,6);
 left_lane_y = LaneCombinedData(:,7);
 right_lane_x = LaneCombinedData(:,12);
 right_lane_y = LaneCombinedData(:,13);
 left_lane_GPS_xy = [LaneCombinedData(:,8) LaneCombinedData(:,9)];
 right_lane_GPS_xy = [LaneCombinedData(:,14) LaneCombinedData(:,15)];
 NLL_GPS = [LaneCombinedData(:,16) LaneCombinedData(:,17)];
 NRL_GPS = [LaneCombinedData(:,18) LaneCombinedData(:,19)];
 %GenrateKMLPaths(NLL_GPS);
 % NLL_GPS_Start_End_Point:    42.382077    -83.519501
 %                             42.364235    -83.559779    (South West)
 
 %                             42.363765    -83.560461
 %                             42.381867    -83.517460    (North East)
 
% Index generated based on NLL GPS points and fed into NRL structure
NLL_GPS_Hgw_pt = [42.382077 -83.519501;
                  42.364235 -83.559779;
                  42.363765 -83.560461;
                  42.381867 -83.517460];
%Those points are manually detected on Google Earth 
              
[Hgw_index] = Find_Hgw_Index(NLL_GPS_Hgw_pt,NLL_GPS);

NLL_GPS_Hgw_1 = NLL_GPS(Hgw_index(1):Hgw_index(2),:);
NLL_GPS_Hgw_2 = NLL_GPS(Hgw_index(3):Hgw_index(4),:);
 
NRL_GPS_Hgw_1 = NRL_GPS(Hgw_index(1):Hgw_index(2),:);
NRL_GPS_Hgw_2 = NRL_GPS(Hgw_index(3):Hgw_index(4),:);
 
%  left_lane_x = Lx;
%  left_lane_y = Ly;
%  right_lane_x = Rx;
%  right_lane_y = Ry;
%  left_lane_GPS_xy = [L_Lat L_Lon];
%  right_lane_GPS_xy = [R_Lat R_Lon];
%% Route Segmentation function
length_seg = 20;

[num_seg, num_seg_NL_1, num_seg_NL_2, segment_idx, Segment_distance, NL_Dis_1, NL_Dis_2]...
    = Flex_Route_Segment(left_lane_GPS_xy(:,1),left_lane_GPS_xy(:,2),length_seg,NLL_GPS_Hgw_1, NLL_GPS_Hgw_2);

%% Polyfitting for all segments
[p_ll_all, p_rl_all, p_NLL_1_GPS, p_NLL_2_GPS, p_NRL_1_GPS, p_NRL_2_GPS, ...
    p_ll_all_GPS, p_rl_all_GPS, ll_y_fit_all, ...
    rl_y_fit_all, ll_y_fit_all_GPS, rl_y_fit_all_GPS, NLL_y_fit_all_GPS_1,...
    NLL_y_fit_all_GPS_2, NRL_y_fit_all_GPS_1, NRL_y_fit_all_GPS_2] = Polyfit_all...
    ( num_seg, num_seg_NL_1, num_seg_NL_2, DS_index, length_seg, left_lane_x, left_lane_y, right_lane_x,...
    right_lane_y, left_lane_GPS_xy, right_lane_GPS_xy, NLL_GPS_Hgw_1, NLL_GPS_Hgw_2,...
    NRL_GPS_Hgw_1, NRL_GPS_Hgw_2,segment_idx);

%% Calvature Calculation for each segment
[LL_Carv, RL_Carv] = Seg_Cal_Carv( num_seg, p_ll_all,...
    p_rl_all, left_lane_x, right_lane_x, segment_idx);

%% Add Traffic Light Positions
% TFL_xy = Add_TFL(vehicle_location_xy,D_Head, DS_index, ...
%     Number_Of_TFL_Objects,TFL_PosX, TFL_PosZ) ;
%% Visualization 
%ll/rl visualization in xy relative coordinate
Visualization(left_lane_x,right_lane_x,ll_y_fit_all,rl_y_fit_all,...
    left_lane_y,right_lane_y, LL_Carv, RL_Carv,num_seg,length_seg,...
      left_lane_GPS_xy, right_lane_GPS_xy, NLL_y_fit_all_GPS_1,...
    NLL_y_fit_all_GPS_2, NRL_y_fit_all_GPS_1, NRL_y_fit_all_GPS_2,...
    NLL_GPS_Hgw_1, NLL_GPS_Hgw_2, NRL_GPS_Hgw_1, NRL_GPS_Hgw_2);

%% Build_HDMap_Database
[HDMap_Database] = Build_HDMap_Database...
    (num_seg,num_seg_NL_1,num_seg_NL_2,length_seg, left_lane_GPS_xy, ...
   right_lane_GPS_xy, p_ll_all, p_rl_all, p_ll_all_GPS, p_rl_all_GPS,...
   p_NLL_1_GPS, p_NLL_2_GPS, p_NRL_1_GPS,p_NRL_2_GPS, NLL_GPS_Hgw_1,...
   NLL_GPS_Hgw_2, NRL_GPS_Hgw_1,NRL_GPS_Hgw_2,LL_Carv, RL_Carv,...
   segment_idx, Segment_distance,NL_Dis_1,NL_Dis_2);

%% Process TSR and add then to map
%ProcessTSRInformation;

%% Save Database
%HDMap_Database.TSR = TSRDB([1 4 7 8 12],:);

save('HDMap_Database.mat','HDMap_Database');


% Turn_area_Detection;
% Find_Shape_Point;
% Display_Module;
% Build_HDMap_Database;
