% Author: Pavel Kwiecien, pavel.kwiecien@seznam.cz
% Czech Technical University in Prage, Optical Physics Group, Czech Republic

%d=6;
%Lambda=6;
%number_of_layers=3;
%nakreslit_graf=1;
%a_1=.05;
%a_2=.7;
%c_1=1;
%c_2=.5;
%b=.8;


d=thickness_total;
sirka=thickness_total*1E-6;

if a_1+a_2>1
    error('change a')
end

if c_1==1 | c_2==1
else
    error('change c')
end

% definice vrcholů lichoběžníku
%dolni
y_1=0;
x_1=(Lambda-b*Lambda)/2;

y_2=0;
x_2=(Lambda+b*Lambda)/2;

y_3=c_1*d;
x_3=a_1*Lambda;

y_4=c_2*d;
x_4=Lambda-a_2*Lambda;

% alokace matic
rozdeleni=zeros(1,number_of_layers+1);
nova_y=zeros(1,number_of_layers);
pomocna_1=zeros(1,number_of_layers);
pomocna_2=zeros(1,number_of_layers);
duty_cycle=zeros(1,number_of_layers);
shift=zeros(1,number_of_layers);

rozdeleni=linspace(0,d,number_of_layers+1);%rozdělím zadaný interval
for i=1:1:number_of_layers %udělám průměr dvou sousedních y
    nova_y(i)=(rozdeleni(i)+rozdeleni(i+1))/2;
end

if y_4>y_3
    pomocna_1_a=zeros(1,number_of_layers);
    pomocna_1_b=zeros(1,number_of_layers);
    pomocna_1_a=(nova_y-(y_1*x_3-y_3*x_1)/(x_3-x_1))*((x_1-x_3)/(y_1-y_3));
    pomocna_1_b=(nova_y-(y_3*x_4-y_4*x_3)/(x_4-x_3))*((x_3-x_4)/(y_3-y_4));
    pomocna_2=(nova_y-(y_2*x_4-y_4*x_2)/(x_4-x_2))*((x_2-x_4)/(y_2-y_4));
    for j=1:1:number_of_layers
        if pomocna_1_a(j)<x_3 && isnan(pomocna_1_a(j))==0
            pomocna_1(j)=pomocna_1_a(j);
        elseif isnan(pomocna_1_b(j))==0 && isnan(pomocna_1_a(j))==0
            pomocna_1(j)=pomocna_1_b(j);
        elseif isnan(pomocna_1_b(j))==1
            pomocna_1(j)=x_3;
        elseif isnan(pomocna_1_a(j))==1
            if x_3<pomocna_1_b(j) && pomocna_1_b(j)<x_4
                pomocna_1(j)=pomocna_1_b(j);
            else
                pomocna_1(j)=x_3;
            end
        end
    end
elseif y_4==y_3
    %
    if x_3-x_1==0
        pomocna_1=x_1*ones(1,number_of_layers);
    else
        pomocna_1=(nova_y-(y_1*x_3-y_3*x_1)/(x_3-x_1))*((x_1-x_3)/(y_1-y_3));
    end
    %
    if x_4-x_2==0
        pomocna_2=x_2*ones(1,number_of_layers);
    else
        pomocna_2=(nova_y-(y_2*x_4-y_4*x_2)/(x_4-x_2))*((x_2-x_4)/(y_2-y_4));
    end
       duty_cycle=fliplr((pomocna_2-pomocna_1)/Lambda);
       layer_thickness=sirka/number_of_layers*ones(1,number_of_layers);%případně zakomentovat
       shift=fliplr((pomocna_1+pomocna_2)/(2*Lambda));     
elseif y_4<y_3
    pomocna_1=(nova_y-(y_1*x_3-y_3*x_1)/(x_3-x_1))*((x_1-x_3)/(y_1-y_3));        
    pomocna_2_a=zeros(1,number_of_layers);
    pomocna_2_b=zeros(1,number_of_layers);
    pomocna_2_a=(nova_y-(y_2*x_4-y_4*x_2)/(x_4-x_2))*((x_2-x_4)/(y_2-y_4));
    pomocna_2_b=(nova_y-(y_4*x_3-y_3*x_4)/(x_3-x_4))*((x_4-x_3)/(y_4-y_3));
    for j=1:1:number_of_layers
        if pomocna_2_a(j)>x_4 && isnan(pomocna_2_a(j))==0
            if isnan(pomocna_2_a(j))==1
                pomocna_2(j)=x_2;
            else
                pomocna_2(j)=pomocna_2_a(j);
            end
        elseif isnan(pomocna_2_a(j))==0
            if isnan(pomocna_2_b(j))==1
                pomocna_2(j)=x_3;
            else
                pomocna_2(j)=pomocna_2_b(j);
            end
        elseif isnan(pomocna_2_a(j))==1
            if pomocna_2_b(j)>x_3 && pomocna_2_b(j)<x_4
                pomocna_2(j)=pomocna_2_b(j);
            else
                pomocna_2(j)=x_4;
            end
        end
    end
end
    

duty_cycle=fliplr((pomocna_2-pomocna_1)/Lambda);
layer_thickness=sirka/number_of_layers*ones(1,number_of_layers);%případně zakomentovat
shift=fliplr((pomocna_1+pomocna_2)/(2*Lambda));

switch plot_grating
    case 1
        figure;
        line([x_1,x_3],[y_1,y_3],'Color','r','LineWidth',2);
        line([x_2,x_4],[y_2,y_4],'Color','r','LineWidth',2);
        line([x_1,x_2],[y_1,y_2],'Color','r','LineWidth',2);
        line([x_3,x_4],[y_3,y_4],'Color','r','LineWidth',2);
        axis([0 Lambda 0 d])
        hold on
        xlabel('\Lambda [\mu{}m]','FontSize',18);
        ylabel('d [\mu{}m]','FontSize',18);
        for k=1:1:number_of_layers
            z=pomocna_1(k):Lambda/1000:pomocna_2(k);
            plot(z,0*z+rozdeleni(k))
            plot(z,0*z+rozdeleni(k)+d/number_of_layers)
            line([pomocna_1(k);pomocna_1(k)],[nova_y(k)-d/(2*number_of_layers);nova_y(k)+d/(2*number_of_layers)]);
            line([pomocna_2(k);pomocna_2(k)],[nova_y(k)-d/(2*number_of_layers);nova_y(k)+d/(2*number_of_layers)]);
        end
    case 2
end