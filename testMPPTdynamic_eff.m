clear;
Uoc = 335;
Isc = 48;
Ump=240;
Pmp=10e3;
Imp=Pmp/Ump;
[Iph, I0, N, Rs] = calcPvParameters(Uoc, Isc, Ump, Imp);
Iph1=Iph;Iph2=0.3*Iph;
t1=4;t2=8;t3=12;t4=16;t5=20;
dt1=0.1;dt2=0.1;DU=20;dU=5;
Tmax=20;U=zeros(Tmax/dt1,1);I=U;P=U;
%% U I Curve
Ui=(0:Uoc/50:Uoc)';
Ii1 = Ui;
Ii2 = Ui;
h = waitbar(0,'Step 1 Please wait...');
steps = length(Ui);
for i=1:length(Ui)
    Ii1(i) = PvFunctionI(Ui(i),Iph1,I0,N,Rs);
    Ii2(i) = PvFunctionI(Ui(i),Iph2,I0,N,Rs);
    waitbar(i/steps);
end
close(h);
%% MPPT
t=0;state=2;Um=0.9*Uoc;Pm=0;dir=0;k=0;n=0;
tstep=zeros(Tmax/dt1,1);
h = waitbar(0,'Step 2 Please wait...');
while t<Tmax
    n=n+1;
    t=t+0.5*dt2;
    Pm=2*Um*PvFunctionI(Um,IphFunction(t,Iph1,Iph2,t1,t2,t3,t4,t5),I0,N,Rs)-Pm;
    t=t+0.5*dt2;
    if dir==0
        Um=Um-dU;
    else
        Um=Um+dU;
    end
    U(n)=Um;
    I(n)=PvFunctionI(U(n),IphFunction(t,Iph1,Iph2,t1,t2,t3,t4,t5),I0,N,Rs);
    P(n)=U(n)*I(n);
    if P(n)<Pm
        if dir==0
            dir=1;
        else
            dir=0;
        end
    end
    Pm=P(n);
    tstep(n) = t;
    waitbar(t/Tmax);
end
close(h);
%% Trim
U = U(1:n);
tstep = tstep(1:n);
%% Calc
U = repelem(U,2);
tstep = repelem(tstep,2);
U = U(1:2*n-1);
tstep = tstep(2:2*n);
P = tstep;
Ps = tstep;
h = waitbar(0,'Step 3 Please wait...');
for i = 1:2*n-1
    P(i) = U(i)*PvFunctionI(U(i),IphFunction(tstep(i),Iph1,Iph2,t1,t2,t3,t4,t5),I0,N,Rs);
    Ps(i) = P(i)/MppFunction(IphFunction(tstep(i),Iph1,Iph2,t1,t2,t3,t4,t5),I0,N,Rs);
    waitbar(i/(2*n-1));
end
close(h);
%% Store
ts1 = tstep;
Ps1 = Ps;
%% MPPT
t=0;state=2;Um=0.9*Uoc;Pm=0;dir=0;k=0;n=0;
tstep=zeros(Tmax/dt1,1);
h = waitbar(0,'Step 4 Please wait...');
while t<Tmax
    n=n+1;
    t=t+0.5*dt2;
    %Pm=2*Um*PvFunctionI(Um,IphFunction(t,Iph1,Iph2,t1,t2,t3,t4,t5),I0,N,Rs)-Pm;
    t=t+0.5*dt2;
    if dir==0
        Um=Um-dU;
    else
        Um=Um+dU;
    end
    U(n)=Um;
    I(n)=PvFunctionI(U(n),IphFunction(t,Iph1,Iph2,t1,t2,t3,t4,t5),I0,N,Rs);
    P(n)=U(n)*I(n);
    if P(n)<Pm
        if dir==0
            dir=1;
        else
            dir=0;
        end
    end
    Pm=P(n);
    tstep(n) = t;
    waitbar(t/Tmax);
end
close(h);
%% Trim
U = U(1:n);
tstep = tstep(1:n);
%% Calc
U = repelem(U,2);
tstep = repelem(tstep,2);
U = U(1:2*n-1);
tstep = tstep(2:2*n);
P = tstep;
Ps = tstep;
h = waitbar(0,'Step 5 Please wait...');
for i = 1:2*n-1
    P(i) = U(i)*PvFunctionI(U(i),IphFunction(tstep(i),Iph1,Iph2,t1,t2,t3,t4,t5),I0,N,Rs);
    Ps(i) = P(i)/MppFunction(IphFunction(tstep(i),Iph1,Iph2,t1,t2,t3,t4,t5),I0,N,Rs);
    waitbar(i/(2*n-1));
end
close(h);
%% Store
ts2 = tstep;
Ps2 = Ps;
%% Plot P I t
f = figure;
subplot(2,1,1);
hold on;
plot(ts1, Ps1*100);
plot(ts2, Ps2*100);
ylabel('MPPT Efficiency / %');
ylim([0 105]);
xlim([0, Tmax]);
xlabel('t/s');
grid on;
grid minor;
title('MPPT效率对比');
legend('功率预测P&O','P&O','Location','SouthEast');

subplot(2,1,2);
iphs = tstep;
for i = 1:length(tstep)
    iphs(i)=IphFunction(tstep(i),Iph1,Iph2,t1,t2,t3,t4,t5);
end
plot(tstep, iphs*1000/Iph1);
xlim([0,Tmax]);
ylim([0,1050]);
xlabel('t/s');
grid on;
grid minor;
ylabel('光照强度/（W/m^2）');
title('光照变化情况');

saveas(f,'figure/mppt-eff.eps','epsc');
saveas(f,'figure/mppt-eff.png');
close(f);