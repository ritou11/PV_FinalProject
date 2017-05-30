function [ I ] = IphFunction( t,Iph1,Iph2,t1,t2,t3,t4,t5 )
if 0<=t && t<t1
    I=Iph1;
elseif t1<=t && t<t2
    I=Iph1+(Iph2-Iph1)*(t-t1)/(t2-t1);
elseif t2<=t && t<t3
    I=Iph2;
elseif t3<=t && t<t4
    I=Iph2+(Iph1-Iph2)*(t-t3)/(t4-t3);
elseif t4<=t && t<=t5
    I=Iph1;
else
    I=Iph1;
end
end

