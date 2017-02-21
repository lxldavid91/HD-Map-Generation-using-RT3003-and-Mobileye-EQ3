function [  p_ll_all_GPS, p_rl_all_GPS, p_PV_all_GPS, ...
    ll_y_fit_all_GPS, rl_y_fit_all_GPS, PV_y_fit_all_GPS  ] ...
    = Flex_Polyfit_all( num_seg,seqment_idx,left_lane_GPS_xy, ...
    right_lane_GPS_xy,PV_Lat,PV_Long)

left_lane_GPS_x = left_lane_GPS_xy(:,1);
left_lane_GPS_y = left_lane_GPS_xy(:,2);
right_lane_GPS_x = right_lane_GPS_xy(:,1);
right_lane_GPS_y = right_lane_GPS_xy(:,2);

row=length(left_lane_GPS_x);

p_ll_all_GPS = zeros(num_seg,3);
p_rl_all_GPS = zeros(num_seg,3);
p_PV_all_GPS = zeros(num_seg,3);


ll_y_fit_all_GPS = zeros(row,1);
rl_y_fit_all_GPS = zeros(row, 1);
PV_y_fit_all_GPS = zeros(row, 1);


for n = 1:num_seg
    
    if(n == num_seg)
                
      %GPS Absolute coordinate polyfitting

        p_ll_all_GPS(n,:) = polyfit(left_lane_GPS_x(seqment_idx(n):row),...
        left_lane_GPS_y(seqment_idx(n):row), 2);
    
        p_rl_all_GPS(n,:) = polyfit(right_lane_GPS_x(seqment_idx(n):row),...
        right_lane_GPS_y(seqment_idx(n):row), 2);
    
    
        ll_y_fit_all_GPS(seqment_idx(n):row)...
        = polyval(p_ll_all_GPS(n,:), left_lane_GPS_x(seqment_idx(n):row));
    
        rl_y_fit_all_GPS(seqment_idx(n):row) ...
        = polyval(p_rl_all_GPS(n,:), right_lane_GPS_x(seqment_idx(n):row));
        
     break;
    end
    
         
    %GPS Absolute coordinate polyfitting

        p_ll_all_GPS(n,:) = polyfit(left_lane_GPS_x(seqment_idx(n):seqment_idx(n+1)-1),...
        left_lane_GPS_y(seqment_idx(n):seqment_idx(n+1)-1), 2);
    
        p_rl_all_GPS(n,:) = polyfit(right_lane_GPS_x(seqment_idx(n):seqment_idx(n+1)-1),...
        right_lane_GPS_y(seqment_idx(n):seqment_idx(n+1)-1), 2);
      
        ll_y_fit_all_GPS(seqment_idx(n):seqment_idx(n+1)-1)...
        = polyval(p_ll_all_GPS(n,:), left_lane_GPS_x(seqment_idx(n):seqment_idx(n+1)-1));
    
        rl_y_fit_all_GPS(seqment_idx(n):seqment_idx(n+1)-1) ...
        = polyval(p_rl_all_GPS(n,:), right_lane_GPS_x(seqment_idx(n):seqment_idx(n+1)-1));
   

end





end

