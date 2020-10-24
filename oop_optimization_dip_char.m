clear all
close all
warning('off','all')

TIME=datetime;



ilambda_list=[650];
% ilambda_list=[900 680 720 780 820];
all_info=zeros(length(ilambda_list), 7);
ii=1;
rcwa=Rcwa;
for ilambda=ilambda_list
    
    
    rcwa.lambda=ilambda/1000;

    Lambda=grating_period(rcwa.lambda)
%     Lambda=0.651;
    rcwa.Lambda=Lambda;
    rcwa.depth=5/1000; % grating thickness [um]
    rcwa.dn_layer_thickness=0.02;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    rcwa.n1=1.332; %water
    rcwa.number_of_orders=81; % odd number
    rcwa.measurement=0;
    rcwa.input_grating_file='opt_sin_grating.m';
    disp('lambda, Lambda, depth');
    disp(num2str([rcwa.lambda rcwa.Lambda rcwa.depth]));


    LM_list=-30:1:10;
    d_list=15:4:60;
    % LM_list=-4:0.25:2;
    % d_list=17:1:30;
    i=1;
    j=1;

    Graph_mat=zeros(length(LM_list), length(d_list));

    for LM = LM_list

        for d = d_list
            rcwa.Lambda=Lambda+LM/1000;
            rcwa.depth=d/1000;

            S_s=rcwa.Sensitivity_at_wl(false);
            mes=rcwa.measurement;
            rcwa.measurement=0;
            rcwa.dn=0;
            
            rcwa.Compute()
%             S_s=rcwa.data(2);
            disp(LM);
            disp(d);
            disp(num2str(S_s))
            
            Graph_mat(i,j)=S_s;
            j=j+1;
        end
        j=1;
        i=i+1;
        disp(i);
    end

    figure;
    pcolor(d_list, round(LM_list+Lambda*1000), Graph_mat);
%     heatmap(d_list, round(LM_list+Lambda*1000), Graph_mat);
    xlabel('depth d [nm]')
    ylabel('\Lambda [nm]')
    title('Surface sensitivity')
    colorbar;
    saveas(gcf,['saved_figures/optim_sens', num2str(rcwa.lambda*1000), '.png']) 
    save(['saved_data/sensitivities_sens_d_LM_', num2str(rcwa.lambda*1000), '.mat'],'Graph_mat')
    
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

    save('saved_data/all_info.mat', 'all_info');
    
end

save('saved_data/all_info.mat', 'all_info');
figure
plot(all_info(:,1),all_info(:,4),all_info(:,1),all_info(:,7));

disp(datetime-TIME);
           
           
           