function [OutputLaneData,OutputLaneCurv] = ReconstructLane(CGPS,LeftLaneStruct,RightLaneStruct,LookAheadDistance,LorR)

% Intializations
LlaneDB = LeftLaneStruct;
RlaneDB = RightLaneStruct;
LAD = LookAheadDistance;
current_gps_lat = CGPS(1);
current_gps_long = CGPS(2);
if strcmp(LorR,'L')  
   TotalSeg = length(LlaneDB); 
else
   TotalSeg = length(RlaneDB);     
end
%% Find the Segment Number in which the Current GPS lies. --- ##Need to verify**
pos_error = zeros(length(LlaneDB),1);
for n = 1:length(LlaneDB)
        pos_error(n,1) = sqrt(((LlaneDB(n).start_end_point(1,1) -...
                current_gps_lat)*(110.575*1000))^2 ...
        + ((LlaneDB(n).start_end_point(1,2) - current_gps_long)...
        *(82.4102*1000))^2) + sqrt(((RlaneDB(n).start_end_point(1,1) -...
                current_gps_lat)*(110.575*1000))^2 ...
        + ((RlaneDB(n).start_end_point(1,2) - current_gps_long)...
        *(82.4102*1000))^2) + ...
        sqrt(((LlaneDB(n).start_end_point(2,1) -...
                current_gps_lat)*(110.575*1000))^2 ...
        + ((LlaneDB(n).start_end_point(2,2) - current_gps_long)...
        *(82.4102*1000))^2) + sqrt(((RlaneDB(n).start_end_point(2,1) -...
                current_gps_lat)*(110.575*1000))^2 ...
        + ((RlaneDB(n).start_end_point(2,2) - current_gps_long)...
        *(82.4102*1000))^2);
end

Seg_index = find(pos_error==min(pos_error));

%% Evaluating the Lookahead distance (vs) Current Segment Length
Current_LL_Stuct = LlaneDB(Seg_index);
Current_RL_Stuct = RlaneDB(Seg_index);
%% Generate the GPS Positions of Current Segment 
if strcmp(LorR,'L')
    [LaneGPS,Lane_curv] =  FindLaneGPS(Current_LL_Stuct);
else
    [LaneGPS,Lane_curv] =  FindLaneGPS(Current_RL_Stuct);
end
%% Finding the index within the lane GPS Positions where current vehicle lies.
for i = 1:length(LaneGPS)
    Dist_LaneGPS(i) = Distance_bw_2_GPSposition(current_gps_lat,current_gps_long,LaneGPS(i,1),LaneGPS(i,2),'deg');   % Distances from Current vehicle Position to all Lane GPS Positions
end
Min_Inx = find(min(Dist_LaneGPS)==Dist_LaneGPS);    % Taking minimum of all distances to find the index
if (Min_Inx==length(LaneGPS))
C_D_EoS = 0;    
else
% Finding the Distance from the index to end of Segment.
C_D_EoS = Distance_bw_SegBoundaries(LaneGPS(Min_Inx:end,:));
end
Current_LaneSegmentPoints = LaneGPS(Min_Inx:end,:);    % Extracting all points from Current Index to End of Segment
Current_LaneCurvePoints = Lane_curv(Min_Inx:end,:);    % Extracting all points from Current Index to End of Segment


DiffValue = LAD - C_D_EoS;
% If this Difference value is Positive , it needs to search further
% segments to get the data.
% if this Difference value is Negative , it needs to remove some points
% from the current lane data

if (DiffValue<=0)
    % Remove Some points from the Current Dataset
    Len = length(LaneGPS);
    il = Min_Inx;
    tempD = 0;
    while il < Len
        clear tempCheck
        D =  Distance_bw_2_GPSposition(LaneGPS(il,1),LaneGPS(il,2),LaneGPS(il+1,1),LaneGPS(il+1,2),'deg');
        tempD = tempD + D;
        if (tempD>LAD)
            L_EndInx = il;
            tempCheck = true;
            break;
        end
        il = il+1;
    end
    if ~(exist('tempCheck','var'))
        L_lastEndInx = il;
    end
    % Save the Required laneData according to Lookahead Distance to a variable
    OutputLaneData = LaneGPS(Min_Inx:L_EndInx,:);
    OutputLaneCurv = Lane_curv(Min_Inx:L_EndInx,:);
