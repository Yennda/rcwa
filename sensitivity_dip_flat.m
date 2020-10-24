function [resonance_wavelength_1, width, sensitivity, FOM]=sensitivity_dip(wavelength,reflektivita1, reflektivita2,deltaindex)
      
    
  
            n_poly=5;
            rozsah=0.050;
            %finding maxima in values
            x=wavelength;
            y=reflektivita1;
            
			 [ymax,imax,ymin,imin]=extrema(y)	 ;
             [ymax_max, imax_max]=max(ymax);
%              imax=imax(imax_max);
             [ymin_min, imin_min]=min(ymin);
             imin=imin(imin_min);
%            y_forfit=y((x>(x(imin(1))-rozsah))&((x<(x(imin(1))+rozsah))));
%            x_forfit=x((x>(x(imin(1))-rozsah))&((x<(x(imin(1))+rozsah))));

%              halfvalue=ymin_min+(ymax_max-ymin_min)/2;
%              y_forfit=y(y<halfvalue);
%              x_forfit=x(y<halfvalue);
%           
%              y_forfit=y((x>(x(imin(1))-rozsah))&((x<(x(imin(1))+rozsah))));
%              x_forfit=x((x>(x(imin(1))-rozsah))&((x<(x(imin(1))+rozsah))));
             
             iforfit_min=imin(1)-min(abs(imin(1)-imax));
             iforfit_max=imin(1)+min(abs(imin(1)-imax));
             y_pom=y(iforfit_min:iforfit_max);
             x_pom=x(iforfit_min:iforfit_max);
             y_forfit=y_pom(y_pom<min(y_pom)+(max(y_pom)-min(y_pom))/2);
             x_forfit=x_pom(y_pom<min(y_pom)+(max(y_pom)-min(y_pom))/2);
             
             
             fitted_polynomial = polyfit(x_forfit,y_forfit,n_poly);
             x_con=linspace(min(x_forfit),max(x_forfit),5000);
             [minimum_value, iresonance_wavelength_1]=min(polyval(fitted_polynomial,x_con));
             resonance_wavelength_1=x_con(iresonance_wavelength_1);  
             
%              figure;
%              plot(wavelength,reflektivita1,'go')
%              hold on
%              plot(x_con,polyval(fitted_polynomial,x_con),'-')
             
%              
%              
             x=wavelength;
             y=reflektivita2;
            
			 [ymax,imax,ymin,imin]=extrema(y)	 ;
             [ymax_max, imax_max]=max(ymax);
%              imax=imax(imax_max);
             [ymin_min, imin_min]=min(ymin);
             imin=imin(imin_min);
%            y_forfit=y((x>(x(imin(1))-rozsah))&((x<(x(imin(1))+rozsah))));
%            x_forfit=x((x>(x(imin(1))-rozsah))&((x<(x(imin(1))+rozsah))));
             
%              halfvalue=ymin_min+(ymax_max-ymin_min)/2;
%              y_forfit=y(y<halfvalue);
%              x_forfit=x(y<halfvalue);
             
             iforfit_min=imin(1)-min(abs(imin(1)-imax));
             iforfit_max=imin(1)+min(abs(imin(1)-imax));
             y_pom=y(iforfit_min:iforfit_max);
             x_pom=x(iforfit_min:iforfit_max);
             y_forfit=y_pom(y_pom<min(y_pom)+(max(y_pom)-min(y_pom))/2);
             x_forfit=x_pom(y_pom<min(y_pom)+(max(y_pom)-min(y_pom))/2);
             
             
             
             fitted_polynomial = polyfit(x_forfit,y_forfit,n_poly);
             x_con=linspace(min(x_forfit),max(x_forfit),5000);
             [~, iresonance_wavelength_2]=min(polyval(fitted_polynomial,x_con));
             resonance_wavelength_2=x_con(iresonance_wavelength_2);   
             
             
             xx=min(x_pom):0.0005:max(x_pom);
             yy=spline(x,y,xx);
%              xx=min(x_pom):0.001:max(x_pom);
             try 
%                 width=fwhm(xx,spline(x_pom,y_pom,xx));
                width=fwhm(xx,yy);
             catch
                width=NaN;
             end
             
             
             x_fwhm=xx((xx>resonance_wavelength_1-width/2)&(xx<resonance_wavelength_2+width/2));
             y_fwhm=yy((xx>resonance_wavelength_1-width/2)&(xx<resonance_wavelength_2+width/2));
             
             %width=fwhm(x,y); %puvodne
             abs_value=@(X) sqrt(real(X).^2 + imag(X).^2);

             sensitivity=abs_value((resonance_wavelength_2-resonance_wavelength_1)/deltaindex);
             FOM=abs_value(sensitivity./width);
             
             dip.sensitivity           =sensitivity;
             dip.FOM                   =FOM;
             dip.fwhm                  =width;
             dip.res_wavelength1       =resonance_wavelength_1;
             dip.res_wavelength2       =resonance_wavelength_2;
 
             
             
             figure;
 
             plot(wavelength,reflektivita2,'ro')
             hold on
             plot(x_con,polyval(fitted_polynomial,x_con),'-')
             plot(xx,yy,'g*')
             plot(x_fwhm,y_fwhm,'bx')
             