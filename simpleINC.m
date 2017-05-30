function simpleINC()
%% Parameters
Uoc = 335;
Isc = 48;
Ump=240;
Pmp=10e3;
Imp=Pmp/Ump;
[Iph, I0, N, Rs] = calcPvParameters(Uoc, Isc, Ump, Imp);
Iph1=Iph;Iph2=Iph*0.3;
Iph3=0.9*Iph;Iph4=0.1*Iph;

U=(0:Uoc/50:2*Uoc)';% To calc
Ui=(0:Uoc/500:2*Uoc)';% To spline
%% Calc P-V I-V Curve
U1 = U;
I = U;
h = waitbar(0,'Plotting p-v & i-v curves...');
steps = length(U1);
for i=1:length(U1)
    I(i) = Pv4SeriesParallel(U(i),Iph1,Iph2,Iph3,Iph4,I0,N,Rs);
    waitbar(i/steps);
end
close(h);
%% Spline
Ii = spline(U,I,Ui);
%% Plot P-V & I-V Curve
figure;
AX=plotyy(Ui,Ii,Ui,Ui.*Ii);
set(AX(1),'xlim',[0 2*Uoc],'ylim',[0 1.05*max(Ii)],'ytick',0:5*10^floor(log10(max(Ii/10))):1.05*max(Ii));
set(AX(2),'xlim',[0 2*Uoc],'ylim',[0 1.05*max(Ui.*Ii)],'ytick',0:5*10^floor(log10(max(Ui.*Ii/10))):1.05*max(Ui.*Ii));
hold on;
%% MPPT
flag=zeros(length(Ui),1);
k=length(Ui)-10;
dk=5;
lastk=k+dk;
while(1)
    dI=Ii(k)-Ii(lastk);
    dU=Ui(k)-Ui(lastk);
    I=Ii(k);
    U=Ui(k);
    flag(k)=flag(k)+1;
    if(flag(k)>10)
        break;
    end
    if(dU==0)
        if(dI==0)
           lastk=k;
        elseif(dI>0)            
           lastk=k;
           k=k+dk;
        else
           lastk=k;
           k=k-dk;
        end
    else
       if(dI/dU>-I/U)
           lastk=k;
           k=k+dk;
       elseif(dI/dU<-I/U)
           lastk=k;
           k=k-dk;
       else
           lastk=k;
       end       
    end
%     yyaxis left;
%     plot(U,I,'ro');
%     yyaxis right;
%     plot(U,U*I,'bo');
    plotbo =@(X,Y) plot(X,Y,'bo');
    plotro =@(X,Y) plot(X,Y,'ro');
    Ax=plotyy(U,I,U,U*I,plotbo,plotro);
    set(Ax(1),'xlim',[0 2*Uoc],'ylim',[0 1.05*max(Ii)],'ytick',0:5*10^floor(log10(max(Ii/10))):1.05*max(Ii));
    set(Ax(2),'xlim',[0 2*Uoc],'ylim',[0 1.05*max(Ui.*Ii)],'ytick',[]);
    %pause(0.1);
end
% for i=1:length(flag)
%     if(flag(i)>=4)
%         yyaxis left;
%         plot(Ui(i),Ii(i),'r*');
%         yyaxis right;
%         plot(Ui(i),Ii(i)*Ui(i),'b*');
%     end
% end
end