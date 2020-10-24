clear all
close all
warning('off','all')


load('saved_data/sensitivities_d_LM_600.mat', 'Graph_mat');
Lambda=grating_period(0.600);
LM_list=-30:1:30;
d_list=10:5:100;
    
    
figure;
pcolor(d_list, round(LM_list+Lambda*1000), Graph_mat);
%     heatmap(d_list, round(LM_list+Lambda*1000), Graph_mat);
xlabel('depth d [nm]')
ylabel('\Lambda [nm]')
title('Surface sensitivity')
colorbar;
% saveas(gcf,['saved_figures/optim_att', num2str(rcwa.lambda*1000), '.png']) 
% save(['saved_data/sensitivities_d_LM_', num2str(rcwa.lambda*1000), '.mat'],'Graph_mat')

%     close all

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

% save('saved_data/all_info.mat', 'all_info');



% save('saved_data/all_info.mat', 'all_info');
figure
plot(all_info(:,1),all_info(:,4),all_info(:,1),all_info(:,7));

disp(datetime-TIME);
           
           
           