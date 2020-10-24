
close all
clear all

lambda=0.785; % wavelength [um] 1.0787;
minimum_wavelength=0.620; %um
maximum_wavelength=0.8450; %um
step=0.005;
wavelength_tot=minimum_wavelength:step:maximum_wavelength;

setup_dispersion;

% number_of_layers=100;
number_of_orders=25; % odd number

phi0=90; % conical angle [degree], 0=planar diffraction
psi0=0; % polarization angle [degree], 0-TM polarization, 90-TE polarization

% theta0=80;
minimum_angle=68.0; % theta [degree] 
maximum_angle=69.6; % theta [degree]
step_angle=0.2;

n_prism=1.51;
n_medium=1.33;
n_layer=1.44;
thickness_layer=0.010;
% thickness_layer=10;
% wire_height=0.1; % total thickness [um] (exception grating=10)
% wire_width=0.6;
Lambda=12;


theta_tot=minimum_angle:step_angle:maximum_angle;
% theta_tot=theta0;

reflectivity_flat_tot=zeros(length(theta_tot),length(wavelength_tot));
reflectivity2_flat_tot=zeros(length(theta_tot),length(wavelength_tot));

 

for itheta=1:length(theta_tot)
    
    thickness_gold_layer=0.050;
    theta0=theta_tot(itheta);
    
    n_medium=1.33;
    n_layer=1.38;
    main_gold_layer_for_skript_wavelength;
    reflectivity_flat_tot(itheta,:)=a(:,2);

    n_medium=1.33;
    n_layer=1.48;
    main_gold_layer_for_skript_wavelength;
    reflectivity2_flat_tot(itheta,:)=a(:,2);
     
    deltaindex=0.1;
    
end
save(['temp_sensitivity.mat']);

 


% figure;
% plot(wavelength_tot, reflectivity_flat_tot)
% hold on
% plot(wavelength_tot, reflectivity2_flat_tot)
% 
% 
% figure;
% plot(wavelength_tot, reflectivity2_flat_tot./reflectivity_flat_tot)
%  

  
h1=figure(2);
h2=figure(3);
h3=figure(4);
h4=figure(5);
h5=figure(6);
h7=figure(7);

 

for itheta=1:length(theta_tot)

    theta0=theta_tot(itheta);


    [dip]=sensitivity_dip(wavelength_tot,reflectivity_flat_tot(itheta,:),reflectivity2_flat_tot(itheta,:),deltaindex);


    sprwavelength_flat(itheta)=dip.sprwavelength1;
    sprwidth_flat(itheta)=dip.width;
    sprkontrast_flat(itheta)=dip.kontrast;
    sensitivity_flat(itheta)=dip.sensitivity;
    FOM_flat(itheta)=dip.FOM;

    if sensitivity_flat(itheta)>0.3000 || sprkontrast_flat(itheta)<0.15
        sprwavelength_flat(itheta)=NaN;
        sprwidth_flat(itheta)=NaN;
        sprkontrast_flat(itheta)=NaN;
        sensitivity_flat(itheta)=NaN;
        FOM_flat(itheta)=NaN;

    end

end

        
figure(1);
imagesc(wavelength_tot,theta_tot,reflectivity_flat_tot)
colorbar;
set(gca,'YDir','normal')
xlabel('Wavelength (um)')
ylabel('Angle (deg)')
title('Reflectivity (-)')
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Color', 'w');
set( findobj(gca,'type','line'), 'LineWidth', 2);
caxis([0 1])
export_fig(['results_flat_thickness',num2str(thickness_gold_layer*1000),'.png'])

 set(0, 'currentfigure', 2);
 hold on
 plot(theta_tot, sensitivity_flat*1000); 
 hold off

 set(0, 'currentfigure', 3);
 hold on
 plot(theta_tot, FOM_flat);
 hold off

 set(0, 'currentfigure', 4);
 hold on
 plot(theta_tot, sprwavelength_flat*1000);
 hold off

 set(0, 'currentfigure', 5);
 hold on
 plot(sprwavelength_flat*1000, FOM_flat/1)
 hold off

 set(0, 'currentfigure', 6);
 hold on
 plot(theta_tot,sprwidth_flat*1000);
 hold off

 set(0, 'currentfigure', 7);
 hold on
 plot(theta_tot,sprkontrast_flat);
 hold off

figure(2);
ylabel('Sensitivity (nm/RIU)')
xlabel('Angle (deg)')

set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Color', 'w');
set( findobj(gca,'type','line'), 'LineWidth', 2);
export_fig(['sensitivity_angle_flat_thickness',num2str(thickness_gold_layer*1000),'.png'])


figure(3);
ylabel('FOM (1/RIU)')
xlabel('Angle (deg)')

set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Color', 'w');
set( findobj(gca,'type','line'), 'LineWidth', 2);
export_fig(['FOM_angle_flat_thickness',num2str(thickness_gold_layer*1000),'.png'])

figure(4);
ylabel('SPR wavelength (nm)')
xlabel('Angle (deg)')

set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Color', 'w');
set( findobj(gca,'type','line'), 'LineWidth', 2);
export_fig(['sprwavelength_angle_flat_thickness',num2str(thickness_gold_layer*1000),'.png'])

figure(5);
ylabel('FOM/fillfactor (1/RIU)')
xlabel('SPR wavelength (nm)')

set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Color', 'w');
set( findobj(gca,'type','line'), 'LineWidth', 2);
export_fig(['FOMfill_wavelength_flat_thickness',num2str(thickness_gold_layer*1000),'.png'])



figure(6);

ylabel('Width (nm)')
xlabel('Angle (deg)')
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Color', 'w');
set( findobj(gca,'type','line'), 'LineWidth', 2);
export_fig(['Width _angle_flat_thickness',num2str(thickness_gold_layer*1000),'.png'])




figure(7);

ylabel( 'Contrast (-)')
xlabel('Angle (deg)')
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Color', 'w');
set( findobj(gca,'type','line'), 'LineWidth', 2);
export_fig(['Contrast_angle_flat_thickness',num2str(thickness_gold_layer*1000),'.png'])




 