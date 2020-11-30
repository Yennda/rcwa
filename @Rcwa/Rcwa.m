classdef Rcwa < handle
   properties
       lambda=0.785; % wavelength (um)       
       theta0=0;  % incident angle [degree]
       
       Lambda=0.5633; % grating period [um] (exception grating=10)
%        thickness_total=0.02; % total thickness [um] (exception grating=10)
       dn_layer_thickness=0.02; % thickness of layer on the surface
       depth=0.02; % grating depth[um]
       amplitude=0.02;
       n1=1.33; %water
       dn=0;
       
       polarization=1;
       input_grating_file='opt_sin_grating.m';
       measurement=2;
       number_of_orders=81; % odd number
       drw_plt=2; %1-yes, 2-no       
       grating=10; % switch grating
       
       % interval settings for measurements
       mini=0.6;
       maxi=0.9;
       step=0.001; 
       change_of_index
       
       % storage of data arising from computation
       data
       saved_data
       S_s
       S_b
       
       diffraction_efficiencies_c=1; %1--D_R, 2--D_T
       studying_order=0; %check minimum_number_of_orders

   end   
   properties (Access = public)
       
   end
   methods
       function sen=Sensitivity_at_wl(obj, bulk)
           mes=obj.measurement;
           obj.measurement=0;
           ddn=0.005;
           obj.dn=0;
           obj.Compute;
           ref1=obj.data(end);
           if bulk
%                obj.n1=obj.n1+ddn;
               obj.dn=ddn;
               obj.Compute;
%                obj.n1=obj.n1-ddn;
               obj.dn=0;
               % data(2)
               sen=(ref1-obj.data(end))/ddn;
           else
               obj.dn=ddn;
               obj.Compute;
               obj.dn=0;
               sen=(ref1-obj.data(end))/ddn;
           end
           obj.measurement=mes;
       end
       function Compute(obj)
            lambda=obj.lambda;
            theta0=obj.theta0;

            Lambda=obj.Lambda;
%             thickness_total=obj.thickness_total;
            dn_layer_thickness=obj.dn_layer_thickness;
            depth=obj.depth;
            amplitude=obj.amplitude;
            n1=obj.n1;
            dn = obj.dn; 
            ns=obj.n1+obj.dn;       

            
            polarization=obj.polarization;
            input_grating_file=obj.input_grating_file;
            measurement=obj.measurement;
            number_of_orders=obj.number_of_orders;
            drw_plt=obj.drw_plt; 
            grating=obj.grating;
            
            mini=obj.mini;
            maxi=obj.maxi;
            step=obj.step;
            change_of_index=obj.change_of_index;   
            
            diffraction_efficiencies_c = obj.diffraction_efficiencies_c;
            studying_order = obj.studying_order;
            
            if drw_plt==2
                set(0,'DefaultFigureVisible','off')
            end
            
            
            oop_main;
            set(0,'DefaultFigureVisible','on')
                       
            
            switch measurement
                case 0
                    obj.data=diff_R;
                case 1
                    obj.data=data1;
                case 2
                    obj.data=data2;
                case 3
                    obj.data=data3;
                case 4
                    obj.data=data4;
                case 6
                    obj.data=data6;
                otherwise
                        error('it is not defined')
            end
            
            if measurement>0
                [m, p] = min(obj.data(:,2));   
                disp(['Minimum at ', num2str(obj.data(p,1)*1000), ' nm']);
            end
                      

