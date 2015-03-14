function [x_hat, P_hat] = discrete_kf(A, B, C, Q, R, z, u, x0, P0)
% estimate the state x_hat of a system given model defined by A, B, C, Q, R
% and set of measurements z, input u, and initial values x0, and P0

N = size(z, 1);   % number of measurements
x_previous = x0;  % initial state
P_previous = P0;  % initial covariance
I = eye(size(P0)); % identity matrix

x_hat = [];
P_hat = [];

for ii = 1 : N
    
    % step 1: prediction
    x_predict = A * x_previous + B * u;   % state prediction
    P_predict  = A * P_previous * A' + Q; % covariance predict
    
    % step 2: correction
    K = P_predict * C' * inv(C * P_predict * C' + R);   % Kalman gain
    x_update = x_predict + K * (z(ii) - C * x_predict); % state update
    P_update = (I - K * C) * P_predict;
    
    x_hat = [x_hat x_update];
    P_hat = [P_hat P_update];
    
    x_previous = x_update;
    P_previous = P_update;
end



end