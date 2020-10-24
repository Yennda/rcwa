

ilambda_list=[600 620 640 660];
LM_list=-15:1:15;
d_list=10:5:60;

all_info=zeros(length(ilambda_list), 7);
ii=1;

for ilambda=ilambda_list
    Lambda=grating_period(ilambda/1000);
    
    pre=load(['saved_data/sensitivities_d_LM_', num2str(ilambda/1000), '.mat']); 
    Graph_mat=pre.Graph_mat;
    [M, I]=max(Graph_mat(:));
    
    [I_row, I_col] = ind2sub(size(Graph_mat),I);
    
    [Mm, Im]=min(Graph_mat(:));
    [Im_row, Im_col] = ind2sub(size(Graph_mat),Im);
    
    all_info(ii,1)=ilambda;
    all_info(ii,3)=LM_list(I_row)+Lambda*1000;
    all_info(ii,2)=d_list(I_col);
    all_info(ii,4)=M;
    all_info(ii,6)=LM_list(Im_row)+Lambda*1000;
    all_info(ii,5)=d_list(Im_col);
    all_info(ii,7)=Mm;
    
    ii=ii+1;
end




