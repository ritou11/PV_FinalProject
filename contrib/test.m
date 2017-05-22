%%目标函数
f = @(x) x.*sin(x) + x.*cos(2.*x);
%% 的取值范围
lb = 0;
ub = 10;
%% 寻找最小值和绘图
x0 = [0 1 3 6 8 10];
hf = figure;
for i=1:6
   x(i) = fmincon(f,x0(i),[],[],[],[],lb,ub,[],...
                  optimset('Algorithm','SQP','Disp','none'));
   subplot(2,3,i)
   ezplot(f,[lb ub]);
   hold on
   plot(x0(i),f(x0(i)),'k+')
   plot(x(i),f(x(i)),'ro')
   hold off
   title(['Starting at ',num2str(x0(i))])
   if i == 1 || i == 4
       ylabel('x sin(x) + x cos(2 x)')
   end
end

x2 = fminbnd(f,lb,ub);
figure
ezplot(f,[lb ub]);
hold on
plot(x2,f(x2),'ro')
hold off
ylabel('x sin(x) + x cos(2 x)')
title({'Solution using fminbnd.','Required no starting point!'})

% Leason Learned: Use the appropriate solver for your problem type!
%% But what if |fmincon| was the only choice?
% Use globalSearch or MultiStart
problem = createOptimProblem('fmincon','objective',f,'x0',x0(1),'lb',lb,...
            'ub',ub,'options',optimset('Algorithm','SQP','Disp','none'));
gs = GlobalSearch;
xgs = run(gs,problem);
figure
ezplot(f,[lb ub]);
hold on
plot(xgs,f(xgs),'ro')
hold off
ylabel('x sin(x) + x cos(2 x)')
title('Solution using globalSearch.')
