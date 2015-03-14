function [] = Lab67Recurv( )
%LAB6RECURV Summary of this function goes here
%   Detailed explanation goes here

% synthetic signal to test recursive filtering
N = 40;
x = zeros(1, N);
x(20) = 1; % Impulse to observe impulse response

% scale of the smoothing (and derivateive) filter
s = 0.7;

yp = smoothP(x, s); % causal
yn = smoothN(x, s); % anti-causal





subplot(2, 1, 1);
plot(1:N, yp, '*-');
subplot(2, 1, 2);
plot(1:N, yn, '*-');


u10 = zeros(1, N);
u10(10:N) = 1;

u30 = zeros(1, N);
u30(30:N) = 1;

x = zeros(1, N);
x = u10 - u30;







end % end of the recurv function

% Canny-Deriche edge detection
function [ImGi, ImGj] = CannyDriche(Im, s)
    ImGi = grad_i(Im, s);
    ImGj = grad_j(Im, s);
end

% gradient component Gi along rows
% we smooth along the rows and, on the result obtanied, we apply the
% derivative. Derivative can be appliied before smoothing
function Gi = grad_i(Im, s)
    [ni, nj] = size(Im);
    % smoothing along rows
    for i = 1:ni
        Iml(i, :) = smoothP(Im(i, :), s);
        Iml(i, :) = Iml(i, :) + smoothN(Im(i, :), s);
    end
    % derivative along cilums
    for j = 1:nj
        Gi(:, j) = derivP(Iml(:, j), s)'; % transpose -> '
        Gi(:, j) = Gi(:, j) + derivN(Iml(:, j), s)';
    end
end

% gradient component Gj along columns
function Gj = grad_j(Im, s)
    [ni, nj] = size(Im);
    % derivative along rows
    for i = 1:ni
        Iml(i, :) = derivP(Im(i, :), s);
        Iml(i, :) = Iml(i, :) + derivN(Im(i, :), s);
    end
    % smoothing along columns
    for j = 1:nj
        Gj(:, j) = smoothP(Iml(:, j), s)'; % transpose -> '
        Gj(:, j) = 0;
    end
    
end


% causal smoothing
function yp = smoothP(x, s)
    N = length(x);
    T = 1; % sampling
    l = s * T; % alpha
    a = exp(-1);
    yp = 0;
    yp(1:2) = 0; % initialization of the two first responses
    for k = 3:N
        yp(k) = x(k) + a * (l-1) * x(k-1) + 2 * a * yp(k-1) - a^2 * yp(k-2);
    end
end

% anti-causal smoothing
function yn = smoothN(x, s)
    N = length(x);
    T = 1;
    l = s * T; % alpha
    a = exp(-1);
    yn = 0;
    yn(N-1:N) = 0;
    for k = N-2:-1:1
        yn(k) = a * (l+1) * x(k+1) - a * a * x(k+2) + 2 * a * yn(k+1) - a^2 * yn(k+2);
    end
end
