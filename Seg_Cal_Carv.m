function [LL_Carv, RL_Carv] = Seg_Cal_Carv(num_seg, ...
     p_ll_all,p_rl_all, left_lane_x, right_lane_x, seqment_idx)
%Only calculated left lane carvature

% LL_Carv = zeros(num_seg, length_seg);
% RL_Carv = zeros(num_seg, length_seg);
%NL_seg_num = 20;
row=length(left_lane_x);
LL_Carv = struct;
RL_Carv = struct;

% for n = 1:num_seg_NL_1
%     
%     NLL_Carv_1(n).name = ['NLL_Carv_1_seg_',num2str(n)] ;
%     NRL_Carv_1(n).name = ['NRL_Carv_1_seg_',num2str(n)] ;
%     NLL_Carv_1(n).curvature = zeros(NL_seg_num,1);
%     NRL_Carv_1(n).curvature = zeros(NL_seg_num,1);
%     
%     
% end

% for n = 1:num_seg_NL_2
%     
%     NLL_Carv_2(n).name = ['NLL_Carv_2_seg_',num2str(n)] ;
%     NRL_Carv_2(n).name = ['NRL_Carv_2_seg_',num2str(n)] ;
%     NLL_Carv_2(n).curvature = zeros(NL_seg_num,1);
%     NRL_Carv_2(n).curvature = zeros(NL_seg_num,1);
%     
% end


for n = 1:num_seg
    
     if(n == num_seg)
         
         LL_Carv(n).name = ['LL_Carv_seg_',num2str(n)] ;
         RL_Carv(n).name = ['RL_Carv_seg_',num2str(n)] ;
         
         LL_Carv(n).curvature = (Cal_Curvature...
             (left_lane_x(seqment_idx(n):row),p_ll_all(n,:)))';
         
         RL_Carv(n).curvature = (Cal_Curvature...
             (right_lane_x(seqment_idx(n):row),p_rl_all(n,:)))';
               
    break;
     end
    
    LL_Carv(n).name = ['LL_Carv_seg_',num2str(n)] ;
    RL_Carv(n).name = ['RL_Carv_seg_',num2str(n)] ;
    
    LL_Carv(n).curvature = (Cal_Curvature(left_lane_x(seqment_idx(n):seqment_idx(n+1)-1)...
        ,p_ll_all(n,:)))';
    RL_Carv(n).curvature = (Cal_Curvature(right_lane_x(seqment_idx(n):seqment_idx(n+1)-1)...
        ,p_rl_all(n,:)))';
    
    
end


end

