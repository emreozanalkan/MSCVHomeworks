
%% Kalman Filter Practice
close all;
clear all;
clc;

measurements = load('data/measurements.txt');
% observations = load('data/observations.txt');
% states = load('data/states.txt');

A = 1;
B = 0;
C = 1;
Q = 10 ^ -6; % Q is variance of process noise W_{k} % noise

s = std(measurements);
R = s ^ 2; % R is the variance of measurement noise V_{k}

% function [x_hat] = discrete_kf(A, B, C, Q, R, z, u, x0, P0)
[x_hat, P_hat] = discrete_kf(A, B, C, Q, R, measurements, 0,  0, 1);

t = 1:length(measurements);

figure, plot(t, measurements, 'or', t, x_hat, '-g');

figure, plot(P_hat); % we added optionally P_hat output to just see for debug

%% Vehicle Navigation
close all;
clear all;
clc;

% States   Observation
% [p1 v1]  [z1]
% [p2 v2]  [z2]
% [.. ..]  [..]
% [pn vn]  [zn]

observations = load('data/observations.txt');
states = load('data/states.txt');

T = 1 / 10; % position is measured 10 times per second

acc = 0.2;

meas = 10;

A = [1 T; 0 1];
 
B = [(T ^ 2) / 2; T];

C = [1 0];


% For kalman, we also need to define Q and R matrices
% R is the covariance of measurement nise V_{k}
% Position is measureed 10 times per second with AN ERROR OF => 10 FEET <=
R = meas ^ 2;

% Q is the covariance of process noise W_{k}
% W_k = [m_k; n_k]; [error_in_postition; error_in_velocity];
% So Q = Expected=> E[W_k W_k^T(transpose) = E [ [m_k; n_k], [m_k, n_k]]
%                   E = [.... a lot :) written on my notebook];
% We are given accceleration noise
% a_cc = 0.2 feet/sec^2
% V_{k+1} = V_k + T * u_k + n_k
% So velocity noise n_k = T * a_cc
% and P_{k + 1} = P_k + T * V_k + T ^ 2 / 2 * u_k + m_k
% So position noise m_k = T ^ 2 / 2 * a_cc
% Finally, Q = a_cc ^ 2 [T^4/4 T^3/2; T^3/2 T^2];
% Remember  x = [P; v];
% So Q = [cov(p, p) cov(p, v); cov(v, p) cov(v, v)];
% p = 0;
% v = 0;
% Q = [cov(p, p) cov(p, v); cov(v, p) cov(v, v)];

Q = acc ^ 2 * [(T ^ 4) / 4, (T ^ 3) / 2; (T ^ 3) / 2, T ^ 2];

u = 1;
x0 = [0; 0];
P0 = 10000 * ones(2, 2);

[x_hat, P_hat] = discrete_kf(A, B, C, Q, R, observations, u, x0, P0);
% x_hat: returns position and velocity estimated values

% too much to plot, lets polot first 200
% t = 1 : length(observations);
% 
% plot(t, observations, '-r', t, x_hat(1, :), '-g');

t = 1 : 200;

%plot(t, observations(1:200, :), '-r', t, x_hat(1, 1:200), '-g');
plot(t, observations(1:200, :), '-r', t, x_hat(1, 1:200), '-g', t, states(1:200, 1), '-b');










