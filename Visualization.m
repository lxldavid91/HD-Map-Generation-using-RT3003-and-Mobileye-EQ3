function [] = Visualization( left_lane_x,right_lane_x,ll_y_fit_all,rl_y_fit_all,...
    left_lane_y,right_lane_y, LL_Carv, RL_Carv, num_seg, length_seg,...
    left_lane_GPS_xy, right_lane_GPS_xy, NLL_y_fit_all_GPS_1,...
    NLL_y_fit_all_GPS_2, NRL_y_fit_all_GPS_1, NRL_y_fit_all_GPS_2,...
    NLL_GPS_Hgw_1, NLL_GPS_Hgw_2, NRL_GPS_Hgw_1, NRL_GPS_Hgw_2)

figure(1)
%ll/rl visualization in xy relative coordinate

scatter(left_lane_x,ll_y_fit_all,'*','r');
hold on;
scatter(right_lane_x,rl_y_fit_all,'*','y');
hold on;

scatter(left_lane_x,left_lane_y,'.','b');
hold on;
scatter(right_lane_x,right_lane_y,'.','b');
hold on;

title('LL/RL Visualization in XY Relative Coordinate');
xlabel('X(meter)');
ylabel('Y(meter)');
legend('Left Lane After Polyfitting','Right Lane After Polyfitting', ...
    'Raw LL/RL After Downsampling');

figure(2)
hold on;
% Convert ll/rl coordinate back to GPS positions and visualization
scatter(left_lane_GPS_xy(:,2),left_lane_GPS_xy(:,1),'.','r');
scatter(right_lane_GPS_xy(:,2),right_lane_GPS_xy(:,1),'.','y');

scatter(NLL_y_fit_all_GPS_1,NLL_GPS_Hgw_1(:,1),'.','g');
scatter(NLL_y_fit_all_GPS_2,NLL_GPS_Hgw_2(:,1),'.','g');
scatter(NRL_y_fit_all_GPS_1,NRL_GPS_Hgw_1(:,1),'.','g');
scatter(NRL_y_fit_all_GPS_2,NRL_GPS_Hgw_2(:,1),'.','g');



title('LL/RL Visualization in Absolute Coordinate');
xlabel('Long(Degree)');
ylabel('Lat(Degree)');
legend('Left Lane GPS Position','Right Lane GPS Position','NLL/NRL GPS Position');

% figure(3)
% %LL/RL curvature visualization
% cnt = 1;
% 
% for z = 1:num_seg
%     
%     subplot(2,1,1);
%     plot(cnt : cnt + length_seg -1 , LL_Carv(z,1:length_seg));
%     hold on;
%     ylim([0,0.5]);
%     
%     title('LL Calvature for Each Segment');
%     xlabel('Index after Downsamping');
%     ylabel('LL Calvature');
%     
%     subplot(2,1,2);
%     plot(cnt : cnt + length_seg -1 , RL_Carv(z,1:length_seg));
%     hold on;
%     ylim([0,0.5]);
%     
%     title('RL Calvature for Each Segment');
%     xlabel('Index after Downsamping');
%     ylabel('RL Calvature');
%     
%     cnt = cnt + length_seg;
% 
% end

end

