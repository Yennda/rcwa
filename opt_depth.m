% Sinusoidal grating
% perpendicular incidence

close all;
clear all;
measurement=2;

lambda=0.785; %[um]
Lambda=0.5633; %[um]
thickness_total=0.02; % total thickness [um] (exception grating=10)
n1=1.332; %water
dn=0.005; % 2% solution of NaCl in water

my_main;
save_data=data2;

% changes for the second computation
n1=n1+dn; %water

my_main;


figure
plot(data2(:,1), data2(:,2),data2(:,1),save_data(:,2))
ylabel('efficiency 0R')
hold on


my_delta_ref=data2(:,2)-save_data2(:,2);

yyaxis right
plot(data2(:,1), my_delta_ref(:,1)/dn)
hold off

xlabel('\lambda [nm]')
ylabel('[nm/RIU]')
title('Bulk sensitivity')
