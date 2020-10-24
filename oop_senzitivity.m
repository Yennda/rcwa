clear all
% close all
warning('off','all')
set(groot,'defaultAxesFontSize',20)

set(groot,'defaultAxesFontName','Palatino linotype')
rcwa=Rcwa;

rcwa.lambda=0.700;
a=15;
disp(grating_period(rcwa.lambda));
% rcwa.Lambda=grating_period(rcwa.lambda);
rcwa.Lambda=0.527;
rcwa.depth = 50/1000; % grating thickness [um]
rcwa.amplitude = 25/1000;

rcwa.dn_layer_thickness=0.1;
rcwa.n1=1.55; %glass

% rcwa.n1=1; %air
% rcwa.dn = 1.47-1.33

rcwa.number_of_orders=81; % odd number
rcwa.drw_plt=2;
rcwa.theta0=63.5;
% rcwa.input_grating_file='grating_prism_excitation.m';


disp('lambda, Lambda, depth, amplitude');
disp(num2str([rcwa.lambda rcwa.Lambda rcwa.depth rcwa.amplitude]));

rcwa.measurement = 6

rcwa.mini=0;
rcwa.maxi=30;
rcwa.step=0.1;

% rcwa.measurement = 0;
% rcwa.Compute()
% disp('sen at wl')
% disp(rcwa.Sensitivity_at_wl(true));
% 
% 
rcwa.Spectrum();
% rcwa.Sensitivity(true);

% disp('S_s:');
% 
% disp(rcwa.Sensitivity_at_wl(false));



