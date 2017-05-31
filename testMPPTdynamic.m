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
T=100;Tmax=20;U=zeros(Tmax/dt1,1);I=U;P=U;
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
%% Generate U list
% js=0;u=0;U0=Uoc*ones(floor(M*Uoc/DU),1);
% while u<=M*Uoc
%     for i=1:M
%         if k1*i*Uoc<u && k2*i*Uoc>u
%             js=js+1;
%             U0(js)=u;
%             break;
%         end
%     end
%     u=u+DU;
% end
% if js>0
%     U0=U0(1:js);
% else
%     U0=[];
% end
%% MPPT
t=0;state=2;Um=0.9*Uoc;Pm=0;dir=0;k=0;n=0;
h = waitbar(0,'Step 2 Please wait...');
while t<Tmax
    n=n+1;
    if state==1 %% scan
        k=k+1;
        t=t+dt1;
        U(n)=U0(k);
        I(n)=PvFunctionI(U(n),IphFunction(t,Iph1,Iph2,t1,t2,t3,t4,t5),I0,N,Rs);
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
%         if abs(mod(t,T))<min(dt1,dt2)*1e-3 || abs(mod(t,T)-T)<min(dt1,dt2)*1e-3
%             state=1;
%             Pm=0;
%         end
    end
    waitbar(t/Tmax);
end
close(h);
figure(1);
plot(Ui,Ii1,Ui,Ii2,U,I,'*');
xlim([0,Uoc]);
ylim([0,1.05*max(Iph1,Iph2)]);
figure(2);
plot(Ui,Ui.*Ii1,Ui,Ui.*Ii2,U,U.*I,'*');
xlim([0,Uoc]);
ylim([0,1.05*max(max(Ui.*Ii1),max(Ui.*Ii2))]);