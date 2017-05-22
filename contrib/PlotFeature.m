function PlotFeature(vfile, ifile)
[~,i]=importfile(ifile);
[t,v]=importfile(vfile);
[~, fv] = FilterData(t, v, 20);
[ft, fi] = FilterData(t, i, 20);
%% Plot
%f = figure;
% %% I-V
% subplot(1,2,1);
% title('I-V Curve');
% plot(fv,fi);
% ylabel('I/A');
% ylim([0 max(fi)*1.05]);
% xlabel('U/V');
% xlim([10 max(fv)*1.05]);
% %% P-V
% subplot(1,2,2);
% title('P-V Curve');
% plot(fv,fi.*fv);
% ylabel('P/W');
% ylim([0 max(fi.*fv)*1.05]);
% xlabel('U/V');
% xlim([10 max(fv)*1.05]);
[maxp, j] = max(fi.*fv);
%% I-V
title('I-V & P-V');
hold on;
yyaxis left;
plot(fv,fi);
plot(fv(j),fi(j),'o');
ylabel('I/A');
ylim([0 max(fi)*1.05]);
%% P-V
yyaxis right;
plot(fv,fi.*fv);
plot(fv(j),maxp,'o');
ylabel('P/W');
ylim([0 max(fi.*fv)*1.05]);
xlabel('U/V');
[~,j]=max(fi);
xlim([fv(j) max(fv)*1.05]);
grid on;
grid minor;
hold off;
end