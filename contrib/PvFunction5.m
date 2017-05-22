function I = PvFunction5(U,Iph,I0,N,Rs,Rp)
eps = 1e-5;
I = Iph;
f = I - Iph + (U + Rs*I)/Rp + I0*(exp((U + Rs*I)/N) - 1);
while(abs(f) > eps)    
    I = I - f/(Rs/Rp + (I0*Rs*exp((U + Rs*I)/N))/N + 1);
    f = I - Iph + (U + Rs*I)/Rp + I0*(exp((U + Rs*I)/N) - 1);
end
end