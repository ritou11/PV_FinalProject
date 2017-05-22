function GenerateReport(U,I,I0,Iph,N,Rs,Rp,label)
f = figure;
hold on;
title('I-V & P-V');
xlabel('U/V');
%% Org I-V
yyaxis left;
plot(U,I,'.');
ylabel('I/A');
ylim([0 max(I)*1.05]);
%% Org P-V
yyaxis right;
plot(U,I.*U,'.');
ylabel('P/W');
ylim([0 max(I.*U)*1.05]);
xlim([0 max(U)*1.05]);
%% Curve
Uoc=log(Iph/I0)*N;
yu=0:1:Uoc;
xi=yu;
for i=1:length(yu)
    xi(i)=PvFunction5(yu(i),Iph,I0,N,Rs,Rp);
end
yyaxis left;
plot(yu,xi);
title('I-V & P-V Curves');
grid on;
grid minor;
ylim([0,Iph*1.1]);
xlim([0,Uoc*1.1]);
yyaxis right;
plot(yu,xi.*yu);

legend('Org I-V Curve','Org P-V Curve','I-V Curve','P-V Curve');
%% Save
saveas(f,sprintf('figure\\%s_figure.eps',label),'epsc');
saveas(f,sprintf('figure\\%s_figure.jpg',label));
close(f);
file = fopen(sprintf('%s_params.txt',label),'w');
fprintf(file,'Iph = %f\n',Iph);
fprintf(file,'I0 = %f\n',I0);
fprintf(file,'N = %f\n',N);
fprintf(file,'Rs = %f\n',Rs);
fprintf(file,'Rp = %f\n',Rp);
end