else
    % Search for the points in the following segments till it meets the
    % requirement of LookAhead Distance
    NSeg_Inx = Seg_index + 1;
    tempSegLen = 0;
    while (NSeg_Inx<TotalSeg)
        clear tempvalCheck
        if strcmp(LorR,'L')
            Next_Lane_Stuct = LlaneDB(NSeg_Inx);
        else
            Next_Lane_Stuct = RlaneDB(NSeg_Inx);
        end
        SegLen = Next_Lane_Stuct.SegLength;
        tempSegLen = tempSegLen+SegLen;
        if (DiffValue<tempSegLen)
            Lane_EndSegInx = NSeg_Inx;
            tempvalCheck = true;
            break;
        end
        NSeg_Inx = NSeg_Inx+1;
        
    end
    if ~exist('tempvalCheck','var')
        Lane_EndSegInx = TotalSeg;
    end
    % Getting no of Segments Needed to match the LookAhead distance.
    NSegments = [Seg_index+1 : Lane_EndSegInx];
    tmpL = 1;
    tmpD = 0;
    for ij = 1:length(NSegments)
        SegNo = NSegments(ij);
        if (ij~=length(NSegments))
            % For all Starting Segments
            if strcmp(LorR,'L')
                temp_Lane_Stuct = LlaneDB(SegNo);
            else
                temp_Lane_Stuct = RlaneDB(SegNo);
            end
            tmpD = tmpD+temp_Lane_Stuct.SegLength;

            [LaneGPS,Lane_curv] =  FindLaneGPS(temp_Lane_Stuct);
            
            tempLaneDATA(tmpL:tmpL+length(LaneGPS)-1,:) = LaneGPS;
            tempLaneCURV(tmpL:tmpL+length(Lane_curv)-1,:) = Lane_curv;
            tmpL = tmpL+length(LaneGPS);
        else
            % For Last Segment
            if strcmp(LorR,'L')
                temp_Lane_Stuct = LlaneDB(SegNo);
            else
                temp_Lane_Stuct = RlaneDB(SegNo);
            end
            Last_Segleng = temp_Lane_Stuct.SegLength;
            %Finding the Remaining Distance
            RemDis = DiffValue - tmpD;  
            [LaneGPS,Lane_curv] =  FindLaneGPS(temp_Lane_Stuct);
            tempD = 0;
            il = 1;
            while il < length(LaneGPS)
                clear tempCheck
                D =  Distance_bw_2_GPSposition(LaneGPS(il,1),LaneGPS(il,2),LaneGPS(il+1,1),LaneGPS(il+1,2),'deg');
                tempD = tempD + D;
                if (tempD>RemDis)
                    L_lastEndInx = il;
                    tempCheck = true;
                    break;
                end
                il = il+1;
            end
            if ~(exist('tempCheck','var'))
              L_lastEndInx = il;
            end
            tempLaneDATA(tmpL:tmpL+L_lastEndInx-1,:) = LaneGPS(1:L_lastEndInx,:); 
            tempLaneCURV(tmpL:tmpL+L_lastEndInx-1,:) = Lane_curv(1:L_lastEndInx,:);
        end
     ForLoopCheck = true;
    end
    if exist('ForLoopCheck','var')
    OutputLaneData = [Current_LaneSegmentPoints;tempLaneDATA];
    OutputLaneCurv = [Current_LaneCurvePoints;tempLaneCURV];
    else
    OutputLaneData = Current_LaneSegmentPoints;
    OutputLaneCurv = Current_LaneCurvePoints;
    end
end
end