
close all
clear all 

thickness_gold_layer=0.050;
 
h1=figure(2);
h2=figure(3);
h3=figure(4);
h4=figure(5);
h5=figure(6);
h7=figure(7);

load(['results_flat_thickness',num2str(thickness_gold_layer*1000),'.mat']);

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






beep;