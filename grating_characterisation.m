clear all
close all
warning('off','all')

rcwa=Rcwa;
rcwa.Lambda=0.3875;
rcwa.depth=35/1000;  % grating thickness [um]
rcwa.dn_layer_thickness=0.02;
rcwa.n1=1; % air
rcwa.number_of_orders=81; % odd number
rcwa.measurement=0;
rcwa.input_grating_file='opt_sin_grating_shipley.m';
% rcwa.input_grating_file='opt_sin_grating.m';
rcwa.lambda=0.633;

theta_in=asin(rcwa.lambda/2/rcwa.Lambda);
disp(['Theta_in = ', num2str(rad2deg(theta_in)), '°']);

rcwa.theta0=40;
% rcwa.theta0=0;


rcwa.drw_plt=1;
rcwa.Compute();
data=rcwa.data;
rcwa.drw_plt=2;

[row1] = find(data(:,1)==-1);
[row0] = find(data(:,1)==0);

ratio=data(row1,2)/data(row0,2);

% disp(['0th order = ', num2str(rcwa.data(row0,2))]);
% disp(['-1th order = ', num2str(rcwa.data(row1,2))]);
% disp(['ration [-1]/[0] = ', num2str(ratio)]);

d_list=1:1:100;
ratio_list=[];

for d=d_list
   disp(d)
   rcwa.depth=d/1000;
   rcwa.Compute();
   idata=rcwa.data;
   [row1] = find(idata(:,1)==-1);
   [row0] = find(idata(:,1)==0);

   ratio=idata(row1,2)/idata(row0,2);
   ratio_list=[ratio_list, ratio];
end

figure;
plot(d_list, ratio_list);
grid on
xlabel('depth [nm]')
ylabel('ratio [-1]/[0]')
title('Ratio of orders depending on depth')

% theta(Lambda)

dL_list=-50:1:50;
theta_list=[];


for dL=dL_list
    theta_list=[theta_list, rad2deg(asin(rcwa.lambda/2/(rcwa.Lambda+dL/1000)))];
end

figure;
plot(dL_list+rcwa.Lambda*1000, theta_list);
grid on
xlabel('\Lambda [nm]')
ylabel('\Theta_{in}=\Theta_{-1} [°]')
title('Theta of first order depending on Lambda')







