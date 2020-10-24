
function Lambda=grating_period(lambda)

[temp1,temp2,gold]=new_LD(lambda,'Au',6,1,2);
e1=1.329^2; %water
e2=gold^2;

Lambda=real(lambda*sqrt((e1+e2)/(e1*e2)));
end