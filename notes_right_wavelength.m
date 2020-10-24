clear all
close all

clear classes
clear functions
clear global
clear import
clear java
clear mex



lambda=0.7;
% wls=[0.5, 0.6, 0.7, 0.8, 0.9];
wls=0.5:0.01:1;

Ls=zeros(1, length(wls));
dzs=zeros(1, length(wls));
pwls=zeros(1, length(wls));


ii=1;

for lambda=wls
    
    [temp1,temp2,gold]=new_LD(lambda,'Au',6,1,2);
    epd=1.332^2;
    epm=gold^2;
    epp=epd*epm/(epd+epm);

    k0=2*pi/lambda;
    beta=k0*(epp^0.5);
    
    
    
    pwl=real(2*pi/beta);
    L=abs(1/(2*imag(beta)));
	kz=(beta^2-epd*(2*pi/lambda)^2)^0.5;
    
    Ls(ii)=L;
    dzs(ii)=1/real(kz);
    pwls(ii)=pwl;
    
%     disp(gold^2);
%     disp(['lambda=', num2str(lambda*1000), ' nm'])
%     disp(['plasmon wavelength: ', num2str(pwl*1000), ' nm']);
%     disp(['L=', num2str(L*1000), ' nm'])
%     disp(['dz=', num2str(1/real(kz)*1000), ' nm'])
    ii=ii+1;  
end


% figure;
plot(wls*1e3, pwls*1e3,'DisplayName','\lambda_{plasmon}');
hold on
plot(wls*1e3, dzs*1e3,'DisplayName','dz');
grid on
ylabel('[nm]');
yyaxis right
plot(wls*1e3, Ls,'DisplayName','L');
hold off

xlabel('\lambda [nm]');
ylabel('[\mu m]');
title('plasmon properties');
legend('Location','southeast')
