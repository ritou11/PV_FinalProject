clear;
preparas;
Iph1=Iph;Iph2=Iph*0.4;Iph3=0.7*Iph;Iph4=0.005*Iph;
U=(-0.07*Uoc:Uoc/50:2*Uoc)';
dI=@(U1) Model(U1,Iph1,C,Io,Rs)-Model(U-U1,Iph2,C,Io,Rs);
U1=fsolve(dI,U,optimset('Display','off'));
I=Model(U1,Iph1,C,Io,Rs);
plot(U,I); 
