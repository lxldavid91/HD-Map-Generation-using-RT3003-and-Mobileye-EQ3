function [num_seg, num_seg_NL_1, num_seg_NL_2, segment_idx, Segment_distance, NL_Dis_1, NL_Dis_2]...
    = Flex_Route_Segment(Lat,Long,length_seg,NLL_GPS_Hgw_1, NLL_GPS_Hgw_2)

num_seg_NL_1 = round(length(NLL_GPS_Hgw_1)/length_seg);
num_seg_NL_2 = round(length(NLL_GPS_Hgw_2)/length_seg);
%% Load the data where lane is splitting and merging
[fileName,directoryName] = uigetfile('*.mat','Please click the Lane_Segment Data file in the directory');
if(fileName == 0)
    dispaly('No  file is selected. Please select the right data file'); 
    return;
else
   lane_seq_idx=load([directoryName fileName]);
end

%% find the turning area where the area seqmented seperately
 
 row =length(Lat);
 
 fid=[1:length_seg:row];
 fid=sort([fid lane_seq_idx.Lane_merge_segment_index'])';
 fid=unique(fid);
 
 %% find to short segment and remove it
  seg_len=diff (fid);
  Short_Seg_len_idx= find(seg_len == 1);
 
  for i=1: length(Short_Seg_len_idx)
      fid=[ fid(1:Short_Seg_len_idx(i),1); fid(Short_Seg_len_idx(i)+2:end)];
  end    
 
  newFid=fid;
 %flag2=GenerateKMLwith1EmbedData(Lat(fid),Long(fid), fid,'Seqment.kml', 'r');

 

%length_seg = 20;  % 10 meters segmentation
num_seg = length(fid);
segment_idx=fid;

Segment_distance=[];
for n = 1: num_seg
   
     if(n == num_seg) 
        
        tmpLat=Lat( segment_idx(n):row);
        tmpLong=Long( segment_idx(n):row);
        D = Distance_bw_SegBoundaries([tmpLat  tmpLong] );
        Segment_distance(n)=D;
        break;
     else
        
        tmpLat=Lat(segment_idx(n):segment_idx(n+1)-1);
        tmpLong=Long(segment_idx(n):segment_idx(n+1)-1);
        D = Distance_bw_SegBoundaries([tmpLat  tmpLong] );
        Segment_distance(n)=D;
     end

end


for i =1:num_seg_NL_1
    
    if(i == num_seg_NL_1)
        NL_Dis_1(i) = Distance_bw_SegBoundaries(NLL_GPS_Hgw_1(i:end,:));
    end
    
NL_Dis_1(i) = Distance_bw_SegBoundaries(NLL_GPS_Hgw_1(i:i+length_seg-1,:));
end

for i =1:num_seg_NL_2
    
    if(i == num_seg_NL_2)
        NL_Dis_2(i) = Distance_bw_SegBoundaries(NLL_GPS_Hgw_2(i:end,:));
    end

NL_Dis_2(i) = Distance_bw_SegBoundaries(NLL_GPS_Hgw_2(i:i+length_seg-1,:));
end

