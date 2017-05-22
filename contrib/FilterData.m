function [ft,fval] = FilterData(t, val, windowSize)
b = (1/windowSize)*ones(1,windowSize);
a = 1;
fval = filter(b,a,val);
fval = fval(round(windowSize/2):end);
ft = t(1:end-round(windowSize/2)+1);
end