function [ Hgw_index ] = Find_Hgw_Index( NLL_GPS_Hgw_pt,NLL_GPS)

pos_error = zeros(length(NLL_GPS),1);

for n = 1:length(NLL_GPS)

    pos_err_1(n,1) = sqrt(((NLL_GPS(n,1) - NLL_GPS_Hgw_pt(1,1))*...
        (110.575*1000))^2) + sqrt(((NLL_GPS(n,2) - NLL_GPS_Hgw_pt(1,2))...
        *(82.4102*1000))^2);
    
    pos_err_2(n,1) = sqrt(((NLL_GPS(n,1) - NLL_GPS_Hgw_pt(2,1))*...
        (110.575*1000))^2) + sqrt(((NLL_GPS(n,2) - NLL_GPS_Hgw_pt(2,2))...
        *(82.4102*1000))^2);
    
     pos_err_3(n,1) = sqrt(((NLL_GPS(n,1) - NLL_GPS_Hgw_pt(3,1))*...
        (110.575*1000))^2) + sqrt(((NLL_GPS(n,2) - NLL_GPS_Hgw_pt(3,2))...
        *(82.4102*1000))^2);
    
     pos_err_4(n,1) = sqrt(((NLL_GPS(n,1) - NLL_GPS_Hgw_pt(4,1))*...
        (110.575*1000))^2) + sqrt(((NLL_GPS(n,2) - NLL_GPS_Hgw_pt(4,2))...
        *(82.4102*1000))^2);

end

Hgw_index = zeros(4,1);

for j = 1:4
    
Hgw_index(1) = find(pos_err_1==min(pos_err_1));
Hgw_index(2) = find(pos_err_2==min(pos_err_2));
Hgw_index(3) = find(pos_err_3==min(pos_err_3));
Hgw_index(4) = find(pos_err_4==min(pos_err_4));


end





end