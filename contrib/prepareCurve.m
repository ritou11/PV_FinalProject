%% prepare pv iv curve
%% Plot P-V & I-V Curve
figure;
hold on;
yyaxis left;
plot(Ui,Ii); 
ylim([0 1.05*max(Ii)]);
hold on;
yyaxis right;
plot(Ui,Ui.*Ii);
ylim([0 1.05*max(Ui.*Ii)]);
xlim([0 2*Uoc]);