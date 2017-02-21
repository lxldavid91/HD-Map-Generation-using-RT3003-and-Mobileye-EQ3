
%% Load file
[fileName,directoryName] = uigetfile('*.csv','Please click the data recording file in the directory');
if(fileName == 0)
    dispaly('No  file is selected. Please select the right data file'); 
    return;
else
    raw = xlsread([directoryName fileName]);
end
%% Finding the Start Index of the file. 
startInx = find(raw(:,1)==0);
%% Storing the Values in the Variables 

PV_Alt=raw(startInx:end,2);
PV_Heading=raw(startInx:end,3);
PV_Lat=raw(startInx:end,6);
PV_Long=raw(startInx:end,7);

PV_Acc_Lat=raw(startInx:end,9);
PV_Acc_Long=raw(startInx:end,10);
PV_Acc_Vert=raw(startInx:end,11);
PV_Sterring_Angle=raw(startInx:end,12);
PV_Speed=raw(startInx:end,13);

LL_Curvature=raw(startInx:end,14);
LL_Curvature_Derivative= raw(startInx:end,15);
LL_Lane_Type=raw(startInx:end,16);
LL_Position=raw(startInx:end,17);
LL_Quality=raw(startInx:end,18);
LL_Width_left_marking=raw(startInx:end,19);
LL_Heading_Angle=raw(startInx:end,20);
LL_Lane_mark_color=raw(startInx:end,21);
LL_View_Range =raw(startInx:end,22)-raw(startInx:end,23);

% Next_LL_Position = raw(startInx:end,40);
% Next_LL_Quality = raw(startInx:end,41);

RR_Curvature=raw(startInx:end,24);
RR_Curvature_Derivative= raw(startInx:end,25);
RR_Lane_Type=raw(startInx:end,26);
RR_Position=raw(startInx:end,27);
RR_Quality=raw(startInx:end,28);
RR_Width_left_marking=raw(startInx:end,29);
RR_Heading_Angle=raw(startInx:end,30);
RR_Lane_mark_color=raw(startInx:end,31);
RR_View_Range =raw(startInx:end,32)-raw(startInx:end,33);

% Next_RR_Position = raw(startInx:end,53);
% Next_RR_Quality = raw(startInx:end,54);

% Number_Of_TFL_Objects = raw(startInx:end,61);
% TFL_PosX = raw(startInx:end,62);
% TFL_PosY = raw(startInx:end,63);
% TFL_PosZ = raw(startInx:end,64);


JUnction_Distance = raw(startInx:end,34);
Junction_Status =raw(startInx:end,35);
Junction_Number_Of_TFL_Objects = raw(startInx:end,36);

TSR1_Height=raw(startInx:end,37);
TSR1_X=raw(startInx:end,38);
TSR1_Y=raw(startInx:end,39);
TSR1_Type=raw(startInx:end, 40);

TSR2_Height=raw(startInx:end,41);
TSR2_X=raw(startInx:end,42);
TSR2_Y=raw(startInx:end,43);
TSR2_Status=raw(startInx:end, 44);
TSR2_Type=raw(startInx:end, 45);

TSR3_Height=raw(startInx:end,46);
TSR3_X=raw(startInx:end,47);
TSR3_Y=raw(startInx:end,48);
TSR3_Status=raw(startInx:end, 49);
TSR3_Type=raw(startInx:end,50);







