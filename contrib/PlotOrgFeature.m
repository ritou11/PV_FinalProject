function PlotOrgFeature(vfile, ifile)
[~,i]=importfile(ifile);
[t,v]=importfile(vfile);
fv=v;
fi=i;
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
%% I-V
title('I-V & P-V');
yyaxis left;
plot(fv,fi,'.');
ylabel('I/A');
ylim([0 max(fi)*1.05]);
%% P-V
yyaxis right;
plot(fv,fi.*fv,'.');
ylabel('P/W');
ylim([0 max(fi.*fv)*1.05]);
xlabel('U/V');
xlim([10 max(fv)*1.05]);
end