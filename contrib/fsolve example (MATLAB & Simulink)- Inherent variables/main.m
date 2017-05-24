clc; clear all; close all;

x0 = [0 0];
A = 0.5;
fun = @(x) func_example(x, A) % must be written as this as if we want to pass another value to the function, but a(x) written to indicate that the solution vector is x and it is the unknown to be found
x = fsolve(fun, x0)% or x = solve(@func_example, x0), x0 are the initial guess vector, x is the outpur solution vector