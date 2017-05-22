function [Iph, I0, N, Rs, Rpo] = calcPvParameters5(Uoc, Isc, v, i, Rp)
Iph = Isc;
i = i + v/Rp;
p = v.*i;
windowSize=20;
b = (1/windowSize)*ones(1,windowSize);
a = 1;
fval = filter(b,a,p);
fval = fval(round(windowSize/2):end);
[~,j]=max(fval);

Ump=v(j);
Imp=i(j);
N = (Imp-Isc)*(2*Ump-Uoc)/(-Imp+(Imp-Isc)*log(1-Imp/Isc));
Rs=Ump/Imp+(2*Ump-Uoc)/(-Imp+(Imp-Isc)*log(1-Imp/Isc));
I0=Iph*exp(-Uoc/N);
Rpo=Rp;

disp(Ump*Imp/Isc/Uoc);
end