% exercise 3 : Invariance and linearity
% lti : Linear Time-Invariant system

%Q1
xa=[0 0 0 1 2 3 4 5 0 0 0 0 0 0 0 0 0 0];
xb=[0 0 0 0 0 0 0 0 4 3 2 1 0 0 0 0 0 0];

N = length(xa);
for k=2:N-1
    ya(k) = 3*xa(k-1)-2*xa(k)+xa(k+1);
    yb(k) = 3*xb(k-1)-2*xb(k)+xb(k+1);
end

figure(10), plot(2:N-1, xa(2:N-1), 'r*-', 2:N-1, ya(2:N-1), 'b*-');
title('{\color{red} x_a} and {\color{blue}y_a}');
figure(11), plot(2:N-1, xb(2:N-1), 'r*-', 2:N-1, yb(2:N-1), 'b*-');
title('{\color{red} x_b} and {\color{blue}y_b}');

x=xa+xb; % 'complex' signal
for k=2:N-1
    y(k) = 3*x(k-1)-2*x(k)+x(k+1);
end

%Q2
% is y equal to ya+yb ?
diffResponses = y-(ya+yb)
% diffResponses = 0 <=> the system is linear

figure(12), plot(2:N-1, xa(2:N-1)+xb(2:N-1), 'r*-', 2:N-1, ya(2:N-1)+yb(2:N-1), 'b*-');
title('{\color{red} x} and {\color{blue}y}   or    {\color{red} x_a+x_b} and {\color{blue}y_a+y_b}');


%Q3: nonlinear/noninvariant systems
% yk=1+xk
% yk=abs(xk)
% yk=xk^2
% ...

%Q4: see previous Practial works (no 1)



