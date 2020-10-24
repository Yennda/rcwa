% !! For RCWA calculation: comment â€œclear allâ€? and set plot_grating=2;


% plot_grating=1;

n_glass = 1.55;
n_resist = 1.51;
n_water = 1.33;

n1=1.55;
n3 = n_water;

thickness_resist = 1000/1000;
thickness_glass = 100/1000;

layer_1=add_hom_layer(Lambda,thickness_resist,n_glass);
layer_2=add_hom_layer(Lambda,thickness_glass,n_resist);

layer_3=add_sin_layer(Lambda,Lambda,amplitude,gold, n_resist,20);
layer_4=add_hom_layer(Lambda,depth-amplitude,gold);

% layer_3=add_sin_layer(Lambda,Lambda,depth,ns,gold,20);
% layer_4=add_hom_layer(Lambda,dn_layer_thickness,ns);

layer_5=add_sin_layer(Lambda,Lambda,amplitude,n_water,gold,20);
% layer_6=add_hom_layer(Lambda,5,n_water);
% layer_5=add_hom_layer(Lambda,dn_layer_thickness,1.33);

create_grating;

