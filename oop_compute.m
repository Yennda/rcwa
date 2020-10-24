function oop_compute(rcwa)
    lambda=rcwa.lambda;
    theta0=rcwa.theta0;

    Lambda=rcwa.Lambda;
%             thickness_total=rcwa.thickness_total;
    dn_layer_thickness=rcwa.dn_layer_thickness;
    depth=rcwa.depth;
    amplitude=rcwa.amplitude;
    n1=rcwa.n1;
    ns=rcwa.n1+rcwa.dn;            

    input_grating_file=rcwa.input_grating_file;
    measurement=rcwa.measurement;
    number_of_orders=rcwa.number_of_orders;
    drw_plt=rcwa.drw_plt; 
    grating=rcwa.grating;

    mini=rcwa.mini;
    maxi=rcwa.maxi;
    step=rcwa.step;
    change_of_index=rcwa.change_of_index;   

    if drw_plt==2
        set(0,'DefaultFigureVisible','off')
    end


    oop_main;
    set(0,'DefaultFigureVisible','on')


    switch measurement
        case 0
            rcwa.data=diff_R;
        case 1
            rcwa.data=data1;
        case 2
            rcwa.data=data2;
        case 3
            rcwa.data=data3;
        case 4
            rcwa.data=data4;
        otherwise
                error('it is not defined')
    end

    if measurement>0
        [m, p] = min(rcwa.data(:,2));   
        disp(['Minimum at ', num2str(rcwa.data(p,1)*1000), ' nm']);
    end
end