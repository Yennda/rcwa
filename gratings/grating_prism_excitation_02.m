% !! For RCWA calculation: comment “clear all�? and set plot_grating=2;


% plot_grating=1;

n_glass = 1.55;
n_resist = 1.7;
% n_resist = 1.55;
n_water = 1.33;

n1=1.55;
n3 = n_water;

thickness_resist = 200/1000;
thickness_glass = 100/1000;


% layer_1=add_hom_layer(Lambda,thickness_glass,n_resist);
layer_1=add_hom_layer(Lambda,thickness_resist,n_resist);
layer_2=add_hom_layer(Lambda,1/1000,chromium);
layer_3=add_hom_layer(Lambda,depth,gold);



% layer_6=add_hom_layer(Lambda,5,n_water);
% layer_5=add_hom_layer(Lambda,dn_layer_thickness,1.33);

create_grating;

