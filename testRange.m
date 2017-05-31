%% testRange.m
clear;
Uoc = 335;
Isc = 48;
Ump=240;
Pmp=10e3;
Imp=Pmp/Ump;
[Iph, I0, N, Rs] = calcPvParameters(Uoc, Isc, Ump, Imp);

U=(0:Uoc/100:Uoc)';
IPH=0.1*Iph:0.05*Iph:2*Iph;
I = zeros(length(U),length(IPH));
h = waitbar(0,'Generating data...');
steps = length(U)*length(IPH);
for j=1:length(IPH)
    for i=1:length(U)
        I(i,j) = PvFunctionI(U(i),IPH(j),I0,N,Rs);
        waitbar((i+(j-1)*length(U))/steps);
    end
end
close(h);
%%
f = figure;
plot(U/Uoc,U.*I(:,length(IPH))/max(U.*I(:,length(IPH))));
hold on;
for i=1:length(IPH)
    P(:,i)=U.*I(:,i);
    plot(U/Uoc,P(:,i)/max(P(:,i)));
    P(:,i)=P(:,i)/max(P(:,i));
end
[~,index]=max(P);
umax = max(U(index))/Uoc;
umin = min(U(index))/Uoc;
plot(umax*ones(1,100),linspace(0,1,100),'k-.');
plot(umin*ones(1,100),linspace(0,1,100),'k-.');
xlim([0 1]);
ylim([0 1]);
grid on;
title('标幺P-V曲线');
xlabel('U/U_{oc}');
ylabel('P/P_{m}');
saveas(f,'figure/p-v-one.eps','epsc');
saveas(f,'figure/p-v-one.png');
%%
clf;
hold on;
plot(IPH/Iph,U(index)/Uoc);
ylim([0 1]);
plot(linspace(0,2,100),umax*ones(1,100),'k-.');
grid on;
grid minor;
plot(linspace(0,2,100),umin*ones(1,100),'k-.');
title('光照(标幺光生电流)-最大功率点标幺电压');
xlabel('I_{ph}/I_{ph0}');
ylabel('U_{mpp}/U_{oc}');
saveas(f,'figure/umpp-iph-one.eps','epsc');
saveas(f,'figure/umpp-iph-one.png');
close(f);