%% testManySingle.m
clear;
Uoc = 335;
Isc = 48;
Ump=240;
Pmp=10e3;
Imp=Pmp/Ump;
[Iph, I0, N, Rs] = calcPvParameters(Uoc, Isc, Ump, Imp);
IPH=0.1*Iph:0.05*Iph:1.2*Iph;

U=(0:Uoc/50:Uoc)';
Ui = (0:Uoc/1000:Uoc)';
Ii = zeros(length(Ui),length(IPH));
I = zeros(length(U),length(IPH));
h = waitbar(0,'Generating data...');
steps = length(U)*length(IPH);
for j=1:length(IPH)
    for i=1:length(U)
        I(i,j) = PvFunctionI(U(i),IPH(j),I0,N,Rs);
        waitbar((i+(j-1)*length(U))/steps);
    end
    Ii(:,j) = spline(U, I(:,j), Ui);
end
close(h);
U=Ui;
I=Ii;
maxu = IPH;
maxp = IPH;
%%
f = figure;
plot(U,U.*I(:,length(IPH)));
hold on;
for i=1:length(IPH)
    P(:,i)=U.*I(:,i);
    plot(U,P(:,i));
    [~,j]= max(P(:,i));
    maxu(i)=U(j);
    maxp(i)=P(j,i);
end
plot(maxu,maxp,'ko-');
grid on;
title('不同光照下的P-V曲线');
xlabel('U/U_{oc}');
ylabel('P/P_{m}');
ylim([0,max(max(P))*1.05]);
saveas(f,'figure/p-v-many.eps','epsc');
saveas(f,'figure/p-v-many.png');
close(f);