clear;
Uoc = 335;
Isc = 48;
Ump=240;
Pmp=10e3;
Imp=Pmp/Ump;
[Iph, I0, N, Rs] = calcPvParameters(Uoc, Isc, Ump, Imp);
Iph1=Iph;Iph2=Iph*0.3;
Iph3=0.9*Iph;Iph4=0.1*Iph;
U=(0:Uoc/100:Uoc)';
IPH=0:0.1*Iph:Iph;
I = zeros(length(U),length(IPH));
h = waitbar(0,'Please wait...');
steps = length(U)*length(IPH);
for j=1:length(IPH)
    for i=1:length(U)
        %I(i) = Pv4SeriesParallel(U(i),Iph1,Iph2,Iph3,Iph4,I0,N,Rs);
        %I(i) = Pv2Series(U(i),Iph2,Iph3,I0,N,Rs);
        I(i,j) = PvFunctionI(U(i),IPH(j),I0,N,Rs);
        waitbar((i+(j-1)*length(U))/steps);
    end
end
close(h);
%%
figure;
plot(U/Uoc,U.*I(:,length(IPH))/max(U.*I(:,length(IPH))));
hold on
for i=1:length(IPH)-1
    plot(U/Uoc,U.*I(:,i)/max(U.*I(:,i)));
end
xlim([0 1]);
ylim([0 1]);
grid on