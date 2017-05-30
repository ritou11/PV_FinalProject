clear;
Uoc = 335/2;
Isc = 48/2;
Ump=240/2;
Pmp=10e3/4;
Imp=Pmp/Ump;
[Iph, I0, N, Rs] = calcPvParameters(Uoc, Isc, Ump, Imp);
M=2;k1=0.5;k2=0.8;
Iph1=Iph;Iph2=Iph*0.3;
Iph3=0.9*Iph;Iph4=0.1*Iph;
dt1=0.1;dt2=0.1;DU=10;dU=5;
T=100;Tmax=300;U=zeros(Tmax/dt1,1);I=U;P=U;
%% U I Curve
Ui=(0:Uoc/50:2*Uoc)';
Ii = Ui;
h = waitbar(0,'Step 1 Please wait...');
steps = length(Ui);
for i=1:length(Ui)
    Ii(i) = Pv4SeriesParallel(Ui(i),Iph1,Iph2,Iph3,Iph4,I0,N,Rs);
    waitbar(i/steps);
end
close(h);
%% Generate U list
js=0;u=0;U0=Uoc*ones(floor(M*Uoc/DU),1);
while u<=M*Uoc
    for i=1:M
        if k1*i*Uoc<u && k2*i*Uoc>u
            js=js+1;
            U0(js)=u;
            break;
        end
    end
    u=u+DU;
end
if js>0
    U0=U0(1:js);
else
    U0=[];
end
%% MPPT
t=0;state=1;Um=0;Pm=0;dir=0;k=0;n=0;
h = waitbar(0,'Step 2 Please wait...');
while t<Tmax
    n=n+1;
    if state==1 %% scan
        k=k+1;
        t=t+dt1;
        U(n)=U0(k);
        I(n)=Pv4SeriesParallel(U(n),Iph1,Iph2,Iph3,Iph4,I0,N,Rs);
        P(n)=U(n)*I(n);
        if P(n)>Pm
            Um=U(n);
            Pm=P(n);
        end
        if k==length(U0)
            state=2;
            k=0;
        end
    elseif state==2 %% P&O
        t=t+0.5*dt2;
        Pm=2*Um*Pv4SeriesParallel(Um,Iph1,Iph2,Iph3,Iph4,I0,N,Rs)-Pm;
        t=t+0.5*dt2;
        if dir==0
            Um=Um-dU;
        else
            Um=Um+dU;
        end
        U(n)=Um;
        I(n)=Pv4SeriesParallel(U(n),Iph1,Iph2,Iph3,Iph4,I0,N,Rs);
        P(n)=U(n)*I(n);
        if P(n)<Pm
            if dir==0
                dir=1;
            else
                dir=0;
            end
        end
        Pm=P(n);
        if abs(mod(t,T))<min(dt1,dt2)*1e-3 || abs(mod(t,T)-T)<min(dt1,dt2)*1e-3
            state=1;
            Pm=0;
        end
    end
    waitbar(t/Tmax);
end
close(h);
figure(1);
plot(Ui,Ii,U,I,'*');
xlim([0,2*Uoc]);
ylim([0,1.05*max(Ii)]);
figure(2);
plot(Ui,Ui.*Ii,U,U.*I,'*');
xlim([0,2*Uoc]);
ylim([0,1.05*max(Ui.*Ii)]);