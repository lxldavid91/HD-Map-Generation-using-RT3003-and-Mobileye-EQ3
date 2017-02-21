%% HD_Map_Regeneration_Main
  %Copyright: ChanganUS R&D Center
  %Feb 2017
  clear all;
%% Load HD Map Database
% load('HDMap_LL_Database.mat');
% load('HDMap_RL_Database.mat');
load('HDMap_Database.mat');

load('D_PV_Lat.mat');
load('D_PV_Long.mat');
load('D_Head');

HDMap_LL_Database = HDMap_Database.HDMap_LL_Database;
HDMap_RL_Database = HDMap_Database.HDMap_RL_Database;

HDMap_NLL1_Database = HDMap_Database.HDMap_NL_Database_1.HDMap_NLL_Database_1;
HDMap_NRL1_Database = HDMap_Database.HDMap_NL_Database_1.HDMap_NRL_Database_1;

HDMap_NLL2_Database = HDMap_Database.HDMap_NL_Database_2.HDMap_NLL_Database_2;
HDMap_NRL2_Database = HDMap_Database.HDMap_NL_Database_2.HDMap_NRL_Database_2;

segment_idx = HDMap_Database.segment_idx;
seg_samp_num_target = HDMap_Database.seg_samp_num;
%TSR = HDMap_Database.TSR;

%% Search segment index
%Need inputs from control team
%Dynamic Matlab Plot
%read image
PV_sample_rate = 10;
LookAheadDistance = 75;
% [ TSR_index ] = Find_TSR_index( TSR );


%Build vehicle icon
img = imread('mkz_bev.jpg');
img = imresize(img,[800 800]);
% img = ind2rgb(size(img),img);
temp_gps_long = D_PV_Long(1);
temp_gps_lat = D_PV_Lat(1);

mkz_image = image();

%Upper Left Text Box initialization
textbox_1 = annotation('textbox');
textbox_2 = annotation('textbox');
textbox_3 = annotation('textbox');
textbox_4 = annotation('textbox');

figure(1)

hold on;

%PV_sample_rate = 10;
% Loop starts here
for n = 1 : PV_sample_rate: length(D_PV_Lat) 
clf
current_gps_lat = D_PV_Lat(n) ;
current_gps_long = D_PV_Long(n);
current_heading = D_Head(n);
CurrentGPSPos = [current_gps_lat current_gps_long current_heading];
if (n==371)
   disp('ashish') 
end
[Current_LL_GPS,Current_LL_curv] = ReconstructLane(CurrentGPSPos,HDMap_LL_Database,HDMap_RL_Database,LookAheadDistance,'L');
[Current_RL_GPS,Current_RL_curv] = ReconstructLane(CurrentGPSPos,HDMap_LL_Database,HDMap_RL_Database,LookAheadDistance,'R');
%%%*********CENTER LANE ************
minLen = min(length(Current_LL_GPS),length(Current_RL_GPS));
Center_GPS_Points = (Current_LL_GPS(1:minLen,:) + Current_RL_GPS(1:minLen,:))/2;
%***********************
[Current_NLL_GPS1,~] = ReconstructLane(CurrentGPSPos,HDMap_NLL1_Database,HDMap_NRL1_Database,LookAheadDistance,'L');
[Current_NLL_GPS2,~] = ReconstructLane(CurrentGPSPos,HDMap_NLL2_Database,HDMap_NRL2_Database,LookAheadDistance,'L');
%[Current_NRL_GPS,~] = ReconstructLane(CurrentGPSPos,HDMap_LL_Database,HDMap_RL_Database,LookAheadDistance,'L');

%% GUI STARTS HERE
delete(mkz_image);
delete(textbox_1);
delete(textbox_2);
delete(textbox_3);
delete(textbox_4);

if(n == 1)
    Last_LL_GPS = [Current_LL_GPS(end,2) Current_LL_GPS(end,1)];
    Last_RL_GPS = [Current_RL_GPS(end,2) Current_RL_GPS(end,1)];
    Last_Center_GPS_Point = [Center_GPS_Points(end,2) Center_GPS_Points(end,1)];    
end

hold on;

