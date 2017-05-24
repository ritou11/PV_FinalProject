function [I] = Pv4SeriesParallel(U,Iph1,Iph2,Iph3,Iph4,I0,N,Rs)
% if(Iph1>Iph2)
%    tmp=Iph1;
%    Iph1=Iph2;
%    Iph2=tmp;
% end
% if(Iph3>Iph4)
%    tmp=Iph3;
%    Iph3=Iph4;
%    Iph4=tmp;
% end
dI=@(u1) PvFunctionI(u1,Iph1,I0,N,Rs)-PvFunctionI(U-u1,Iph2,I0,N,Rs);
U1=fsolve(dI,U,optimset('Display','off'));
I=PvFunctionI(U1,Iph1,I0,N,Rs);

dI=@(u1) PvFunctionI(u1,Iph3,I0,N,Rs)-PvFunctionI(U-u1,Iph4,I0,N,Rs);
U1=fsolve(dI,U,optimset('Display','off'));
I2=PvFunctionI(U1,Iph3,I0,N,Rs);

I=real(I+I2);
end