%             obj.saved_data=[obj.saved_data, obj.data];
                       
       end
       function Plot(obj)
           figure
           plot(obj.data(:,1), obj.data(:,2));
       end
       
       function Sensitivity(obj, bulk)
           obj.Compute;
           data_init=obj.data;
           %            Surface sensitivity
           obj.dn=0.005; % 2% solution of NaCl in water, or PBS
           dn=obj.dn;
           if ~bulk

               obj.Compute;
               data_s=obj.data;
               obj.dn=0;


               x_ax=data_s(:,1)*1000;
               figure
    %            plot(x_ax, data_s(:,2),x_ax,data_init(:,2), 'LineWidth', 2)
               plot(x_ax, data_s(:,2), 'LineWidth', 2)
               ylabel('R')
               ylim([0 1])
               hold on

               sensitivity_s=(data_s(:,2)-data_init(:,2))/dn;

               yyaxis right
               plot(x_ax, sensitivity_s(:,1), 'LineWidth', 2)
               hold off

               xlabel('\lambda [nm]')
               ylabel('Sensitivity [\Delta R/\DeltaRIU]')
               title('Surface sensitivity')

               disp(['Surface sensitivity at ', num2str(obj.lambda*1000), ' nm']);
               obj.S_s=sensitivity_s(find(obj.data(:,1)==obj.lambda),1);
               disp(obj.S_s);
               
    %            saveas(gcf,['saved_figures/fig_Ss_wl', num2str(obj.lambda),'Lm', num2str(obj.Lambda),'depth', num2str(obj.depth) '.png'])
               saveas(gcf,['saved_figures/Sensitivity_wl', num2str(obj.Lambda*1000),'_a', num2str(obj.amplitude*1000),'_d', num2str(obj.depth*1000),'_',num2str(obj.number_of_orders),'orders.png'])
           end
%            Bulk sensitivity            
           if bulk

               obj.n1=obj.n1+dn; % 2% solution of NaCl in water
               obj.dn=0;
               obj.Compute;
               obj.dn=0;
               
               data_b=obj.data;
               x_ax=data_b(:,1)*1000;
               figure
               plot(x_ax, data_b(:,2),x_ax,data_init(:,2), 'LineWidth', 2)
               ylabel('R')
               ylim([0 1])
               hold on

               sensitivity_b=(data_b(:,2)-data_init(:,2))/dn;

               yyaxis right
               plot(x_ax, sensitivity_b(:,1), 'LineWidth', 2)
               
               hold off
               
               grid on
               xlabel('\lambda [nm]')
               ylabel('Sensitivity [\Delta R/\DeltaRIU]')
               title('Bulk sensitivity')
               legend('q-water', 'PBS','Sensitivity', 'Location','northeast')
               disp(['Bulk sensitivity at ', num2str(obj.lambda*1000), ' nm']);
               obj.S_b=sensitivity_b(find(obj.data(:,1)==obj.lambda),1);
               disp(obj.S_b);
               
               [imin, in] = min(data_init(:,2));
               [imax, inm] = max(data_init(:,2));
               hm =(imax-imin)/2 + imin;

               disp(['minimum: ', num2str(imin)])
               disp(['lambda min: ', num2str(x_ax(in))])
               disp(['maximum: ', num2str(imax)])
               disp(['HM: ', num2str(hm)])
               width = 0;

               for i=1:1:length(data_init(:,2))
                  if data_init(i, 2) < hm
                      width = width + 1;
                  end
               end
               disp(['width: ', num2str(width)])
               disp(['smax: ', num2str(max(sensitivity_b))])
               
               disp(['smin: ', num2str(min(sensitivity_b))])


%                saveas(gcf,['saved_figures/fig_Sb_wl', num2str(obj.lambda),'Lm', num2str(obj.Lambda),'depth', num2str(obj.depth) '.png'])
           end
       end
       function Spectrum(obj)
           obj.polarization=2;
           
           de = obj.diffraction_efficiencies_c;
           so = obj.studying_order;
           obj.diffraction_efficiencies_c = 1;
           obj.studying_order = 0;
           obj.Compute;
           obj.diffraction_efficiencies_c = de;
           obj.studying_order = so;
           
           data_TE=obj.data;
           
           obj.polarization=1;
           obj.Compute;
           data_TM=obj.data;
           

           if obj.measurement == 6
               x_ax=data_TM(:,1);
           else
               x_ax=data_TM(:,1)*1000;
           end

           figure
           plot(x_ax, data_TM(:,2)./data_TE(:,2), 'k', 'LineWidth', 2)
%            hold on
%            plot(x_ax, data_TM(:,2), 'LineWidth', 2)
%            hold on
%            plot(x_ax, data_TE(:,2), 'LineWidth', 2)           
%            hold off
%            
           ylabel('R')
           ylim([0 1])
           
           xlabel('\lambda [nm]')

%            title('Spectrum')
%            legend('TM/TE')
          
           saveas(gcf,['saved_figures/Spectrum', num2str(obj.Lambda*1000),'_a', num2str(obj.amplitude*1000),'_d', num2str(obj.depth*1000),'_',num2str(obj.number_of_orders),'orders.png'])

%          
       end
           
   end
    
    
    
    
    
    
end