%% prepare mppt data
%% Parameters
Uoc = 335;
Isc = 48;
Ump=240;
Pmp=10e3;
Imp=Pmp/Ump;
[Iph, I0, N, Rs] = calcPvParameters(Uoc, Isc, Ump, Imp);
Iph1=Iph;Iph2=Iph*0.3;
Iph3=0.9*Iph;Iph4=0.1*Iph;

U=(-0.07*Uoc:Uoc/50:2*Uoc)';% To calc
Ui=(-0.07*Uoc:Uoc/500:2*Uoc)';% To spline
%% Calc P-V I-V Curve
U1 = U;
I = U;
h = waitbar(0,'Plotting p-v & i-v curves...');
steps = length(U1);
for i=1:length(U1)
    I(i) = Pv4SeriesParallel(U(i),Iph1,Iph2,Iph3,Iph4,I0,N,Rs);
    waitbar(i/steps);
end
close(h);
%% Spline
Ii = spline(U,I,Ui);