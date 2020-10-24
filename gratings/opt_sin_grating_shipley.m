% !! For RCWA calculation: comment â€œclear allâ€? and set plot_grating=2;

plot_grating=1;
depth_tot=0.1;
nresist=1.6406; %Shipley 1818 at 633nm
nair=1;


layer_1=add_sin_layer(Lambda,Lambda,depth,nresist,nair,20); 
layer_2=add_hom_layer(Lambda,depth_tot-depth,nresist);

create_grating;
