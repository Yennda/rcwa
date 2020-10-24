% !! For RCWA calculation: comment â€œclear allâ€? and set plot_grating=2;

plot_grating=1;


layer_1=add_hom_layer(Lambda,dn_layer_thickness,ns);
layer_2=add_sin_layer(Lambda,Lambda,depth,gold,ns,20);

create_grating;