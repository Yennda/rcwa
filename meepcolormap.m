function mcolormap=meepcolormap
    mincolor    = [1 0 0]; % red
    mediancolor = [0 0 0]; % white   
    maxcolor    = [0 0 1]; % blue      

    ColorMapSize = 256;
    int1 = zeros(ColorMapSize,3); 
    int2 = zeros(ColorMapSize,3);
    for k=1:3
        int1(:,k) = linspace(mincolor(k), mediancolor(k), ColorMapSize);
        int2(:,k) = linspace(mediancolor(k), maxcolor(k), ColorMapSize);
    end
    mcolormap = [int1(1:end-1,:); int2];

end