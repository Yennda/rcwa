clear all
% close all
warning('off','all')
set(groot,'defaultAxesFontSize',20)

set(groot,'defaultAxesFontName','Palatino linotype')
rcwa=Rcwa;

rcwa.lambda=0.6328;
a=15;
disp(grating_period(rcwa.lambda));
% rcwa.Lambda=grating_period(rcwa.lambda);
rcwa.Lambda=0.453;
rcwa.depth = 150/1000; % grating thickness [um]
rcwa.amplitude = 35/1000;

rcwa.dn_layer_thickness=0.02;
% rcwa.n1=1.55; %glass

rcwa.n1=1.33; %water


rcwa.number_of_orders=81; % odd number
rcwa.drw_plt=1;
rcwa.theta0=20;
% rcwa.input_grating_file='grating_prism_excitation.m';


disp('lambda, Lambda, depth, amplitude');
disp(num2str([rcwa.lambda rcwa.Lambda rcwa.depth rcwa.amplitude]));

rcwa.measurement = 2;

rcwa.mini=700/1000;
rcwa.maxi=800/1000;
rcwa.step=1/1000;


rcwa.diffraction_efficiencies_c = 1;
rcwa.studying_order = 0;
rcwa.measurement = 0;
rcwa.Compute()

% saw = rcwa.Sensitivity_at_wl(true)

% disp('sen at wl' + num2str(saw))

% 
% rcwa.Spectrum();
% rcwa.Sensitivity(false);

% disp('S_s:');
% 
% disp(rcwa.Sensitivity_at_wl(false));



