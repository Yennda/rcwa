% clear all;


function create_real_profile_thin_gold_SPRM(lambda,Lambda, n1, ns, dn_layer_thickness, amplitude, depth)
    

    
    number_of_layers=100;
    number_of_input_file=3;
    setup_dispersion;

    cd gratings
    save_result_file_as='lyutakov_output';
    save_result_file=1; % 1-yes, 2-no
    plot_grating=1;
    refractive_indices=[n1,ns,gold, 1.34];
%     refractive_indices=[1.33,1.33,gold, 1.34];
    

%     refractive_indices=[n1,gold, n1];
    %     refractive_indices=[ 1.49 silver 1.0];
    % refractive_indices=[1 1.2 1.5, 1.7];
    % % refractive_indices=[1 0.22-6.71*1i]; % from top of the grating

    % load_data_1='Nm20f50_um.txt';
    % 
    % load_data_1='profile_1.txt';
    % load_data_2='profile_2.txt';
    % load_data_3='profile_3.txt';
    % 
    % filename_1=[load_data_1];
    % data(:,:,1)=dlmread(filename_1);
    % 
    % filename_2=[load_data_2];
    % data(:,:,2)=dlmread(filename_2);
    % 
    % filename_3=[load_data_3];
    % data(:,:,3)=dlmread(filename_3);

%     depth=0.050;
%     thickness_metal=0.025;
    % Lambda=0.300;
%     lambda=0.700;
    x=0:0.001:Lambda;
    % y=sin(2*pi./Lambda.*x).*depth/2+1.2*depth+thickness_metal;
%     y=sin(2*pi./Lambda.*x).*amplitude/2+2*depth;
    
    y=heaviside(sin(2*pi./Lambda.*x)).*amplitude/2+2*depth;
    
    data(:,:,1)=[x' y'+dn_layer_thickness];
    data(:,:,2)=[x' y'];    
    data(:,:,3)=[x' y'-depth];
    
