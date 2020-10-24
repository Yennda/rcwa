% !! For RCWA calculation: comment â€œclear allâ€? and set plot_grating=2;

% clear all
% plot_grating=1;

% 1-add homogeneous layer
% 2-add polygon layer
% 3-add sinus layer
% 4-add user's layer

setup_dispersion;

n_1=n_prism;
n_3=n_medium;
 



% Lambda=0.575;

% x=Lambda.*[0.1 0.3, 0.4, 0.6, 0.7, 0.9, 0.9, 0.7, 0.6, 0.6, 0.4, 0.3, 0.3];
% z_local=[0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1];

% layer_1=add_pol_layer(Lambda,x,z_local,3.3,1,20); % polygon layer
% layer_2=add_hom_layer(Lambda,1,3); % homogeneous layer
% layer_1=add_sin_layer(Lambda,Lambda,thickness_total,gold,n_1,number_of_layers); % sinus layer
layer_1=[thickness_AR_layer,0,gold,wire_width,n_3,wire_width+(width_AR_gap/2),chromium,Lambda-(width_AR_gap/2),n_3,Lambda]; % user's layer
layer_2=[thickness_gold_wire-thickness_AR_layer,0,gold,wire_width,n_3,Lambda]; % user's layer
layer_3=[thickness_layer,0,n_layer,wire_width,n_3,Lambda]; % user's layer
% layer_2=[wire_height,0,gold,wire_width,n_3,Lambda]; % user's layer

% layer_5=add_tri_layer(Lambda,Lambda,2,3.5,2.4,20);

create_grating;

% add_hom_layer(Lambda,layer_thickness,ref_index)
% add_sin_layer(Lambda,Lambda_object,layer_thickness,ref_index_in,ref_index_out,n_layers)
% add_tri_layer(Lambda,Lambda_object,layer_thickness,ref_index_in,ref_index_out,n_layers)
% add_pol_layer(Lambda,x,y,ref_index_in,ref_index_out,n_layers)

% create_grating; % script creates the input