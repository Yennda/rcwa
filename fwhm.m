function width = fwhm(x,y)

% function width = fwhm(x,y)
%
% Full-Width at Half-Maximum (FWHM) of the waveform y(x)
% and its polarity.
% The FWHM result in 'width' will be in units of 'x'
%
%
% Rev 1.2, April 2006 (Patrick Egan)


y = 1-((y-min(y))/max(y-min(y)));
N = length(y);
lev50 = 0.5;
if y(1) < lev50                  % find index of center (max or min) of pulse
    [garbage,centerindex]=max(y);
    Pol = +1;
    disp('Pulse Polarity = Positive')
else
    [garbage,centerindex]=min(y);
    Pol = -1;
    disp('Pulse Polarity = Negative')
end
k = 2;
while sign(y(k)-lev50) == sign(y(k-1)-lev50)
    k = k+1;
end                                   %first crossing is between v(i-1) & v(i)
interp = (lev50-y(k-1)) / (y(k)-y(k-1));
tlead = x(k-1) + interp*(x(k)-x(k-1));
k = centerindex+1;                    %start search for next crossing at center
while ((sign(y(k)-lev50) == sign(y(k-1)-lev50)) && (k <= N-1))
    k = k+1;
end
if k ~= N
    Ptype = 1;  
    disp('Pulse is Impulse or Rectangular with 2 edges')
    interp = (lev50-y(k-1)) / (y(k)-y(k-1));
    ttrail = x(k-1) + interp*(x(k)-x(k-1));
    width = ttrail - tlead;
else
    Ptype = 2; 
    disp('Step-Like Pulse, no second edge')
    ttrail = NaN;
    width = NaN;
end


