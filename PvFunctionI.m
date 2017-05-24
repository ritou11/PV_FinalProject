function [I] = PvFunctionI(U,Iph,I0,N,Rs)
eps = 1e-5;
I = Iph;
f = U+I*Rs-N*log((I0+Iph-I)/I0);
cnt = 0;
while(abs(f) > eps)
    I = I - f/(Rs + N/(I0 - I + Iph));
    f = U+I*Rs-N*log((I0+Iph-I)/I0);
    cnt = cnt + 1;
    if(cnt > 5000)
        break;
    end
    if(I > Iph)
       I=Iph;
       break;
    end
end
I = I + I0*(exp(-100/N*U)-1);
end