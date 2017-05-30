function [Iph, I0, N, Rs] = calcPvParameters(Uoc, Isc, Ump, Imp)
Iph = Isc;
N = (Imp-Isc)*(2*Ump-Uoc)/(-Imp+(Imp-Isc)*log(1-Imp/Isc));
Rs=Ump/Imp+(2*Ump-Uoc)/(-Imp+(Imp-Isc)*log(1-Imp/Isc));
I0=Iph*exp(-Uoc/N);
x0=[Iph 1/N I0 Rs]';
Equation=@(x)[log((x(1)+x(3)-Isc)/x(3))/x(2)-Isc*x(4);
    log((x(1)+x(3))/x(3))/x(2)-Uoc;
    log((x(1)+x(3)-Imp)/x(3))/x(2)-Imp*x(4)-Ump;
    Imp/(x(2)*(x(1)+x(3)-Imp))+Imp*x(4)-Ump;];
Equationlog=@(x) Equation(exp(x));
x=exp(fsolve(Equationlog,log(x0),optimset('display','off')));
Iph=x(1);N=1./x(2);I0=x(3);Rs=x(4);
end