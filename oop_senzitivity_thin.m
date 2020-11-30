clear all
% close all
warning('off','all')

rcwa=Rcwa;

rcwa.lambda=0.748;

% disp(grating_period(rcwa.lambda));
% rcwa.Lambda=grating_period(rcwa.lambda);
rcwa.Lambda=0.540;
rcwa.amplitude=70/1000;
rcwa.depth=150/1000; 

rcwa.dn_layer_thickness=0.02;
% rcwa.dn_layer_thickness=0;
rcwa.n1=1.33; %water
rcwa.number_of_orders=131; % odd number
rcwa.drw_plt=2;
% rcwa.theta0=3.38;
rcwa.theta0=0;

rcwa.input_grating_file='lyutakov_output.m';

TIME=datetime;

disp('lambda, Lambda, depth, amplitude');
disp(num2str([rcwa.lambda rcwa.Lambda rcwa.depth rcwa.amplitude]));

rcwa.mini=0.700;
rcwa.maxi=0.800;
rcwa.step=1/1000;
 
% d_list=[20 30 40 50 150];
% 
% for id=d_list
%     rcwa.depth=id/1000;
%     rcwa.Sensitivity(false);e
%     disp(datetime-TIME);
% 
% end

rcwa.measurement=2;
% rcwa.Compute()

% rcwa.Spectrum();

% disp('sen at wl')
% disp(rcwa.Sensitivity_at_wl(false));

rcwa.Sensitivity(true);
% rcwa.Spectrum();

% disp('S_s:');

% disp(rcwa.Sensitivity_at_wl(false));

disp(datetime-TIME);

