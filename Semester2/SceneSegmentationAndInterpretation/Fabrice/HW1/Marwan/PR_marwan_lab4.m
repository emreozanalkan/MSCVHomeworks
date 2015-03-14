close all; clear all;
%% Load Training Data
load('ex4x.dat');
load('ex4y.dat');

x = [ones(length(ex4x),1), ex4x];
y = ex4y;

%% Plot the data
pos = find( y == 1);
neg = find( y == 0);

figure(1);
plot(x(pos,2),x(pos,3), '+'); hold on;
plot(x(neg,2),x(neg,3), 'o');

%% Newton's Method
g = inline('1.0 ./ (1.0 + exp(-z))');

initial_theta = zeros(size(x,2), 1);
theta = initial_theta;
num_iters = 6
threshold = 10^-4;
len = length(y);

hx = g(x*theta);
prevJ = -1/(len) * sum( y'*log(hx) + (1-y')*log(1-hx) );
grad = (1/len) * x'*(hx -y);
Hessian = (1/len) * x' *diag(hx) * diag(1-hx) * x;

  for iter = 1:num_iters
    theta = theta - Hessian \ grad;
    
    hx = g(x*theta);
    J = -1/(len) * sum( y'*log(hx) + (1-y')*log(1-hx) );
    grad = (1/len) * x'*(hx -y);
    Hessian = (1/len) * x' *diag(hx) * diag(1-hx) * x;
    
    if(abs(J - prevJ) < threshold)
      break;
    end
  end
  iter

%% Plotting results
figure(2);
plot(x(pos,2),x(pos,3), '+'); hold on;
plot(x(neg,2),x(neg,3), 'o');
plot_x = [min(x(:,2))-5,  max(x(:,2))+5];
plot_y = (-1./theta(3)).*(theta(2).*plot_x + theta(1));
plot(plot_x, plot_y)
hold off;

%% test data
xtest = [1 20 80];
hx = sigmoid(xtest * theta);
disp(hx);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load PCA
load('pca_lda_verify_data');
x1 = class1'; x2 = class2'; x3 = class3';

%% Mean and covariances
mu1 = mean(x1);
cov1 = cov(x1);
mu2 = mean(x2);
cov2 = cov(x2);
mu3 = mean(x3);
cov3 = cov(x3);

%% PCA
xcentered = x1 - repmat(mu1,[length(x1) 1]);

S = xcentered' * xcentered;

[V,D] = eig(S);
[sortedValues, sortedIndex] = sort(D(1:size(D,1)+1:end),'descend');
vnew = V(:,sortedIndex(1:newd));

% project data
xnew1 = (vnew' * x1')';
xnew2 = (vnew' * x2')';
xnew3 = (vnew' * x3')';

%% Plot PCA
figure(31); hold on;
plot(xnew1(:,1), '+');
plot(xnew2(:,1), 'ro');
title('Class 1 and Class 2');
hold off;
figure(41);hold on;
hist(xnew1(:,1));
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r');
hist(xnew2(:,1));
title('Class 1 and Class 2');
hold off;

figure(32); hold on;
plot(xnew1(:,1), '+');
plot(xnew3(:,1), 'go');
title('Class 1 and Class 3');
hold off;
figure(42);hold on;
hist(xnew1(:,1));
h = findobj(gca,'Type','patch');
set(h,'FaceColor','g');
hist(xnew3(:,1));
title('Class 1 and Class 3');
hold off;

figure(33); hold on;
plot(xnew2(:,1), 'r+');
plot(xnew3(:,1), 'go');
title('Class 2 and Class 3');
hold off;
figure(43);hold on;
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r');
hist(xnew2(:,1));
h = findobj(gca,'Type','patch');
set(h,'FaceColor','g');
hist(xnew3(:,1));
title('Class 2 and Class 3');
hold off;