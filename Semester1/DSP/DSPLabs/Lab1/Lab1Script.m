%% Practical works - no 1
%% Signals

%% Exercise 1
%% 1.1 
% Considering the Diract function correspoinding to Equation 1, write a
% matlab function Dirac to define a discrete signal of length N and
% containing the Dirac function at the position n (dirac(n)). Verify inside
% the function that n is in [1, N] and display a warning if it is not the
% case.

dirac = Dirac(1, 10);
plot(dirac);

%% 1.2
% Considering the step function H corresponding to Equation (2), write a
% matlab function step to define a discrete signal of length N and
% containing the value of the step function shifted at the poisiton
% n(H(n)). Verify inside the function that n is in [1, N] and display a
% warning if it is not the case.

s = step(2, 5);
plot(s);

%% 1.3
% Considering the ramp function P corresponding to Equation (3), write a
% matlab function ramp to define a discrete signal of length N and
% containing the values of the ramp function shifted at the position n with
% a slopoe a: a. P(n). Verify inside the function that n is element in [1,
% N] and display a warning if it is not the case.

