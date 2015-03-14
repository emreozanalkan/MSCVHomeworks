% 
% % Load
% load ex4x.dat;
% load ex4y.dat;
% 
% ex4x = [ones(size(ex4x, 1), 1), ex4x];
% 
% pos = find(ex4y == 1);
% neg = find(ex4y == 0);
% 
% 
% % PLOT
% figure;
% plot(ex4x(pos, 2), ex4x(pos,3), 'g+', 'LineWidth', 2); 
% xlabel('Exam 1 Score');
% hold on;
% plot(ex4x(neg, 2), ex4x(neg, 3), 'ro', 'LineWidth', 2);
% ylabel('Exam 2 Score');
% legend('Admitted', 'Not Admitted');
% hold off;
% 
% 
% %g = inline('1.0 ./ (1.0 + exp(-z))');
% g = @(z) 1.0 ./ (1.0 + exp(-z));
% 
% figure;
% plot(g(-10:0.01:10));



% Fabrice

load ex4x.dat;
load ex4y.dat;

x = ex4x;
y = ex4y;

[m, n] = size(x);

x = [ones(size(x, 1), 1), x];

pos = find(y == 1);
neg = find(y == 0);

g = @(z) 1.0 ./ (1.0 + exp(-z));


% Initialize fitting parameters
theta = zeros(n + 1, 1);

% Define the sigmoid function
g = inline('1.0 ./ (1.0 + exp(-z))');

% Newton's method
MAX_ITR = 7;
J = zeros(MAX_ITR, 1);

for ii = 1 : MAX_ITR
    
    % Calculate the hypothesis function
    z = x * theta;
    h = g(z);
    
    % Calculate gradient and hessian
    
    grad = (1 / m) .* x' * (h - y);
    H = (1 / m) .* x' * diag(h) * diag(1-h) * x;
    %t = diag(h);
    % Calculate J (for testing convergence)
    J(ii) = (1 / m) * sum(-y .* log(h) - (1 - y) .* log(1 - h));
    
    theta = theta - H  \ grad;
    
end

% Display theta
theta


% PLOT
figure;
plot(x(pos, 2), x(pos,3), 'g+', 'LineWidth', 2); 
xlabel('Exam 1 Score');
hold on;
plot(x(neg, 2), x(neg, 3), 'ro', 'LineWidth', 2);
ylabel('Exam 2 Score');
legend('Admitted', 'Not Admitted');
%hold off;

% Probability of students admitted get 20 and 80 from exams
p = [1 20 80] * theta;
p = g(p);

% % y1 = 15 * theta(2) + theta(3);
% % y2 = 65 * theta(2) + theta(3);
% 
% x1 = 15;
% x2 = 65;
% 
% y1 = 15 * theta(2) + theta(3);
% y2 = 65 * theta(2) + theta(3);
% 
% %plot([x1, y1], [x2 y2]);


X1 = [min(x(:, 2)) - 5; max(x(:, 2)) + 5];

X2 = (-theta(1) - theta(2) * X1) / theta(3);

plot(X1, X2);
















