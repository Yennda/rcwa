clear all
% close all
warning('off','all')
set(groot,'defaultAxesFontSize',20)

set(groot,'defaultAxesFontName','Palatino linotype')
rcwa=Rcwa;

rcwa.lambda=0.600;
a=15;
disp(grating_period(rcwa.lambda));
% rcwa.Lambda=grating_period(rcwa.lambda);
rcwa.Lambda=0.475;
rcwa.depth = 36/1000; % grating thickness [um]
rcwa.amplitude = 55/1000;

rcwa.dn_layer_thickness=0.02;
% rcwa.n1=1.55; %glass

rcwa.n1=1.55; %water


rcwa.number_of_orders=81; % odd number
rcwa.drw_plt=2;
rcwa.theta0=68;
rcwa.input_grating_file='grating_prism_excitation.m';

% rcwa.diffraction_efficiencies_c = 2;
% rcwa.studying_order = -1;
rcwa.diffraction_efficiencies_c = 1;
rcwa.studying_order = 0;

disp('lambda, Lambda, depth, amplitude');
disp(num2str([rcwa.lambda rcwa.Lambda rcwa.depth rcwa.amplitude]));

rcwa.measurement = 2;

rcwa.mini=620/1000;
rcwa.maxi=720/1000;
rcwa.step=1/1000;


% rcwa.measurement = 0;
% rcwa.Compute()

% saw = rcwa.Sensitivity_at_wl(true)

% disp('sen at wl' + num2str(saw))

% 
rcwa.Spectrum();
% rcwa.Sensitivity(false);

% disp('S_s:');
% 
% disp(rcwa.Sensitivity_at_wl(false));



