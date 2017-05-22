close all;
%%
[~,I]=importfile('BM_F0000CH2.CSV');
[~,U]=importfile('BM_F0000CH1.CSV');
trimI=I(450:end);
trimU=U(450:end);
[Iph, I0, N, Rs, Rp]=calcPvParameters5(125,0.93,trimU,trimI,1800);
%[Iph, I0, N, Rs, Rp]=FitFunction(trimU,trimI,Iph,I0,N,Rs,Rp);
%GenerateReport(U,I,I0,Iph,N,Rs,Rp,'BM');

%%
[~,I]=importfile('M_F0003CH2.CSV');
[~,U]=importfile('M_F0003CH1.CSV');
trimI=I(165:end);
trimU=U(165:end);
[Iph, I0, N, Rs, Rp]=calcPvParameters5(82,7.3,trimU,trimI,230);
%[Iph, I0, N, Rs, Rp]=FitFunction(trimU,trimI,Iph,I0,N,Rs,Rp);
%GenerateReport(U,I,I0,Iph,N,Rs,Rp,'M');

%% 
[~,I]=importfile('S_F0001CH2.CSV');
[~,U]=importfile('S_F0001CH1.CSV');
trimI=I(450:end);
trimU=U(450:end);
[Iph, I0, N, Rs, Rp]=calcPvParameters5(42,3.9,trimU,trimI,150);
%[Iph, I0, N, Rs, Rp]=FitFunction(trimU,trimI,Iph,I0,N,Rs,Rp);
%GenerateReport(U,I,I0,Iph,N,Rs,Rp,'S');