function [ I ] = Model( U,Iph,C,Io,Rs )
Io2=Io;C2=C*10;
UI=@(I1) log((Iph+Io-I1)/Io)/C-Rs*I1-U;
I1=fsolve(UI,0*U+Iph,optimset('Display','off'));
I2=Io2*(exp(-C2*U)-1);
I=I1+I2;
end