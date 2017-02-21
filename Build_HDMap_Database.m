function [HDMap_Database] = Build_HDMap_Database...
    (num_seg,num_seg_NL_1,num_seg_NL_2,length_seg, left_lane_GPS_xy, ...
   right_lane_GPS_xy, p_ll_all, p_rl_all, p_ll_all_GPS, p_rl_all_GPS,...
   p_NLL_1_GPS, p_NLL_2_GPS, p_NRL_1_GPS,p_NRL_2_GPS, NLL_GPS_Hgw_1,...
   NLL_GPS_Hgw_2, NRL_GPS_Hgw_1,NRL_GPS_Hgw_2,LL_Carv, RL_Carv,...
   seqment_idx, Segment_distance,NL_Dis_1,NL_Dis_2)

HDMap_Database = struct;
HDMap_LL_Database = struct;
HDMap_RL_Database = struct;
HDMap_NLL_Database_1 = struct;
HDMap_NRL_Database_1 = struct;
HDMap_NLL_Database_2 = struct;
HDMap_NRL_Database_2 = struct;

row=length(left_lane_GPS_xy);
HDMap_Database.segment_idx = seqment_idx;

cnt = 1;

for n = 1 : num_seg_NL_1
    if(n == num_seg_NL_1)
        HDMap_NLL_Database_1(n).name = ['NLL_1_segment_',num2str(n)];
        HDMap_NRL_Database_1(n).name = ['NRL_1_segment_',num2str(n)];
        
        HDMap_NLL_Database_1(n).start_end_point = [NLL_GPS_Hgw_1(cnt,:);...
        NLL_GPS_Hgw_1(length(NLL_GPS_Hgw_1),:)];
        HDMap_NRL_Database_1(n).start_end_point = [NRL_GPS_Hgw_1(cnt,:);...
        NRL_GPS_Hgw_1(length(NRL_GPS_Hgw_1),:)];
        HDMap_NLL_Database_1(n).poly_para_GPS = p_NLL_1_GPS(n,:);
        HDMap_NRL_Database_1(n).poly_para_GPS = p_NRL_1_GPS(n,:);
        
        HDMap_NLL_Database_1(n).curvature = zeros(1,20);
        HDMap_NLL_Database_1(n).SegLength = NL_Dis_1(n);
        HDMap_NRL_Database_1(n).curvature = zeros(1,20);
        HDMap_NRL_Database_1(n).SegLength = NL_Dis_1(n);
    break;    
    end
        HDMap_NLL_Database_1(n).name = ['NLL_1_segment_',num2str(n)];
        HDMap_NRL_Database_1(n).name = ['NRL_1_segment_',num2str(n)];
        
        HDMap_NLL_Database_1(n).start_end_point = [NLL_GPS_Hgw_1(cnt,:);...
        NLL_GPS_Hgw_1((cnt+length_seg-1),:)];
        HDMap_NRL_Database_1(n).start_end_point = [NRL_GPS_Hgw_1(cnt,:);...
        NRL_GPS_Hgw_1((cnt+length_seg-1),:)];
        HDMap_NLL_Database_1(n).poly_para_GPS = p_NLL_1_GPS(n,:);
        HDMap_NRL_Database_1(n).poly_para_GPS = p_NRL_1_GPS(n,:);
        
        HDMap_NLL_Database_1(n).curvature = zeros(1,20);
        HDMap_NLL_Database_1(n).SegLength = NL_Dis_1(n);
        HDMap_NRL_Database_1(n).curvature = zeros(1,20);
        HDMap_NRL_Database_1(n).SegLength = NL_Dis_1(n);
          
        cnt = cnt + length_seg;
end

cnt = 1;

