%% prepare mppt data
%% Parameters
Uoc = 335/2;
Isc = 48/2;
Ump= 240/2;
Pmp= 10e3/4;
Imp=Pmp/Ump;
[Iph, I0, N, Rs] = calcPvParameters(Uoc, Isc, Ump, Imp);
Iph1=Iph;

U=(0:Uoc/50:2*Uoc)';% To calc
Ui=(0:Uoc/500:2*Uoc)';% To spline
%% Calc P-V I-V Curve
U1 = U;
I = U;
h = waitbar(0,'Calculating p-v & i-v curves...');
steps = length(U1);
for i=1:length(U1)
    I(i) = Pv4SeriesParallel(U(i),Iph1,Iph1,Iph1,Iph1,I0,N,Rs);
    waitbar(i/steps);
end
close(h);
%% Spline & max
Ii = spline(U,I,Ui);
[~, maxj] = max(Ui.*Ii);
%% Plot P-V & I-V Curve
f = figure;
hold on;
yyaxis left;
plot(Ui,Ii); 
plot(Ui(maxj),Ii(maxj),'ko');
ylim([0 1.05*max(Ii)]);
ylabel('I/A');
hold on;
yyaxis right;
plot(Ui,Ui.*Ii);
plot(Ui(maxj),Ui(maxj)*Ii(maxj),'ko');
ylim([0 1.05*max(Ui.*Ii)]);
ylabel('P/W');
xlim([0 2*Uoc]);
xlabel('U/V');
grid on;
grid minor;
title('光照均匀下的特性曲线');

saveas(f,'figure/curve-singlemax.eps','epsc');
saveas(f,'figure/curve-singlemax.png');
close(f);