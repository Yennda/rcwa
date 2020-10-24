% !! For RCWA calculation: comment â€œclear allâ€? and set plot_grating=2;

% clear all
% % plot_gating=1;

% 1-add homogeneous layer
% 2-add polygon layer
% 3-add sinus layer
% 4-add user's layer

setup_dispersion;

% n_1=1.33;
n_3=gold;
n3=gold;



% Lambda=0.570;

% x=Lambda.*[0.1 0.3, 0.4, 0.6, 0.7, 0.9, 0.9, 0.7, 0.6, 0.6, 0.4, 0.3, 0.3];
% z_local=[0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1];

% layer_1=add_pol_layer(Lambda,x,z_local,3.3,1,20); % polygon layer
% layer_2=add_hom_layer(Lambda,1,3); % homogeneous layer
layer_1=add_sin_layer(Lambda,Lambda,thickness_total,gold,n1,25); % sinus layer
% layer_4=[1,0,1,0.5,3,Lambda]; % user's layer
% layer_5=add_tri_layer(Lambda,Lambda,2,3.5,2.4,20);

create_grating;

% add_hom_layer(Lambda,layer_thickness,ref_index)
% add_sin_layer(Lambda,Lambda_object,layer_thickness,ref_index_in,ref_index_out,n_layers)
% add_tri_layer(Lambda,Lambda_object,layer_thickness,ref_index_in,ref_index_out,n_layers)
% add_pol_layer(Lambda,x,y,ref_index_in,ref_index_out,n_layers)

% create_grating; % script creates the input