% 
%     data(:,:,1)=[x' y'];    
%     data(:,:,2)=[x' y'-depth];


    %-------------------------------------------------------------
    grating_relative_dimensions=2; % 1- yes relative_dimensions -> Lambda=1, thickness_total=1; -> in the file main.m -> grating_relative_dimensions=1 + set new Lambda and thickness_total 
                                   % 2- no -> absolute dimensions -> in the file main.m -> grating_relative_dimensions=2
    velikost=size(data);

    % nejprve musím nalézt největší prvek na ose x a y (ne zna�?ení podle RCWA)
    x_max=0;
    y_max=0;
    for i=1:1:number_of_input_file
        x_max_i=max(data(:,1,i));
        y_max_i=max(data(:,2,i));
        if x_max_i>x_max
            x_max=x_max_i;
        end
        if y_max_i>y_max
            y_max=y_max_i;
        end
        clear x_max_i y_max_i
    end

    % vytvořím vektor, který obsahuje horní a dolní hranici vrstvi�?ky
    y_hd=0:(y_max/number_of_layers):y_max;

    % u předcházejících mřížek jsem prováděl aproximaci mřížky pomocí průměrné
    % hodnoty y-ových složek, tím jsem lépe aproximoval tvar mřížky, vytvoříme
    % si tento vektor

    for i=1:1:number_of_layers
        y_pr(i)=(y_hd(i)+y_hd(i+1))/2;
    end

    % algoritmus rozdělíme na dvě �?ásti, v závislosti, jestli je následující
    % prvek větší nebo menší než ten předcházející

    for j=1:1:number_of_input_file
        for k=1:1:number_of_layers % stejny pocet ma i y_pr 
            hit(k)=0;    
            for i=1:1:velikost(1)-1        
                if data(i+1,2,j)>=data(i,2,j) % rostoucí
                    if data(i+1,2,j)>= y_pr(k) && y_pr(k)>data(i,2,j)                
                        hit(k)=hit(k)+1;            
                    end
                elseif data(i+1,2,j)<data(i,2,j) % klesající
                    if data(i+1,2,j)<=y_pr(k) && data(i,2,j)>y_pr(k)                
                        hit(k)=hit(k)+1;            
                    end
                end
            end
        end
        result_matrix_j(j)=max(hit);
    end
    size_result_matrix=max(result_matrix_j);

    % nyní již bychom chtěli znát x-ové hodnoty jednotlivých okrajů vrstvi�?ek,
    % neznámou hodnotu mezi dvěma známými hodnotami zjistíme tím, že mezi dvěma
    % známými hodnotami proložíme přímku

    % na co si musíme dát pozor na případ, kdy směrnice je nekone�?ná hodnota,
    % to by pak dávalo upozornění na dělení nulou

    for h=1:1:number_of_input_file
        for i=1:1:size_result_matrix    
            for j=1:1:number_of_layers
                matrix_of_values_x(j,i,h)=NaN;
            end
        end
    end

    for j=1:1:number_of_input_file
        for k=1:1:number_of_layers    
            m=1; % m ur�?uje jaký je sloupec v k-tém řádku    
            for i=1:1:velikost(1)-1        
                if data(i+1,2,j)>=data(i,2,j) % rostoucí křivka            
                    if data(i+1,2,j)>= y_pr(k) && y_pr(k)>data(i,2,j) % pro případ, že jsme se strefili do známého bodu, ?nutné?                
                        if abs(data(i+1,1,j)-data(i,1,j))>0 % směrnice není nekone�?ná, y=a*x+b                    
                            a=(data(i+1,2,j)-data(i,2,j))/(data(i+1,1,j)-data(i,1,j));                    
                            b=(data(i,1,j)*data(i+1,2,j)-data(i+1,1,j)*data(i,2,j))/(data(i,1,j)-data(i+1,1,j));                    
                            matrix_of_values_x(k,m,j)=(y_pr(k)-b)/a;                
                        elseif abs(data(i+1,1,j)-data(i,1,j))==0 % směrnice je nekone�?ná                    
                            matrix_of_values_x(k,m,j)=data(i,1,j); % x-ová souřadnice je dána přímo hodnotou známého bodu                
                        end
                        m=m+1;            
                    end
                elseif data(i+1,2,j)<data(i,2,j) % klesající křivka            
                    if data(i+1,2,j)<=y_pr(k) && data(i,2,j)>y_pr(k)                
                        if abs(data(i+1,1,j)-data(i,1,j))>0                    
                            a=(data(i+1,2,j)-data(i,2,j))/(data(i+1,1,j)-data(i,1,j));                    
                            b=(data(i,1,j)*data(i+1,2,j)-data(i+1,1,j)*data(i,2,j))/(data(i,1,j)-data(i+1,1,j));                    
                            matrix_of_values_x(k,m,j)=(y_pr(k)-b)/a;                
                        elseif abs(data(i+1,1,j)-data(i,1,j))==0                    
                            matrix_of_values_x(k,m,j)=data(i,1,j);                
                        end
                        m=m+1;            
                    end
                end
            end
        end
    end

    % vytvořím jednu velkou matici s hodnotymi průse�?íků
    result_matrix_hodnot_x_pomoc(number_of_layers,1)=NaN;
    for i=1:1:number_of_input_file
        result_matrix_hodnot_x_pomoc=[result_matrix_hodnot_x_pomoc matrix_of_values_x(:,:,i)];
    end

    % odstraním první pomocný sloupec
    result_matrix_hodnot_x=result_matrix_hodnot_x_pomoc(:,2:size_result_matrix*number_of_input_file+1);
    clear result_matrix_hodnot_x_pomoc

    % přidám souřadnice za�?átku a konce
    for i=1:1:number_of_layers
        matice_zacatku(i,1)=0;
        matice_konce(i,1)=x_max;
    end


    result_matrix_hodnot_x=[matice_zacatku matice_konce result_matrix_hodnot_x];

    % srovnám hodnoty v matici ? lze pouze srovnat sloupce
    pomoc_srovnat=rot90(result_matrix_hodnot_x,-1);
    srovnana_hodnota_x=rot90(sort(pomoc_srovnat),-3);

    clear result_matrix_hodnot_x matice_zacatku matice_konce pomoc_srovnat

    % nyní odstraním některé nepotřební hodnoty NaN
    % najdu nejvzdálenější pozici nějakého �?ísla
    size_srovnana=size(srovnana_hodnota_x);

    for i=1:1:size_srovnana(1)
        for j=1:1:size_srovnana(2)
            if isnan(srovnana_hodnota_x(i,j))==0
                pozice_srovnana(i)=j;            
            end
        end
    end

    upravena_matice_x=srovnana_hodnota_x(:,1:max(pozice_srovnana));

    for i=1:1:number_of_layers
        for j=1:1:max(pozice_srovnana)-1
            polovina_hodnot_x(i,j)=(upravena_matice_x(i,j)+upravena_matice_x(i,j+1))/2;
        end
    end

    %za�?nu stavět výslednou matici
    size_upravena_matice=size(upravena_matice_x);

    for i=1:1:number_of_layers
        for j=1:1:2*size_upravena_matice(2)-1
            result_matrix_1(i,j)=NaN;
        end
    end

    % naházím tam již známé hodnoty

    for i=1:1:number_of_layers
        for j=1:1:size_upravena_matice(2)
            result_matrix_1(i,2*j-1)=upravena_matice_x(i,j);
        end
    end

    size_polovina_x=size(polovina_hodnot_x);

    for m=1:1:size_polovina_x(2)
        for n=1:1:size_polovina_x(1)
            if isnan(polovina_hodnot_x(n,m))==0
                zadany_bod_x=polovina_hodnot_x(n,m);
                zadany_bod_y=y_pr(n);
                for j=1:1:number_of_input_file    
                    for i=1:1:velikost(1)-1        
                        if data(i+1,1,j)>= zadany_bod_x && zadany_bod_x>data(i,1,j)            
                            if abs(data(i+1,1,j)-data(i,1,j))>0 % směrnice není nekone�?ná, y=a*x+b                
                                a=(data(i+1,2,j)-data(i,2,j))/(data(i+1,1,j)-data(i,1,j));                
                                b=(data(i,1,j)*data(i+1,2,j)-data(i+1,1,j)*data(i,2,j))/(data(i,1,j)-data(i+1,1,j));                
                                y_hled(:,:,j)=a*zadany_bod_x+b;                
                                diference(:,:,j)=-(y_hled(:,:,j)-zadany_bod_y);            
                            elseif abs(data(i+1,1,j)-data(i,1,j))==0 % směrnice je nekone�?ná, snad to nebude �?astý jev                
                                y_hled(:,:,j)=data(i,2,j);                
                                diference(:,:,j)=-(y_hled(:,:,j)-zadany_bod_y);            
                            end
                        end
                    end
                end
                diference(:,:,number_of_input_file+1)=zadany_bod_y;
                % nalézt nejmenší kladnou diferenci, přiřadím mu správný index
                for j=1:1:number_of_input_file+1    
                    if diference(:,:,j)>0        
                        if j<number_of_input_file+1            
                            refractive_indices_index=j;            
                            break;        
                        else
                            refractive_indices_index=j;        
                        end
                    end
                end
                result_matrix_1(n,2*m)=refractive_indices(refractive_indices_index);
            end
        end
    end

    result_matrix_1=flipud(result_matrix_1);

    % do vysledné matice ještě musim na za�?átek přidat šířky jednotlivých
    % vrstev
    for i=1:1:number_of_layers
        sirka_matice(i,1)=y_max/number_of_layers;
    end

    % v případě, kdy chci mít relativní data, tak musím matice přepo�?ítat 
    size_result_matrix_1=size(result_matrix_1);
    if grating_relative_dimensions==1
        for i=1:1:number_of_layers
            sirka_matice(i,1)=sirka_matice(i,1)/y_max;
        end
        for i=1:1:size_result_matrix_1(1)
            for j=1:2:size_result_matrix_1(2)
                result_matrix_1(i,j)=result_matrix_1(i,j)/x_max;
            end
        end
    end
    clear size_upravena_matice size_result_matrix
    result_matrix=[sirka_matice result_matrix_1];
    % data=result_matrix;



    % nyní již sta�?í vypsat výslednou matici do souboru

    if save_result_file==1
        fid = fopen([save_result_file_as '.m'], 'wt');
        if grating_relative_dimensions==2
            fprintf(fid, '\n%%absolute coordinates%0f ');
        else
            fprintf(fid, '\n%%relative coordinates%0f ');
        end
        fprintf(fid, '\n%%number_of_layers=%0f ',number_of_layers);
        fprintf(fid, '\n%%Lambda=%0f ',x_max);
    %     fprintf(fid, '\n%%thickness_total=%0f ',y_max); puvodni
        fprintf(fid, '\nthickness_total=%0f ',y_max);
        fprintf(fid, ';');
        fprintf(fid, '\ndata=[ ');
        if number_of_layers==1
            fprintf(fid, '\n');
            for j=1:1:size_result_matrix_1(2)+1
                if j==1
                    fprintf(fid, '%0f', result_matrix(1,j));
                else
                    if imag(result_matrix(1,j))>0 || imag(result_matrix(1,j))<0
                        fprintf(fid, ', %0f', real(result_matrix(1,j)));                        
                        if imag(result_matrix(1,j))>0                    
                            fprintf(fid, '+%0f', imag(result_matrix(1,j)));                        
                            fprintf(fid, '*1i');                        
                        else
                            fprintf(fid, '%0f', imag(result_matrix(1,j)));                        
                            fprintf(fid, '*1i');                        
                        end
                    else
                        fprintf(fid, ', %0f', real(result_matrix(1,j)));                    
                    end
                end
            end
        else
            for i=1:1:number_of_layers
                fprintf(fid, '\n');
                for j=1:1:size_result_matrix_1(2)+1
                    if j==1
                        fprintf(fid, '%0f', result_matrix(i,j));
                    else
                        if imag(result_matrix(i,j))>0 || imag(result_matrix(i,j))<0                        
                            fprintf(fid, ', %0f', real(result_matrix(i,j)));
                            if imag(result_matrix(i,j))>0
                                fprintf(fid, '+%0f', imag(result_matrix(i,j)));
                                fprintf(fid, '*1i');
                            else
                                fprintf(fid, '%0f', imag(result_matrix(i,j)));
                                fprintf(fid, '*1i');
                            end
                        else
                            fprintf(fid, ', %0f', real(result_matrix(i,j)));
                        end
                    end
                end
                if i<number_of_layers
                    fprintf(fid, ';');
                end
            end
        end
        fprintf(fid, '\n ];');
        fclose(fid);
    end

    % vykreslení mřížky
    if plot_grating==1
        figure;

        for i=1:1:number_of_layers
            for j=2:2:size_result_matrix_1(2)
                if isnan(result_matrix(i,j+2))==1

                else
                    x_begin=result_matrix(i,j);
                    x_end=result_matrix(i,j+2);
                    x_width=x_end-x_begin;
                    y_begin=y_max-result_matrix(i,1)*i;
                    y_height=result_matrix(i,1);
                    barva=[abs(cos(3.5*real(result_matrix(i,j+1)))),abs(cos(5.26*real(result_matrix(i,j+1)))),abs(sin(35*real(result_matrix(i,j+1))))];
                    if x_width>0
                        rectangle('Position',[x_begin,y_begin,x_width,y_height],'FaceColor',barva)
                    end
                end
            end    
        end
        hold on
        for i=1:1:number_of_input_file
            plot(data(:,1,i),data(:,2,i),'LineWidth',2,'Color','r')
        end
        xlabel('\Lambda [\mu{}m]','FontSize',17);
        ylabel('d [\mu{}m]','FontSize',17);

    end
    cd ..
end