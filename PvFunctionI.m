function I = PvFunctionI(U,Iph,I0,N,Rs)
eps = 1e-5;
I = Iph;
f = U+I*Rs-N*log((I0+Iph-I)/I0);
while(abs(f) > eps)    
    I = I - f/(Rs + N/(I0 - I + Iph));
    f = U+I*Rs-N*log((I0+Iph-I)/I0);
end
end