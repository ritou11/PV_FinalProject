clear;
Uoc = 335;
Isc = 48;
Ump=240;
Pmp=10e3;
Imp=Pmp/Ump;
[Iph, I0, N, Rs] = calcPvParameters(Uoc, Isc, Ump, Imp);
Iph1=Iph;Iph2=Iph*0.3;
Iph3=0.9*Iph;Iph4=0.1*Iph;
U=(0:Uoc/50:2*Uoc)';
U1 = U;
I = U;
I2 = U;
h = waitbar(0,'Please wait...');
steps = length(U1);
for i=1:length(U1)
    %I(i) = Pv4SeriesParallel(U(i),Iph1,Iph2,Iph3,Iph4,I0,N,Rs);
    I(i) = Pv2Series(U(i),Iph2,Iph3,I0,N,Rs);
    waitbar(i/steps);
end
close(h);
%%
figure;
hold on;
yyaxis left;
plot(U,I); 
ylim([0 1.05*max(real(I))]);
hold on;
yyaxis right;
plot(U,U.*I);
ylim([0 1.05*max(U.*real(I))]);
xlim([0 2*Uoc]);