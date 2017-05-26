%% MPPT - INC
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
    yyaxis left;
    plot(U,I,'ro');
    yyaxis right;
    plot(U,U*I,'bo');
    %pause(0.1);
end
for i=1:length(flag)
    if(flag(i)>=4)
        yyaxis left;
        plot(Ui(i),Ii(i),'r*');
        yyaxis right;
        plot(Ui(i),Ii(i)*Ui(i),'b*');
    end
end