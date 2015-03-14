% Debayle - Lab 2 - TUT_GANIP 

%% Exercise 2. GAN Choquet filtering
lena = imread('lena256.bmp');

subplot(1, 2, 1);
imshow(lena);

B = GANmean(lena, 30);

subplot(1, 2, 2);
imshow(B, []);


%% Exercise 1. GAN
lena = imread('lena256.bmp');

subplot(1, 3, 1);
imshow(lena);

x = 10;
y = 10;

V = GAN(lena, x, y, 30);

subplot(1, 3, 2);
imshow(V);
hold on;
plot(x, y, 'ro');
hold off;


subplot(1, 3, 3);
bw = bwlabel(V);

labelNumber = bw(x, y);

labelPart = bw == labelNumber;

RGB = label2rgb(labelPart, @jet, 'k');
imshow(RGB);

% imshow(labelPart);


%RGB = label2rgb(bw, @jet, 'k');
%imshow(RGB);

