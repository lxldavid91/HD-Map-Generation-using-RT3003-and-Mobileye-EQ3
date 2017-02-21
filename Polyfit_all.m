function [p_ll_all, p_rl_all, p_NLL_1_GPS, p_NLL_2_GPS, p_NRL_1_GPS, p_NRL_2_GPS, ...
    p_ll_all_GPS, p_rl_all_GPS, ll_y_fit_all, ...
    rl_y_fit_all, ll_y_fit_all_GPS, rl_y_fit_all_GPS, NLL_y_fit_all_GPS_1,...
    NLL_y_fit_all_GPS_2, NRL_y_fit_all_GPS_1, NRL_y_fit_all_GPS_2] = Polyfit_all...
    ( num_seg, num_seg_NL_1, num_seg_NL_2, DS_index ,length_seg, left_lane_x, left_lane_y, right_lane_x,...
    right_lane_y,left_lane_GPS_xy, right_lane_GPS_xy, NLL_GPS_Hgw_1, NLL_GPS_Hgw_2,...
    NRL_GPS_Hgw_1, NRL_GPS_Hgw_2, seqment_idx)

% Only apply polyfitting for GPS points of NLL/NRL data

left_lane_GPS_x = left_lane_GPS_xy(:,1);
left_lane_GPS_y = left_lane_GPS_xy(:,2);
right_lane_GPS_x = right_lane_GPS_xy(:,1);
right_lane_GPS_y = right_lane_GPS_xy(:,2);

row=length(left_lane_GPS_x);

NLL_GPS_Hgw_1_x = NLL_GPS_Hgw_1(:,1);
NLL_GPS_Hgw_1_y = NLL_GPS_Hgw_1(:,2);
NLL_GPS_Hgw_2_x = NLL_GPS_Hgw_2(:,1);
NLL_GPS_Hgw_2_y = NLL_GPS_Hgw_2(:,2);

NRL_GPS_Hgw_1_x = NRL_GPS_Hgw_1(:,1);
NRL_GPS_Hgw_1_y = NRL_GPS_Hgw_1(:,2);
NRL_GPS_Hgw_2_x = NRL_GPS_Hgw_2(:,1);
NRL_GPS_Hgw_2_y = NRL_GPS_Hgw_2(:,2);

p_ll_all = zeros(num_seg,5);
p_rl_all = zeros(num_seg,5);
p_ll_all_GPS = zeros(num_seg,5);
p_rl_all_GPS = zeros(num_seg,5);

p_NLL_1_GPS = zeros(num_seg_NL_1,5);
p_NLL_2_GPS = zeros(num_seg_NL_2,5);
p_NRL_1_GPS = zeros(num_seg_NL_1,5);
p_NRL_2_GPS = zeros(num_seg_NL_2,5);

ll_y_fit_all = zeros(length(DS_index),1);
rl_y_fit_all = zeros(length(DS_index),1);
ll_y_fit_all_GPS = zeros(length(DS_index),1);
rl_y_fit_all_GPS = zeros(length(DS_index),1);
NLL_y_fit_all_GPS_1 = zeros(length(NLL_GPS_Hgw_1),1);
NLL_y_fit_all_GPS_2 = zeros(length(NLL_GPS_Hgw_2),1);
NRL_y_fit_all_GPS_1 = zeros(length(NRL_GPS_Hgw_1),1);
NRL_y_fit_all_GPS_2 = zeros(length(NRL_GPS_Hgw_2),1);

seg_size = 1;
cnt = 1;

for n = 1:num_seg_NL_1
    
    if(n == num_seg_NL_1)
        p_NLL_1_GPS(n,:) = polyfit(NLL_GPS_Hgw_1_x(cnt:length(NLL_GPS_Hgw_1)),...
        NLL_GPS_Hgw_1_y(cnt:length(NLL_GPS_Hgw_1)), 4);

        p_NRL_1_GPS(n,:) = polyfit(NRL_GPS_Hgw_1_x(cnt:length(NRL_GPS_Hgw_1)),...
        NRL_GPS_Hgw_1_y(cnt:length(NRL_GPS_Hgw_1)), 4);

        NLL_y_fit_all_GPS_1(seg_size : length(NLL_GPS_Hgw_1))...
        = polyval(p_NLL_1_GPS(n,:), NLL_GPS_Hgw_1_x(cnt:length(NLL_GPS_Hgw_1)));
 
        NRL_y_fit_all_GPS_1(seg_size : length(NRL_GPS_Hgw_1))...
        = polyval(p_NRL_1_GPS(n,:), NRL_GPS_Hgw_1_x(cnt:length(NRL_GPS_Hgw_1)));
       
    
    break;
        
    end
    
    p_NLL_1_GPS(n,:) = polyfit(NLL_GPS_Hgw_1_x(cnt:cnt+length_seg-1),...
    NLL_GPS_Hgw_1_y(cnt:cnt+length_seg-1), 4);
  
    p_NRL_1_GPS(n,:) = polyfit(NRL_GPS_Hgw_1_x(cnt:cnt+length_seg-1),...
    NRL_GPS_Hgw_1_y(cnt:cnt+length_seg-1), 4);

    NLL_y_fit_all_GPS_1(seg_size : seg_size + length_seg - 1)...
    = polyval(p_NLL_1_GPS(n,:), NLL_GPS_Hgw_1_x(cnt:cnt+length_seg - 1));
        
     NRL_y_fit_all_GPS_1(seg_size : seg_size + length_seg - 1)...
    = polyval(p_NRL_1_GPS(n,:), NRL_GPS_Hgw_1_x(cnt:cnt+length_seg - 1));

cnt = cnt + length_seg;
seg_size = seg_size + length_seg;

end

seg_size = 1;
cnt = 1;

