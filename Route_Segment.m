function [num_seg , look_ahead_dist,num_seg_NL_1, num_seg_NL_2] =...
    Route_Segment(length_seg,seg_distance,...
    DS_index, NLL_GPS_Hgw_1, NLL_GPS_Hgw_2)

%length_seg = 10;  % 10 meters segmentation
num_seg = round(length(DS_index)/length_seg);

num_seg_NL_1 = round(length(NLL_GPS_Hgw_1)/length_seg);
num_seg_NL_2 = round(length(NLL_GPS_Hgw_2)/length_seg);

look_ahead_dist = length_seg * seg_distance;


end

