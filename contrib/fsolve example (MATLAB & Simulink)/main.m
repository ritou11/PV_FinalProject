clc; clear all; close all;

x0 = [0 0];
fun = @func_example 
x = fsolve(fun, x0)% or x = solve(@func_example, x0), x0 are the initial guess vector, x is the outpur solution vector