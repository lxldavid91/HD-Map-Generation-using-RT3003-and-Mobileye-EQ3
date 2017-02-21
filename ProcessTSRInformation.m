% Code Section to find the Lat-Longs of TSR
%% Import CSV File
[fileName,directoryName] = uigetfile('*.csv','Please click the data recording file in the directory');
if(fileName == 0)
    dispaly('No  file is selected. Please select the right data file'); 
    return;
else
    [~,BB,raw] = xlsread([directoryName fileName]);
end
Name_Index = 1;
Values_Index = 2;
Titles = raw(Name_Index,2:end);
Data = raw(Values_Index:end,2:end);
Data = cell2mat(Data); 
raw(1:Values_Index-1,:) =[];  % Removing Unnecessary Headers to keep it clean
raw(:,1)= [];
%% Traffic Sign List and Correspoding Codes
% Add new ones at the end of this list and their code in TSRCOde
TSRList = {'SpeedLimit30','SpeedLimit35','SpeedLimit70','StopSign'...
    'LeftLaneEnds','LaneMergeRight','DiamondsWindingRight'...
    'RoadArrowRight','RoadArrowLeft'};

TSRCode = [2,103,6,210,182,186,194,17,18];
%% Intialization and Storing Indexes of TSR in CSV
% VGPS is Vehicle GPS Location i.e Raw data
% TSR1 is the Array defining [SignHeight,SignType,SignX,SignY]
tinx = 1;
VGPS = [Data(:,5) Data(:,6) Data(:,2)]; % 5,6,2 are lat long heading indexes
TSRInxs = [70 73 71 72;74 78 75 76;79 83 80 81];  % indexes in CSV File for three sets of TSR1
%% Algorithm : calucuate TSR Locations for three runs
for k = 1:3
    TSR1 = [Data(:,TSRInxs(k,1)) Data(:,TSRInxs(k,2)) Data(:,TSRInxs(k,3)) Data(:,TSRInxs(k,4))];
    tempVal = 0;  % STARTING TYPE SHOULD BE 0
    TSRLocation = GetTSRLocation(VGPS,TSR1);
    N = length(TSRLocation);
    for i=1:N
        TypeCode = TSRLocation(i,1);
        if ~(TypeCode==tempVal)
            Inx = find(TypeCode==TSRCode);
            if ~(isempty(Inx))
                SignType = TSRList{Inx};
                TSRDB{tinx,1} = SignType;
                TSRDB{tinx,2} = TypeCode;
                TSRDB{tinx,3} = TSRLocation(i,2);
                TSRDB{tinx,4} = TSRLocation(i,3);
                tinx = tinx +1;
            end
        end
        tempVal = TypeCode;
    end
end
%% display TSR Locations
TSRDB