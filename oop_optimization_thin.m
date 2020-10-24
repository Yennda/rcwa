clear all
close all
warning('off','all')

TIME=datetime;



ilambda_list=[600];
% ilambda_list=[900 680 720 780 820];
all_info=zeros(length(ilambda_list), 7);
ii=1;
rcwa=Rcwa;
for ilambda=ilambda_list
        
    rcwa.lambda=ilambda/1000;

    Lambda=grating_period(ilambda/1000);
%     Lambda=0.434;
    rcwa.Lambda=Lambda;
    rcwa.amplitude=35/1000;
    rcwa.depth=20/1000; % grating thickness [um]
    rcwa.dn_layer_thickness=0.02;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    rcwa.n1=1.332; %water
    rcwa.number_of_orders=131; % odd number
    rcwa.measurement=0;
    rcwa.input_grating_file='lyutakov_output.m';
    disp('lambda, Lambda, depth');
    disp(num2str([rcwa.lambda rcwa.Lambda rcwa.depth]));


    LM_list=0:2:60;
%     d_list=10:2:60;
    a_list=10:5:50;
    d_list=[150];


    for d = d_list
        disp(d)
        rcwa.depth=d/1000;
        Graph_mat=zeros(length(LM_list), length(a_list));
        i=1;
        j=1;
        for LM = LM_list
            disp(LM)
            for a = a_list
                disp(a)

                rcwa.Lambda=Lambda+LM/1000;
                rcwa.amplitude=a/1000;

                S_s=rcwa.Sensitivity_at_wl(false);
                mes=rcwa.measurement;
                rcwa.measurement=0;
                rcwa.dn=0;

    %             rcwa.Compute()
    %             S_s=rcwa.data(2);
    %             disp(LM);
    %             disp(a);
    %             disp(num2str(S_s))

                Graph_mat(i,j)=S_s;
                j=j+1;

            end
            j=1;
            i=i+1;
            disp(i);
        end

        figure;
        pcolor(a_list, round(LM_list+Lambda*1000), Graph_mat);
    %     heatmap(d_list, round(LM_list+Lambda*1000), Graph_mat);
        xlabel('amplitude a [nm]')
        ylabel('\Lambda [nm]')
        title(['Surface sensitivity d= ',  num2str(rcwa.depth*1000)])
        colorbar; 
        saveas(gcf,['saved_figures/thin_optim_sensitivity_d', num2str(rcwa.depth*1000),'_l' ,num2str(rcwa.lambda*1000),'_',num2str(rcwa.number_of_orders),'orders.png']) 
%         saveas(gcf,['saved_figures/thin_optim_sensitivity_a', num2str(rcwa.amplitude*1000),'_l' ,num2str(rcwa.lambda*1000),'_',num2str(rcwa.number_of_orders),'orders.png']) 
        save(['saved_data/thin_optim_sensitivity_', num2str(rcwa.depth*1000),'_' ,num2str(rcwa.lambda*1000), '.mat'],'Graph_mat')
    end
%     close all
    
%     [M, I]=max(Graph_mat(:));
%     [I_row, I_col] = ind2sub(size(Graph_mat),I);
%     
%     [Mm, Im]=min(Graph_mat(:));
%     [Im_row, Im_col] = ind2sub(size(Graph_mat),Im);
%     
%     all_info(ii,1)=ilambda;
%     all_info(ii,3)=LM_list(I_row)+Lambda*1000;
%     all_info(ii,2)=d_list(I_col);
%     all_info(ii,4)=M;
%     all_info(ii,6)=LM_list(Im_row)+Lambda*1000;
%     all_info(ii,5)=d_list(Im_col);
%     all_info(ii,7)=Mm;
%     
    ii=ii+1;

%     save('saved_data/thin_all_info.mat', 'all_info');
    
end

% save('saved_data/thin_all_info.mat', 'all_info');
figure
plot(all_info(:,1),all_info(:,4),all_info(:,1),all_info(:,7));

disp(datetime-TIME);
           
           
           