plot1 = plot([current_gps_long temp_gps_long],[current_gps_lat temp_gps_lat],'--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5]);

temp_gps_long = current_gps_long;
temp_gps_lat = current_gps_lat;

plot2 = plot(Current_LL_GPS(:,2),Current_LL_GPS(:,1),'r','LineWidth',1.5);

plot3 = plot(Current_RL_GPS(:,2),Current_RL_GPS(:,1),'r','LineWidth',1.5);

% plot2 = scatter(Current_LL_GPS(:,2),Current_LL_GPS(:,1),'r');
% 
% plot3 = scatter(Current_RL_GPS(:,2),Current_RL_GPS(:,1),'r');

plot4 = plot(Center_GPS_Points(:,2),Center_GPS_Points(:,1),'b');

plot5 = plot(Current_NLL_GPS1(:,2),Current_NLL_GPS1(:,1),'g','LineWidth',1.5);
plot6 = plot(Current_NLL_GPS2(:,2),Current_NLL_GPS2(:,1),'g','LineWidth',1.5);

% plot5 = scatter(Current_NLL_GPS(:,2),Current_NLL_GPS(:,1),'g','.');
% plot6 = scatter(Current_NRL_GPS(:,2),Current_NRL_GPS(:,1),'g','.');

% plot5 = plot(current_left_lane_GPS_xy(:,2),current_left_lane_GPS_xy(:,1),'k','LineWidth',3);

% plot6 = plot(current_right_lane_GPS_xy(:,2),current_right_lane_GPS_xy(:,2),'k','LineWidth',3);

% if(n == 1)
%     Last_LL_GPS = [Current_LL_GPS(end,2) Current_LL_GPS(end,1)];
%     Last_RL_GPS = [Current_RL_GPS(end,2) Current_RL_GPS(end,1)];
%     Last_Center_GPS_Point = [Center_GPS_Points(end,2) Center_GPS_Points(end,1)];
%     
% %     plot([Last_LL_GPS(1,1) Current_LL_GPS(1,2)],[Last_LL_GPS(1,2)...
% %         Current_LL_GPS(1,1)],'r','LineWidth',1.5);
% end

% Conneting discrete lines
% if(n>1+num_per_seg)
% plot([Last_LL_GPS(1,1) Current_LL_GPS(1,2)],[Last_LL_GPS(1,2) ...
%     Current_LL_GPS(1,1)],'r','LineWidth',1.5);
% plot([Last_RL_GPS(1,1) Current_RL_GPS(1,2)],[Last_RL_GPS(1,2) ...
%     Current_RL_GPS(1,1)],'r','LineWidth',1.5);
% plot([Last_Center_GPS_Point(1,1) Center_GPS_Points(1,2)],[Last_Center_GPS_Point(1,2) ...
%     Center_GPS_Points(1,1)],'b');
% end

% plot([Last_NLL_GPS(1,1) Current_NLL_GPS(1,2)],[Last_NLL_GPS(1,2) ...
%     Current_NLL_GPS(1,1)],'g','LineWidth',1.5);
% plot([Last_NRL_GPS(1,1) Current_NRL_GPS(1,2)],[Last_NRL_GPS(1,2) ...
%     Current_NRL_GPS(1,1)],'g','LineWidth',1.5);

%t0 = tic;

Last_LL_GPS = [Current_LL_GPS(end,2) Current_LL_GPS(end,1)];
Last_RL_GPS = [Current_RL_GPS(end,2) Current_RL_GPS(end,1)];

% Last_NLL_GPS = [Current_NLL_GPS(end,2) Current_NLL_GPS(end,1)];
% Last_NRL_GPS = [Current_NRL_GPS(end,2) Current_NRL_GPS(end,1)];

Last_Center_GPS_Point = [Center_GPS_Points(end,2) Center_GPS_Points(end,1)];

% rotate mkz image according to vehicle heading 
img_rotate_angle = (90 - current_heading);
Irot = imrotate(img,img_rotate_angle,'crop');
mask = true(size(img));
maskR = ~imrotate(mask, img_rotate_angle, 'crop');
%meanI = mean(A(:));
%meanI = 255*ones(size(img));
Irot(maskR) = 255;
% Mrot = ~imrotate(true(size(img)),90-current_heading);
% Irot(Mrot&~imclearborder(Mrot)) = 255;
mkz_image = image([(current_gps_long - 0.00001) (current_gps_long + 0.00001)]...
   ,[(current_gps_lat + 0.000012) (current_gps_lat - 0.000012)],Irot);
%t = toc(t0);
%mkz_image_rotate = imrotate(mkz_image,current_heading);

set(mkz_image,'Visible','on');
% set(mkz_image_rotate,'Visible','on');

long_offset = 0.0002;
lat_offset = 0.0002;

xlim([current_gps_long - long_offset current_gps_long + long_offset])
ylim([current_gps_lat - lat_offset current_gps_lat + lat_offset])

title('LL/RL/Desired Path (Center Lane Keeping) and Trajectory of Vehicle');

legend('show')
legend([plot1 plot2 plot4],{'Real Time Vehicle Trajectory','Reconstructed Left/Right Lane',...
    'Desired Way Point'});

xlabel('GPS Longitude');
ylabel('GPS Latitude');

% GUI Text Box
% Create a uicontrol of type "text"

textbox_1 = annotation('textbox',...
    [0.15 0.8 0.15 0.12],...
    'String',{'Current PV GPS Position:' num2str(current_gps_lat,'%f')...
     num2str(current_gps_long,'%f')},'FontSize',10);
textbox_2 = annotation('textbox',...
    [0.15 0.68 0.15 0.12],...
    'String',{'Current Desired GPS Way Point:' num2str(Center_GPS_Points(1,1),'%f')...
     num2str(Center_GPS_Points(1,2),'%f')},'FontSize',10);
 textbox_3 = annotation('textbox',...
    [0.3 0.8 0.15 0.12],...
    'String',{'Current Speed Limit:' '45 Mph'},'FontSize',10);
 textbox_4 = annotation('textbox',...
    [0.3 0.68 0.15 0.12],...
    'String',{'LL/RL Curvature in 10 meters:' 'Left Lane Curvature:' ...
    num2str(Current_LL_curv(5),'%f') 'Right Lane Curvature:' ...
    num2str(Current_RL_curv(5),'%f')},'FontSize',10);
 
% PV_GPS_textbox = uicontrol('style','text');
% set(PV_GPS_textbox,'String','GPS_LAT_LONG');

% To move the the Text Box around you can set and get the position of Text Box itself
% PV_GPS_textbox_Position = get(PV_GPS_textbox,'Position');
% The array mTextBoxPosition has four elements
% [x y length height]

% Generating Moving Frames
pause(0.001)

% xlim([-83.53 -83.508])
% ylim([42.374 42.386])

% xlim([-83.57 -83.505])
% ylim([42.355 42.39])
% pause(0.005)

% axis equal
% M(n) = getframe;

end
% output.worldmap = gcf;
% setappdata(0,'output',output);
% axes(handles.worldmap)
% HD_MAP_GUI;
%%
%movie(M,30)

%% Testing
% GenrateKMLPaths(Center_GPS_Points);
% GenrateKMLPaths(Current_LL_GPS);
% GenrateKMLPaths(Current_RL_GPS);
%%
%GenerateKMLPoints(current_gps_lat,current_gps_long);
%% 





