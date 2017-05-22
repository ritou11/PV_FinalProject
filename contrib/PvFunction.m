function U = PvFunction(I,Iph,I0,N,Rs)
    U=-I*Rs+N*log((I0+Iph-I)/I0);
end