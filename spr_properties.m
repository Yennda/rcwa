clear all
close all

lambda=750

[temp1,temp2,gold]=new_LD(lambda,'Au',6,1,2);

n_diel=1.33
e_diel=n_diel^2
k0=2*pi/lambda
beta=k0*(e_diel*)