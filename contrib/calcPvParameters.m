function [Iph, I0, N, Rs] = calcPvParameters(Uoc, Isc, Ump, Imp)
Iph = Isc;
N = (Imp-Isc)*(2*Ump-Uoc)/(-Imp+(Imp-Isc)*log(1-Imp/Isc));
Rs=Ump/Imp+(2*Ump-Uoc)/(-Imp+(Imp-Isc)*log(1-Imp/Isc));
I0=Iph*exp(-Uoc/N);
end