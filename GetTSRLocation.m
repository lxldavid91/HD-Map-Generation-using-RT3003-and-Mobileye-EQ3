function TSRLocation = GetTSRLocation(VGPS,TSR1)

% Vehicle GPS Position
% VGPS =[Lat,Lon,Heading] 
% TSR = [SignHeight_79,SignX_80,SignY_81,VisionOnlySignType_78]


ind = length(VGPS);
delta = 0.1; % 0.1 seconds simulation step
tim = ind*delta - delta ;
GPS_Lat = timeseries(VGPS(:,1),0:delta:tim);
GPS_Lon = timeseries(VGPS(:,2),0:delta:tim);
GPS_Hea = timeseries(VGPS(:,3),0:delta:tim);

Longitudnal_distance = timeseries(1.22,0:delta:tim);
Lateral_distance     = timeseries(0,0:delta:tim);
    
options1 = simset('SrcWorkspace','current'); % Uses values from function workspace
sim('XY2LatLong1.slx',[],options1)    
    
ME_Lat = Calc_Lat.Data;    
ME_Lon = Calc_Lon.Data;

GPS_Lat = timeseries(ME_Lat,0:delta:tim);
GPS_Lon = timeseries(ME_Lon,0:delta:tim);
GPS_Hea = timeseries(VGPS(:,3),0:delta:tim);

Longitudnal_distance = timeseries(TSR1(:,3),0:delta:tim);
Lateral_distance     = timeseries(TSR1(:,4),0:delta:tim);
    
options2 = simset('SrcWorkspace','current'); % Uses values from function workspace
sim('XY2LatLong1.slx',[],options2)    
    
S_Lat = Calc_Lat.Data;    
S_Lon = Calc_Lon.Data;

TSRLocation = [TSR1(:,2) S_Lat S_Lon];


end