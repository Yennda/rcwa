silica=cauchy(lambda,1.491,0.00686,-0.0007648);
gold=0.09180233166912136+5.074737736488918j;

notch_thickness_g=0.5;
notch_thickness_s=4;
notch_duty=0.3;
notch_L=0.5;


data=[
%     notch_thickness_s, 0, silica, notch_L, NaN, NaN, NaN, NaN;
%     notch_thickness_g, 0, gold, 0.2, silica, 0.4, 1.1, 0.5;
    notch_thickness_s, 0, silica, notch_L, NaN, NaN;
    notch_thickness_g, 0, gold, 0.2, silica, 0.5;
%     notch_thickness_s, 0, silica, notch_L, NaN, NaN, NaN, NaN;
%     0.5, 0, gold, 0.5;
];
n1=1.5168;
n3=gold;