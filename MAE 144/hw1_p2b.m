clear all; close all; clc;
% Set up G(s) and f
b = RR_poly([-2 2 -5 5],1), a = RR_poly([-1 1 -3 3 -6 6],1)
f1 = RR_poly([-1 -1 -3 -3 -6 -6],1);

% Call RR_Diophantine
[x1,y1] = RR_diophantine(a,b,f1)

% Checking if the controller D1 is proper
D1 = RR_tf(y1,x1)

% Define a new target f2, Call Diophantine, and Check if D(s) is proper
f2 = RR_poly([-1 -1 -3 -3 -6 -6 -20 -20 -20 -20 -20],1);
[x2,y2] = RR_diophantine(a,b,f2)
D2 = RR_tf(y2,x2)

% Validating D2(s)
test=trim(a*x2+b*y2), residual=norm(f2-test)