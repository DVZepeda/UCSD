clear all; close all; clc;
% Set up G(s) and f
b = RR_poly([-2 2 -5 5],1), a = RR_poly([-1 1 -3 3 -6 6],1)
f = RR_poly([-1 -1 -3 -3 -6 -6],1);

% Call RR_Diophantine
[x,y] = RR_diophantine(a,b,f)
Ds = RR_tf(y,x)

% Validating D(s)
test=trim(a*x+b*y), residual=norm(f-test)