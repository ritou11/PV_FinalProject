function PlotData(vfile, ifile)
[~,i]=importfile(ifile);
[t,v]=importfile(vfile);
[~, fv] = FilterData(t, v, 20);
[ft, fi] = FilterData(t, i, 20);
%% Plot
%f = figure;
%% Org
subplot(2,1,1);
title('Original Data');
yyaxis left;
plot(t,i);
ylabel('I/A');
ylim([-abs(min(i)) max(i)*1.05]);
yyaxis right;
plot(t,v);
ylabel('U/V');
ylim([-abs(min(v)) max(v)*1.05]);
legend('I','U');
xlabel('t/s');
xlim([min(t) max(t)*1.05]);
%% Filt
subplot(2,1,2);
title('Filtered Data');
yyaxis left;
plot(ft,fi);
ylabel('I/A');
ylim([-abs(min(fi)) max(fi)*1.05]);
yyaxis right;
plot(ft,fv);
ylabel('U/V');
ylim([-abs(min(fv)) max(fv)*1.05]);
legend('I','U');
xlabel('t/s');
xlim([min(t) max(t)*1.05]);
end