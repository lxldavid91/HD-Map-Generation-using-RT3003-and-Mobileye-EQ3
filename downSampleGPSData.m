function [D_Lat,D_Long,D_Head,DS_index] = downSampleGPSData...
    (Lat,Long,Head,distance)
%% DownSamples GPS Data
% This Module downsamples GPS Data based on the input distance
% INPUTS : Lat,Long and Heding Arrays and distance
% OUTPUTS: Downsampled Lat,Long and heading based on input distance
% Copyrights : Changan US R&D Center Inc ,2017

%Temporary variables
tmp=2;
% Saving First Location
DS(1,:) = [Lat(1) Long(1) Head(1) 1];
% Length of DataSet
MI = length(Lat);
inx1 = 1;
inx2 = 1;
while (inx1<MI)
    while (inx2<MI)
        D = Distance_bw_2_GPSposition(Lat(inx1),Long(inx1),Lat(inx2),Long(inx2),'deg');
        if ~(D<distance) % Finds the nearest GPS Position of given distance (approx)
           DS(tmp,1) = Lat(inx2);
           DS(tmp,2) = Long(inx2);
           DS(tmp,3) = Head(inx2);
           DS(tmp,4) = inx2;
           tmp = tmp+1;
           inx1 = inx2;
           inx2 = inx2+1;
           break;
        else
           inx2 = inx2+1;  
        end
    end
    if (inx2==MI)
           DS(tmp,1) = Lat(inx2);
           DS(tmp,2) = Long(inx2);
           DS(tmp,3) = Head(inx2);
           DS(tmp,4) = inx2;
       break; 
    end
  
end
D_Lat  = DS(:,1);
D_Long = DS(:,2);
D_Head = DS(:,3);
DS_index = DS(:,4);
end