% lab usage of Lab 1 Visual Perseption Desire Sedibe
% Date 26:3:2014 10:00am


im1 = imread('labo_right.tif');
im2 = imread('labo_left.tif');

n = 12; % number of correpsonding points

cores_points1 = select_points(im1,n);
cores_points2 = select_points(im2,n);
save('myspace');
%%
load('myspace');
n = 12;
A = ones(n,8);
% corrresponding points achieveed
for ii = 1:1:n
    A(ii,:) = [(cores_points1(ii,1)*cores_points2(ii,1)) ...
        (cores_points1(ii,1)*cores_points2(ii,2)) cores_points1(ii,1) ...
        (cores_points1(ii,2)*cores_points2(ii,1))...
        (cores_points1(ii,2)*cores_points2(ii,2)) ...
        cores_points1(ii,2) cores_points2(ii,1) cores_points2(ii,2)];
end

%% Now using least square
B = -1*ones(n,1);
f = inv(A'*A) * A'* B;
% finding fundamental matrix
F = ones(3,3);
F(1,:) = [f(1,1) f(2,1) f(3,1)];
F(2,:) = [f(4,1) f(5,1) f(6,1)];
F(3,:) = [f(7,1) f(8,1) 1];
%%
rank(F)
disp('rank is 3 we have to make it 2')
disp('determinant of f')
det(F)
disp(' determinant also do not fulfils the constarint')
%%
% now the second method Using SVD F2 will be our fundamental matrix
A2 = [A,ones(n,1)];
[u,s,v] = svd(A2);
f2 = v(:,end);
F2 = ones(3,3);
F2(1,:) = [f2(1,1) f2(2,1) f2(3,1)];
F2(2,:) = [f2(4,1) f2(5,1) f2(6,1)];
F2(3,:) = [f2(7,1) f2(8,1) f2(9,1)];
%%
rank(F2)
disp('rank is 3 we have to make it 2')
disp('determinant of f')
det(F2)
disp(' determinant also do not fulfils the constarint')

%%
% now lets enforce Condition of Rank 2 for fundamental matrix of section
% 3.1
 [u1,s1,v1] = svd(F);
 s1(end,end) = 0;
 Fundamental1 = u1 * s1 * v1';
 det(Fundamental1)
 rank(Fundamental1)
 %% Error LLS
 % Error Estimation
%for LLS method
error = 0;
for ii = 1:12
    error = error + abs(dot(Fundamental1*cores_points2(ii,:)',cores_points1(ii,:)'));
end
disp('error LLS without Normalization')
error
 

 %%
  [u2,s2,v2] = svd(F2);
 s2(end,end) = 0;
 Fundamental2 = u2 * s2 * v2';
 det(Fundamental2)
 rank(Fundamental2)
 disp(' rank is 2 but deteerminan is small but not zero')
 %% Error SVD
 % Error Estimation
%for SVD method
error = 0;
for ii = 1:12
    error = error + abs(dot(Fundamental2*cores_points2(ii,:)',cores_points1(ii,:)'));
end
disp('error SVD without Normalization')
error
 
 %%

% Displaying Epipolar lines on Image 1 help from chinmay
% PC = PC1(:,[1,2]);
corespointsreducedimention1 = [cores_points1(:,1) cores_points1(:,2)];
corespointsreducedimention2 = [cores_points2(:,1) cores_points2(:,2)];
lines = epipolarLine(Fundamental1,corespointsreducedimention2);
A = lines(:,1); B = lines(:,2); C = lines(:,3);
X = -1000:1:1000;
X = repmat(X,[12,1]);

for i = 1:size(X,1)
    for j = 1:size(X,2)
        Y(i,j) = -C(i)/B(i)- A(i)/B(i) * X(i,j);
    end
end

 figure(1)

hold on
 for k=1:size(X,1)
   
 line(X(k,:),Y(k,:));
 end
hold off

%%
% Displaying Epipolar lines on Image 2

lines = epipolarLine(Fundamental1',corespointsreducedimention1);
A = lines(:,1); B = lines(:,2); C = lines(:,3);
X = -1000:1:1000;
X = repmat(X,[12,1]);

for i = 1:size(X,1)
    for j = 1:size(X,2)
        Y(i,j) = -C(i)/B(i)- A(i)/B(i) * X(i,j);
    end
end

 figure(2)

hold on
 for k=1:size(X,1)
   
 line(X(k,:),Y(k,:));
 end

hold off

 %% Normalization New
% normalization for Image one corresponsing points
 meanans = mean(cores_points1);
 meanans2 = mean(cores_points2);
 xvals = cores_points1(:,1) - meanans(1);
 yvals = cores_points1(:,2) - meanans(2);
 meandistancetoroigin = sqrt((xvals).^2 + (yvals).^2); 
  xvals = cores_points2(:,1) - meanans2(1);
 yvals = cores_points2(:,2) - meanans2(2);
  meandistancetoroigin2 = sqrt((xvals).^2 + (yvals).^2); 
 s = sqrt(2) / mean(meandistancetoroigin);
 H = [s 0 -s*meanans(1);0 s -s*meanans(2);0 0 1];
 % H Dash
  s_2 = sqrt(2) / mean(meandistancetoroigin2);
   H_dash = [s_2 0 -s_2*meanans2(1);0 s_2 -s_2*meanans2(2);0 0 1];
  
   % Now lets transform our corresponding coordinates
   for jj = 1:12
   cores1_normalized(jj,:) = H*cores_points1(jj,:)';
   end
    for jj = 1:12
   cores2_normalized(jj,:) = H_dash*cores_points2(jj,:)';
    end
 n = 12;
 A = ones(n,8);
% corrresponding points achieveed
for ii = 1:1:n
    A(ii,:) = [(cores1_normalized(ii,1)*cores2_normalized(ii,1)) ...
        (cores1_normalized(ii,1)*cores2_normalized(ii,2)) cores1_normalized(ii,1) ...
        (cores1_normalized(ii,2)*cores2_normalized(ii,1))...
        (cores1_normalized(ii,2)*cores2_normalized(ii,2)) ...
        cores1_normalized(ii,2) cores2_normalized(ii,1) cores2_normalized(ii,2)];
end
A2 = [A,ones(n,1)];
[u,s,v] = svd(A2);
fjd = v(:,end);
% finding fundamental matrix
F_new = ones(3,3);
F_new(1,:) = [fjd(1,1) fjd(2,1) fjd(3,1)];
F_new(2,:) = [fjd(4,1) fjd(5,1) fjd(6,1)];
F_new(3,:) = [fjd(7,1) fjd(8,1) 1];
  % now we have estimated our Fundamental Matrix Now lets express it in
  % original Cordinates again
  
  
 % it is rank three so we force its rank to 2
  [u2,s2,v2] = svd(F_new);
 s2(end,end) = 0;
 F_normalized_fin = u2 * s2 * v2';
 det(F_normalized_fin)
 rank(F_normalized_fin)
 F_normalized_fin = H_dash'*F_normalized_fin*H;
 %% Again show Epipolar Lines
 % Displaying Epipolar lines on Image 1
% PC = PC1(:,[1,2]);
corespointsreducedimention1 = [cores_points1(:,1) cores_points1(:,2)];
corespointsreducedimention2 = [cores_points2(:,1) cores_points2(:,2)];
lines = epipolarLine(F_normalized_fin',corespointsreducedimention2);
A = lines(:,1); B = lines(:,2); C = lines(:,3);
X = -1000:1:1000;
X = repmat(X,[12,1]);
load('myspace');

for i = 1:size(X,1)
    for j = 1:size(X,2)
        Y(i,j) = -C(i)/B(i)- A(i)/B(i) * X(i,j);
    end
end

 figure(1)

hold on
 for k=1:size(X,1)
   
 line(X(k,:),Y(k,:));
 end

hold off
 %% Now Epipolar Lines in Second Image

% Displaying Epipolar lines on Image 2

lines = epipolarLine(F_normalized_fin',corespointsreducedimention1);
A = lines(:,1); B = lines(:,2); C = lines(:,3);
X = -1000:1:1000;
X = repmat(X,[12,1]);

for i = 1:size(X,1)
    for j = 1:size(X,2)
        Y(i,j) = -C(i)/B(i)- A(i)/B(i) * X(i,j);
    end
end

 figure(2)

hold on
 for k=1:size(X,1)
   
 line(X(k,:),Y(k,:));
 end

hold off
 %% Error SVD After Normalization
 % Error Estimation
%for LLS method
error = 0;
for ii = 1:12
    error = error + abs(dot(F_normalized_fin*cores_points2(ii,:)',cores_points1(ii,:)'));
end
disp('error SVD after Normalization')
error
 