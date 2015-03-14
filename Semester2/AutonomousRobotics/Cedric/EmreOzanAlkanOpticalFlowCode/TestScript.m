% % im1 = imread('Seq/CoastGuard/CoastGuard11.jpg');
% % im2 = imread('Seq/CoastGuard/CoastGuard12.jpg');
% 
% im1 = imread('Seq/Hamburg/dt_0010.jpg');
% im2 = imread('Seq/Hamburg/dt_0011.jpg');
% 
% im1 = imread('Seq/MotionTaxi/MotionTaxi11.jpg');
% im2 = imread('Seq/MotionTaxi/MotionTaxi12.jpg');
% 
% % function [u, v] = HS(im1, im2, alpha, ite)
% [u, v] = HS(im1, im2, 0.5);
% 
% %function plotFlow(u, v, imgOriginal, rSize, scale)
% plotFlow(u, v, im1);
% 
% % function [u, v] = LucasKanade(im1, im2, windowSize)
% %[u, v] = LucasKanade(im1, im2, 3);

% im1 = imread('Seq/Hamburg/dt_0010.jpg');
% im2 = imread('Seq/Hamburg/dt_0011.jpg');
% 
% alpha = 3;
% 
% iteration = 100;
% 
% [u, v] = HS(im1, im2, alpha, iteration);
% 
% % im1 = im1(274:337, 157:220);
% % u = u(274:337, 157:220);
% % v = v(274:337, 157:220);
% % 
% % plotFlow(u, v, im1);

% im1 = imread('Seq/Hamburg/dt_0010.jpg');
% im2 = imread('Seq/Hamburg/dt_0011.jpg');
% 
% windowSize = 9;
% %function [u, v] = LucasKanade(im1, im2, windowSize)
% tic;
% [u, v] = LucasKanade(im1, im2, windowSize);
% toc;




% im1 = imread('Seq/MotionTaxi/MotionTaxi11.jpg');
% im2 = imread('Seq/MotionTaxi/MotionTaxi12.jpg');
% 
% numLevels = 1;
% 
% alpha = 3;
% 
% iterations = 100;
% 
% display = 1;
% 
% %function [ u,v,cert ] = HierarchicalHS(im1, im2, numLevels, alpha, iterations, display)
% [u, v, cert] = HierarchicalHS(im1, im2, numLevels, alpha, iterations, display);




% im1 = imread('Seq/MotionTaxi/MotionTaxi11.jpg');
% im2 = imread('Seq/MotionTaxi/MotionTaxi12.jpg');
% 
% numLevels = 3;
% windowSize = 7;
% iterations = 2;
% display = 1;
% 
% %function [u,v,cert] = HierarchicalLK(im1, im2, numLevels, windowSize, iterations, display)
% 
% tic;
% [u, v, cert] = HierarchicalLK(im1, im2, numLevels, windowSize, iterations, display);
% toc;

% im1 = imread('pepsi0.pgm');
% im2 = imread('pepsi1.pgm');
% 
% alpha = 3;
% 
% [u, v] = HS(im1, im2, alpha);



im1 = imread('MotionTaxi11.jpg');
im2 = imread('MotionTaxi12.jpg');

windowSize = 7;
%function [u, v] = LucasKanade(im1, im2, windowSize)
tic;
[u, v] = LucasKanade(im1, im2, windowSize);
toc;





