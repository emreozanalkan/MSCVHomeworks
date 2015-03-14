close all;
clear all;
clc;

measurements = [5 6 7 9 10];

motions = [1 1 2 1 1];

sigma_measurements = 4;

sigma_motion = 2;

mu0 = 0;

sigma0 = 10000; % initial parameters: large variance

for ii = 1 : length(measurements)
    [mu0, sigma0] = update(mu0, sigma0, measurements(ii), sigma_measurements);
    display(['update: mu =' num2str(mu0) ' and sigma = ' num2str(sigma0)]);
    [mu0, sigma0] = predict(mu0, sigma0, motions(ii), sigma_motion);
    display(['predict: mu =' num2str(mu0) ' and sigma = ' num2str(sigma0)]);
end


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%%
x = 5;
t = 1 : 100;
y = x + 0.01 * randn(1, 100);
plot(t, y, '-xr');
mean = sum(y) / length(y);


hN = y(1);

yLength = length(y);

hold on;

for ii = 1 : yLength
    hN = kalmanFunction(y(ii), hN, yLength);
    plot(hN);
end






