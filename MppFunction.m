function [Pmpp, Umpp, Impp] = MppFunction(Iph,I0,N,Rs)
I=linspace(0,Iph,1000);
U=PvFunction(I,Iph,I0,N,Rs);
[Pmpp,j] = max(U.*I);
Umpp=U(j);
Impp=I(j);
end