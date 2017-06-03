%% tsetSingle.m
clear;
Uoc = 335;
Isc = 48;
Ump=240;
Pmp=10e3;
Imp=Pmp/Ump;
[Iph, I0, N, Rs] = calcPvParameters(Uoc, Isc, Ump, Imp);

Uoc=log(Iph/I0)*N;
yu=0:1:Uoc;
xi=yu;
for i=1:length(yu)
    xi(i)=PvFunctionI(yu(i),Iph,I0,N,Rs);
end
[~,j]= max(xi.*yu);
%% Plot
f = figure;
hold on;
yyaxis left;
plot(yu,xi);
plot(yu(j),xi(j),'ko');
ylabel('I/A');
ylim([0,Iph*1.1]);

yyaxis right;
plot(yu,xi.*yu);
plot(yu(j),xi(j)*yu(j),'ko');
ylim([0,1.1*max(xi.*yu)]);
ylabel('P/W');

xlim([0,Uoc*1.1]);
title('I-V & P-V Curves');
grid on;
grid minor;
legend('I-V Curve','MPP','P-V Curve');
xlabel('U/V');

saveas(f,'figure/bare-pviv.eps','epsc');
saveas(f,'figure/bare-pviv.png');
close(f);