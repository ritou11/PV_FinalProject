function [Iph, I0, N, Rs, Rp] = FitFunction(v, i, Iph0, I00, N0, Rs0, Rp0)
fun = @(p)(exp((v+i*p(4))/p(3))-1)*p(2)+i-p(1)+(v+i*p(4))/p(5);
p0 = [Iph0 I00 N0 Rs0 Rp0];
% options = optimoptions('lsqnonlin','MaxIterations',1000,'MaxFunctionEvaluations',5000);
% lo=[Iph0*0.9 0 0 0 Rp0*0.7];
% up=[Iph0*1.1 I00*100 N0*2 Rs0*2 Rp0*1.5];
%p = lsqnonlin(fun, p0, lo, up, options)
lo=[Iph0*0.9 0 0 0 Rp0*0.7];
up=[Iph0*1.1 inf N0*2 2*Rs0 Rp0*3];
problem = createOptimProblem('lsqnonlin','objective',fun,'x0',p0,...
    'lb',lo,'ub',up,'options',optimset('Disp','iter'));
ms = MultiStart;
p = run(ms,problem,100);
% p = lsqnonlin(fun, p0, lo, up, options);
p./p0

Iph=p(1);
I0=p(2);
N=p(3);
Rs=p(4);
Rp=p(5);
end