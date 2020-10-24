% Sinusoidal grating
% perpendicular incidence

% close all;
clear all;
measurement=2;


amplitude=0.5; % total thickness [um] (exception grating=10)
thickness_total=amplitude;


lambda=0.750; %[um]
Lambda=0.5275; %[um]
n1=1.332; %water
ns=n1; % IR of layer on the surface
thickness_surf=0.02; % thickness of layer on the surface
dn=0.005; % 2% solution of NaCl in water


% 1st computation; no IR change
my_main;
save_data=data2;

% 2nd computation; surface sensitivity
ns=n1+dn; 
my_main;


figure
plot(data2(:,1), data2(:,2),data2(:,1),save_data(:,2))
ylabel('efficiency 0R')
hold on

my_delta_ref=data2(:,2)-save_data(:,2);

yyaxis right
plot(data2(:,1), my_delta_ref(:,1)/dn)
hold off

xlabel('\lambda [nm]')
ylabel('[nm/RIU]')
title('Surface sensitivity')


% 3rd computation; bulk sensitivity
n1=n1+dn;
my_main;


figure
plot(data2(:,1), data2(:,2),data2(:,1),save_data(:,2))
ylabel('efficiency 0R')
hold on

my_delta_ref=data2(:,2)-save_data(:,2);

yyaxis right
plot(data2(:,1), my_delta_ref(:,1)/dn)
hold off

xlabel('\lambda [nm]')
ylabel('[nm/RIU]')
title('Bulk sensitivity')
