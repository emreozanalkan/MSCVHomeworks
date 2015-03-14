% Tutorial: Skeletonization

%% Exercise 1. Hit-or-miss transform
mickey = imread('mickey.bmp');

T1 = [1 1 1; 0 1 0; 0 0 0];
T2 = [0 0 0; 0 0 0; 1 1 1];

B = HitORMiss(mickey, T1, T2);

subplot(1, 2, 1);
imshow(mickey);
subplot(1, 2, 2);
imshow(B);

%% Exercise 2. Thinning and thickening
mickey = imread('mickey.bmp');

T1 = [1 1 1; 0 1 0; 0 0 0];
T2 = [0 0 0; 0 0 0; 1 1 1];

B = ThinningTheta(mickey, T1, T2);

subplot(1, 2, 1);
imshow(mickey);
subplot(1, 2, 2);
imshow(B);

%% Exercise 3. Topological skeleton
mickey = imread('mickey.bmp');

mickeyTemp = mickey;

T1_1 = [1 1 1; 0 1 0; 0 0 0];
T1_2 = [0 0 0; 0 0 0; 1 1 1];

T2_1 = [0 1 0; 1 1 0; 0 0 0];
T2_2 = [0 0 0; 0 0 1; 0 1 1];

for ii = 1:180
    mickeyTemp = ThinningTheta(mickeyTemp, T1_1, T1_2);
    mickeyTemp = ThinningTheta(mickeyTemp, T2_1, T2_2);
    T1_1 = rot90(T1_1);
    T1_2 = rot90(T1_2);
    T2_1 = rot90(T2_1);
    T2_2 = rot90(T2_2);
end

subplot(1, 2, 1);
imshow(mickey);
subplot(1, 2, 2);
imshow(mickeyTemp);

%% Exercise 4. Morphological skeleton
mickey = imread('mickey.bmp');

























































