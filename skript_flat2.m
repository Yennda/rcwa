
% close all
clear all

lambda=0.785; % wavelength [um] 1.0787;
minimum_wavelength=0.5; %um
maximum_wavelength=1.2; %um
step=0.005;
wavelength_tot=minimum_wavelength:step:maximum_wavelength;

setup_dispersion;

% number_of_layers=100;
number_of_orders=25; % odd number

phi0=0; % conical angle [degree], 0=planar diffraction
psi0=0; % polarization angle [degree], 0-TM polarization, 90-TE polarization

theta0=70;
% minimum_angle=65; % theta [degree] 
% maximum_angle=89; % theta [degree]
% step_angle=2;

n_prism=1.51;
n_medium=1.33;
n_layer=1.44;
thickness_layer=0.010;

% wire_height=0.1; % total thickness [um] (exception grating=10)
% wire_width=0.6;
Lambda=12;


% theta_tot=minimum_angle:step_angle:maximum_angle;
theta_tot=theta0;

reflectivity_flat_tot=zeros(length(theta_tot),length(wavelength_tot));
reflectivity2_flat_tot=zeros(length(theta_tot),length(wavelength_tot));

 

for itheta=1:length(theta_tot)
    
    thickness_gold_layer=0.050;
    theta0=theta_tot(itheta);
    
    n_medium=1.33;
    n_layer=1.44;
    main_gold_layer_for_skript_wavelength;
    reflectivity_flat_tot(itheta,:)=a(:,2);

    n_medium=1.33;
    thickness_gold_layer=0.040;
%     n_prism=1.52;
    main_gold_layer_for_skript_wavelength;
    reflectivity2_flat_tot(itheta,:)=a(:,2);
     
    deltaindex=0.1;
    
end
% save(['results_flat_thickness',num2str(thickness_gold_layer*1000),'.mat']);

 


figure;
plot(wavelength_tot, reflectivity_flat_tot)
hold on
plot(wavelength_tot, reflectivity2_flat_tot)


figure;
plot(wavelength_tot, reflectivity2_flat_tot./reflectivity_flat_tot)
 

%     

beep;