function PlotPvCurve5(I0,Iph,N,Rs,Rp)
Uoc=log(Iph/I0)*N;
yu=0:1:Uoc;
xi=yu;
for i=1:length(yu)
    xi(i)=PvFunction5(yu(i),Iph,I0,N,Rs,Rp);
end
yyaxis left;
plot(yu,xi);
xlabel('U/V');
ylabel('I/A');
title('I-V & P-V Curves');
grid on;
grid minor;
ylim([0,Iph*1.1]);
xlim([0,Uoc*1.1]);
yyaxis right;
plot(yu,xi.*yu);
ylim([0,1.1*max(xi.*yu)]);
ylabel('P/W');
legend('I-V Curve','P-V Curve');
end