for n = 1 : num_seg_NL_2
    if(n == num_seg_NL_2)
        
        HDMap_NLL_Database_2(n).name = ['NLL_2_segment_',num2str(n)];
        HDMap_NRL_Database_2(n).name = ['NRL_2_segment_',num2str(n)];
        
        HDMap_NLL_Database_2(n).start_end_point = [NLL_GPS_Hgw_2(cnt,:);...
        NLL_GPS_Hgw_2(length(NLL_GPS_Hgw_2),:)];
        HDMap_NRL_Database_2(n).start_end_point = [NRL_GPS_Hgw_2(cnt,:);...
        NRL_GPS_Hgw_2(length(NRL_GPS_Hgw_2),:)];
        HDMap_NLL_Database_2(n).poly_para_GPS = p_NLL_2_GPS(n,:);
        HDMap_NRL_Database_2(n).poly_para_GPS = p_NRL_2_GPS(n,:);
        
        HDMap_NLL_Database_2(n).curvature = zeros(1,20);
        HDMap_NLL_Database_2(n).SegLength = NL_Dis_2(n);
        HDMap_NRL_Database_2(n).curvature = zeros(1,20);
        HDMap_NRL_Database_2(n).SegLength = NL_Dis_2(n);
        
    break;    
    end
    
        HDMap_NLL_Database_2(n).name = ['NLL_2_segment_',num2str(n)];
        HDMap_NRL_Database_2(n).name = ['NRL_2_segment_',num2str(n)];
        
        HDMap_NLL_Database_2(n).start_end_point = [NLL_GPS_Hgw_2(cnt,:);...
        NLL_GPS_Hgw_2((cnt+length_seg-1),:)];
        HDMap_NRL_Database_2(n).start_end_point = [NRL_GPS_Hgw_2(cnt,:);...
        NRL_GPS_Hgw_2((cnt+length_seg-1),:)];
        HDMap_NLL_Database_2(n).poly_para_GPS = p_NLL_2_GPS(n,:);
        HDMap_NRL_Database_2(n).poly_para_GPS = p_NRL_2_GPS(n,:);
        
        HDMap_NLL_Database_2(n).curvature = zeros(1,20);
        HDMap_NLL_Database_2(n).SegLength = NL_Dis_2(n);
        HDMap_NRL_Database_2(n).curvature = zeros(1,20);
        HDMap_NRL_Database_2(n).SegLength = NL_Dis_2(n);
        
        cnt = cnt + length_seg;
end


for n = 1 : num_seg
    if(n == num_seg)
        
        HDMap_LL_Database(n).name = ['LL_segment_',num2str(n)];
        HDMap_LL_Database(n).start_end_point = [left_lane_GPS_xy(seqment_idx(n),:);
        left_lane_GPS_xy(length(row),:)];
        HDMap_LL_Database(n).poly_para_XY = p_ll_all(n,:);
        HDMap_LL_Database(n).poly_para_GPS = p_ll_all_GPS(n,:);
        HDMap_LL_Database(n).curvature = LL_Carv(n).curvature;
        HDMap_LL_Database(n).SegLength = Segment_distance(n);
        
        HDMap_RL_Database(n).name = ['RL_segment_',num2str(n)];
        HDMap_RL_Database(n).start_end_point = [right_lane_GPS_xy(seqment_idx(n),:);
        right_lane_GPS_xy(length(row),:)];
        HDMap_RL_Database(n).poly_para_XY = p_rl_all(n,:);
        HDMap_RL_Database(n).poly_para_GPS = p_rl_all_GPS(n,:);
        HDMap_RL_Database(n).curvature = RL_Carv(n).curvature;
        HDMap_RL_Database(n).SegLength = Segment_distance(n);
        
        HDMap_Database.seg_samp_num(n,1) = length(LL_Carv(n).curvature);
        
         break;
    end
        
    HDMap_LL_Database(n).name = ['LL_segment_',num2str(n)];
    HDMap_LL_Database(n).start_end_point = [left_lane_GPS_xy(seqment_idx(n),:);
        left_lane_GPS_xy((seqment_idx(n+1)-1),:)];
    HDMap_LL_Database(n).poly_para_XY = p_ll_all(n,:);
    HDMap_LL_Database(n).poly_para_GPS = p_ll_all_GPS(n,:);
    HDMap_LL_Database(n).curvature = LL_Carv(n).curvature;
    HDMap_LL_Database(n).SegLength = Segment_distance(n);
    
    HDMap_RL_Database(n).name = ['RL_segment_',num2str(n)];
    HDMap_RL_Database(n).start_end_point = [right_lane_GPS_xy(seqment_idx(n),:);...
        right_lane_GPS_xy((seqment_idx(n+1)-1),:)];
    HDMap_RL_Database(n).poly_para_XY = p_rl_all(n,:);
    HDMap_RL_Database(n).poly_para_GPS = p_rl_all_GPS(n,:);
    HDMap_RL_Database(n).curvature = RL_Carv(n).curvature;
    HDMap_RL_Database(n).SegLength = Segment_distance(n);
    
    HDMap_Database.seg_samp_num(n,1) = length(LL_Carv(n).curvature);

end

HDMap_Database.HDMap_LL_Database = HDMap_LL_Database;
HDMap_Database.HDMap_RL_Database = HDMap_RL_Database;
HDMap_Database.HDMap_NL_Database_1.HDMap_NLL_Database_1 = HDMap_NLL_Database_1;
HDMap_Database.HDMap_NL_Database_1.HDMap_NRL_Database_1 = HDMap_NRL_Database_1;
HDMap_Database.HDMap_NL_Database_2.HDMap_NLL_Database_2 = HDMap_NLL_Database_2;
HDMap_Database.HDMap_NL_Database_2.HDMap_NRL_Database_2 = HDMap_NRL_Database_2;
end

