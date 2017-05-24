function F = func_example(x, A) % A is a parameter inside the function and is going to be determined from the main while x is the solution vector

F(1) = exp(-exp(-x(1)+x(2))) - x(2)*(1+x(1)^2);
F(2) = x(1)*cos(x(2)) + x(2)*sin(x(1)) - A;