for n = 1:num_seg_NL_2
    
    if(n == num_seg_NL_2)
    p_NLL_2_GPS(n,:) = polyfit(NLL_GPS_Hgw_2_x(cnt:length(NLL_GPS_Hgw_2)),...
        NLL_GPS_Hgw_2_y(cnt:length(NLL_GPS_Hgw_2)), 4);
    p_NRL_2_GPS(n,:) = polyfit(NRL_GPS_Hgw_2_x(cnt:length(NRL_GPS_Hgw_2)),...
        NRL_GPS_Hgw_2_y(cnt:length(NRL_GPS_Hgw_2)), 4);
    
    NLL_y_fit_all_GPS_2(seg_size : length(NLL_GPS_Hgw_2)) ...
    = polyval(p_NLL_2_GPS(n,:), NLL_GPS_Hgw_2_x(cnt:length(NLL_GPS_Hgw_2)));
    NRL_y_fit_all_GPS_2(seg_size : length(NRL_GPS_Hgw_2)) ...
    = polyval(p_NRL_2_GPS(n,:), NRL_GPS_Hgw_2_x(cnt:length(NRL_GPS_Hgw_2)));

    break;
    end

  p_NLL_2_GPS(n,:) = polyfit(NLL_GPS_Hgw_2_x(cnt:cnt+length_seg-1),...
    NLL_GPS_Hgw_2_y(cnt:cnt+length_seg-1), 4);
  p_NRL_2_GPS(n,:) = polyfit(NRL_GPS_Hgw_2_x(cnt:cnt+length_seg-1),...
    NRL_GPS_Hgw_2_y(cnt:cnt+length_seg-1), 4);

  NLL_y_fit_all_GPS_2(seg_size : seg_size + length_seg - 1) ...
    = polyval(p_NLL_2_GPS(n,:), NLL_GPS_Hgw_2_x(cnt:cnt+length_seg - 1));
  NRL_y_fit_all_GPS_2(seg_size : seg_size + length_seg - 1) ...
    = polyval(p_NRL_2_GPS(n,:), NRL_GPS_Hgw_2_x(cnt:cnt+length_seg - 1));
    

cnt = cnt + length_seg;
seg_size = seg_size + length_seg;

end
    

for n = 1:num_seg
    
    if(n == num_seg)
        
%XY relative coordinate polyfitting        
        p_ll_all(n,:) = polyfit(left_lane_x(seqment_idx(n):row),...
        left_lane_y(seqment_idx(n):row), 4);
    
        p_rl_all(n,:) = polyfit(right_lane_x(seqment_idx(n):row),...
        right_lane_y(seqment_idx(n):row), 4);
   
        ll_y_fit_all(seqment_idx(n):row)...
        = polyval(p_ll_all(n,:), left_lane_x(seqment_idx(n):row));
    
        rl_y_fit_all(seqment_idx(n):row) ...
        = polyval(p_rl_all(n,:), right_lane_x(seqment_idx(n):row));

%GPS Absolute coordinate polyfitting

        p_ll_all_GPS(n,:) = polyfit(left_lane_GPS_x(seqment_idx(n):row),...
        left_lane_GPS_y(seqment_idx(n):row), 4);
    
        p_rl_all_GPS(n,:) = polyfit(right_lane_GPS_x(seqment_idx(n):row),...
        right_lane_GPS_y(seqment_idx(n):row), 4);
   
        ll_y_fit_all_GPS(seqment_idx(n):row)...
        = polyval(p_ll_all_GPS(n,:), left_lane_GPS_x(seqment_idx(n):row));
    
        rl_y_fit_all_GPS(seqment_idx(n):row) ...
        = polyval(p_rl_all_GPS(n,:), right_lane_GPS_x(seqment_idx(n):row));
            
     break;
    end
    
        p_ll_all(n,:) = polyfit(left_lane_x(seqment_idx(n):seqment_idx(n+1)-1),...
        left_lane_y(seqment_idx(n):seqment_idx(n+1)-1), 4);
    
        p_rl_all(n,:) = polyfit(right_lane_x(seqment_idx(n):seqment_idx(n+1)-1),...
        right_lane_y(seqment_idx(n):seqment_idx(n+1)-1), 4);
      
        ll_y_fit_all(seqment_idx(n):seqment_idx(n+1)-1)...
        = polyval(p_ll_all(n,:), left_lane_x(seqment_idx(n):seqment_idx(n+1)-1));
    
        rl_y_fit_all(seqment_idx(n):seqment_idx(n+1)-1) ...
        = polyval(p_rl_all(n,:), right_lane_x(seqment_idx(n):seqment_idx(n+1)-1));
    
    %GPS Absolute coordinate polyfitting

        p_ll_all_GPS(n,:) = polyfit(left_lane_GPS_x(seqment_idx(n):seqment_idx(n+1)-1),...
        left_lane_GPS_y(seqment_idx(n):seqment_idx(n+1)-1), 4);
    
        p_rl_all_GPS(n,:) = polyfit(right_lane_GPS_x(seqment_idx(n):seqment_idx(n+1)-1),...
        right_lane_GPS_y(seqment_idx(n):seqment_idx(n+1)-1), 4);
      
        ll_y_fit_all_GPS(seqment_idx(n):seqment_idx(n+1)-1)...
        = polyval(p_ll_all_GPS(n,:), left_lane_GPS_x(seqment_idx(n):seqment_idx(n+1)-1));
    
        rl_y_fit_all_GPS(seqment_idx(n):seqment_idx(n+1)-1) ...
        = polyval(p_rl_all_GPS(n,:), right_lane_GPS_x(seqment_idx(n):seqment_idx(n+1)-1));

    
% 
% cnt = cnt + length_seg;
% seg_size = seg_size + length_seg;

end





end

