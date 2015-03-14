%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VISUAL TRACKING
% ----------------------
% Background Subtraction
% ----------------
% Date: MSCV 3 - september 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;
java.lang.System.runFinalization();
java.lang.System.gc();


%%%%% LOAD THE IMAGES
%=======================

% Give image directory and extension
imPath = 'car'; imExt = 'jpg';

% check if directory and files exist
if isdir(imPath) == 0
    error('USER ERROR : The image directory does not exist');
end

filearray = dir([imPath filesep '*.' imExt]); % get all files in the directory
NumImages = size(filearray,1); % get the number of images
if NumImages < 0
    error('No image in the directory');
end

disp('Loading image files from the video sequence, please be patient...');
% Get image parameters
imgname = [imPath filesep filearray(1).name]; % get image name
I = imread(imgname);
VIDEO_WIDTH = size(I,2);
VIDEO_HEIGHT = size(I,1);

ImSeq = zeros(VIDEO_HEIGHT, VIDEO_WIDTH, NumImages);
for i=1:NumImages
    imgname = [imPath filesep filearray(i).name]; % get image name
    ImSeq(:,:,i) = imread(imgname); % load image
end
disp(' ... OK!');


%%%%% INITIALIZE THE TRACKER : BACKGROUND SUBTRACTION
%=======================

%% 2.1 Frame differencing
% N = 10; % Use # of previous frames
% alpha = 0.05; % Learning Rate
% T = 50; % Threshold
% 
% B = ImSeq(:, :, 1);
% 
% for ii = 2 : NumImages
%     
%     I = ImSeq(:, :, ii);
%     
%     % B = median(ImSeq(:, :, ((ii - N) : (ii - 1))), 3); % current background
%     
%     D = abs(I - B); % D = imabsdiff(I, B);
%     
%     Ob = D > T;
%     
%     ImSeqTemp = ImSeq(:, :, ii);
%     
%     B(Ob) = alpha * ImSeqTemp(Ob) + (1 - alpha) * B(Ob);
%     
%     B(~Ob) = I(~Ob);
%     
%     Ob2 = bwareaopen(Ob, 50, 8);
%     Ob3 = bwmorph(Ob2, 'dilate');
%     Ob4 = imfill(Ob3, 'holes');
%     Ob5 = bwmorph(Ob4, 'erode', 2);
%     
%     boundingBox  = regionprops(Ob5, 'BoundingBox');
%     
%     imshowpair(I, Ob5, 'montage');
%     
%     if ~isempty(boundingBox)
%         rectangle('Position', boundingBox(1).BoundingBox, 'EdgeColor','r', 'LineWidth', 2);
%     end
% 
%     % imshowpair(Ob, B, 'montage');
%     
%      drawnow;
%     
% end

%% 2.1.v2 Frame differencing
% % Morph operations are changed
% N = 10; % Use # of previous frames
% alpha = 0.1; % Learning Rate
% T = 50; % Threshold
% 
% B = ImSeq(:, :, 1);
% 
% for ii = 1 : 470 % NumImages
%     
%     I = ImSeq(:, :, ii);
%     
%     % B = median(ImSeq(:, :, ((ii - N) : (ii - 1))), 3); % current background
%     
%     D = abs(I - B); % D = imabsdiff(I, B);
%     
%     Ob = D > T;
%     
%     ImSeqTemp = ImSeq(:, :, ii);
%     
%     B(Ob) = alpha * ImSeqTemp(Ob) + (1 - alpha) * B(Ob);
%     
%     B(~Ob) = I(~Ob);
%     
%     ObFiltered = Ob;
%     
%     ObFiltered = bwmorph(ObFiltered, 'bridge', 'Inf');
%     ObFiltered = imfill(ObFiltered, 'holes');
%     ObFiltered = bwmorph(ObFiltered, 'bridge', 'Inf');
%     ObFiltered = bwareaopen(ObFiltered, 8, 8);
%     ObFiltered = bwmorph(ObFiltered, 'dilate', 1);
%     ObFiltered = medfilt2(ObFiltered, [9 9]);
%     ObFiltered = imfill(ObFiltered, 'holes');
%     ObFiltered = bwmorph(ObFiltered, 'bridge', 'Inf');
%     ObFiltered = bwmorph(ObFiltered, 'erode', 1);
%     
%     boundingBox  = regionprops(ObFiltered, 'BoundingBox');
%     
%     imshowpair(I, ObFiltered, 'montage');
%     
%     if ~isempty(boundingBox)
%         for bb = 1 : numel(boundingBox)
%             if boundingBox(bb).BoundingBox(3) < 20 || boundingBox(bb).BoundingBox(4) < 20
%                 continue;
%             end
%             if (boundingBox(bb).BoundingBox(3) / boundingBox(bb).BoundingBox(4)) > 3
%                 continue;
%             end
%             rectangle('Position', boundingBox(bb).BoundingBox, 'EdgeColor','r', 'LineWidth', 2);
%         end
%     end
% 
%     % imshowpair(Ob, B, 'montage');
%     
%      drawnow;
%     
% end



%% 2.2 Running average Gaussian

% mean_image = ImSeq(:, :, 1);
% 
% sigma_image = 2 .* ones(size(ImSeq(:, :, 1))); % initialize sigma to 2 for all pixels
% 
% threshold = 3; % 2.5
% 
% alpha = 0.02; % 0.01
% 
% for ii = 2 : NumImages
%     
%     I = ImSeq(:, :, ii); % get current image
%     
%     % update the mean image
%     mean_image = alpha * I + (1 - alpha) * mean_image;
%     
%     % update the sigma image
%     d = abs(I - mean_image); 
%     
%     sigma_image = alpha * d.^2 + (1 - alpha) * sigma_image;
%     
%     % detect foreground
%     foreground = d > threshold * sqrt(sigma_image);
%     
%     
%     
%     foreground = medfilt2(foreground, [5 5]);
%     foreground = bwareaopen(foreground, 20, 8);
%     
%     
%     
%     %foreground = imfill(foreground, 'holes');
%     
%     %se = strel('line', 5, 45);
%     %foreground = imerode(foreground, se);
%     
%     %foreground = imfill(foreground, 'holes');
%     %foreground = bwmorph(foreground, 'remove');
%     %foreground = bwmorph(foreground,'skel',Inf);
%     %foreground = imerode(foreground, ones(1, 1, 5));
%     %foreground = bwmorph(foreground, 'dilate');
%     %foreground = bwmorph(foreground, 'erode');
%     %foreground = bwmorph(foreground, 'remove', 'Inf');
%     %foreground = bwmorph(foreground, 'fill', 'Inf');
%     %foreground = bwmorph(foreground, 'bridge', 'Inf');
%     
%     boundingBox  = regionprops(foreground, 'BoundingBox');
%     
%     imshowpair(I, foreground, 'montage');
%     
%     if ~isempty(boundingBox)
%         rectangle('Position', boundingBox(1).BoundingBox, 'EdgeColor','r', 'LineWidth', 2);
%     end
%     
% %     subplot(121), imshow(I, []);
% %     subplot(122), imshow(foreground, []);
%     
%     %pause(0.01);
%     
%     drawnow;
%     
% end




%% % 2.3 Mixture of Gaussians
% % % http://www.ai.mit.edu/projects/vsam/Publications/stauffer_cvpr98_track.pdf
% % % http://areshmatlab.blogspot.fr/2010/05/high-complexity-background-subtraction.html
% % % http://www.sagoforest.com/sagoaleph/papers/GaussianMixtureModels.pdf
% % % http://en.wikipedia.org/wiki/Mixture_model#Gaussian_mixture_model
% % % http://www.moivre.usherbrooke.ca/sites/default/files/108.pdf
% % % http://profs.sci.univr.it/~cristanm/teaching/sar_files/lezione4/Piccardi.pdf
% % % http://www.cs.utexas.edu/~grauman/courses/fall2009/slides/lecture9_background.pdf
% % % http://www.cse.iitk.ac.in/users/vision/tarunb/node6.html
% % % https://www.ll.mit.edu/mission/communications/ist/publications/0802_Reynolds_Biometrics-GMM.pdf
% fr = ImSeq(:, :, 1);
% fr_size = size(fr);
% width = fr_size(2);
% height = fr_size(1);
% 
% K = 3; % Numer of Gaussian distributions - generally 3 to 5
% 
% M = 1; % 1 because gray - number of background components
% 
% D = 2.5; % positive deviation threshold
% 
% alpha = 0.01; % Learning rate between 0 and 1
% 
% thresh = 0.1;
% 
% sd_init = 6; % initial standart deviation
% 
% w = zeros(height, width, K); % initialize Weights array
% mean = zeros(height, width, K); % pixel means
% sd = zeros(height, width, K); % pixel standart deviations
% u_diff = zeros(height, width, K); % diference of each pixel from mean
% p = alpha / (1 / K); % initial p variable (used to update mean and sd)
% rank = zeros(1, K); % rank of components (w / sd)
% 
% foreground = zeros(height, width);
% background = zeros(height, width);
% 
% 
% 
% % Inits
% mean = 255 * rand(height, width, K);
% w = (1 / K) * ones(height, width, K);
% sd = sd_init * ones(height, width, K);
% 
% figure('name', 'Mixture of Gaussians', 'units', 'normalized', 'outerposition', [0 0 1 1]);
% 
% % Process
% for kk = 1 :  NumImages
%     
%     im = ImSeq(:, :, kk);
%     
%     u_diff(:, :, :) = abs(repmat(im, [1 1 3]) - double(mean(:, :, :)));
%     
%     % update gaussian components for each pixel
%     for ii = 1 : height
%         
%         for jj = 1 : width
%             
%             match = 0;
%             
%             for nn = 1 : K
%                 
%                 if abs(u_diff(ii, jj, nn)) <= D * sd(ii, jj, nn) % pixel matches gaussian component
%                     
%                     match = 1; % n.th distribution matched
%                     
%                     % update weights, mean, sd, p
%                     w(ii, jj, nn) = (1 - alpha) * w(ii, jj, nn) + alpha;
%                     
%                     p = alpha / w(ii, jj, nn);
%                     
%                     mean(ii, jj, nn) = (1 - p) * mean(ii, jj, nn) + p * double(im(ii, jj));
%                     
%                     sd(ii, jj, nn) = sqrt((1 - p) * (sd(ii, jj, nn) ^ 2) + p * ((double(im(ii, jj)) - mean(ii, jj, nn))) ^ 2);
%                     
%                 else
%                     
%                     w(ii, jj, nn) = (1 - alpha) * w(ii, jj, nn); % weight slighly decreases
%                     
%                 end
%                 
%             end
%             
%             w(ii, jj, :) = w(ii, jj, :) ./ sum(w(ii, jj, :));
%             
%             background(ii, jj) = 0;
%             
% %             for nn = 1 : K
% %                
% %                 background(ii, jj) = background(ii, jj) + mean(ii, jj, nn) * w(ii, jj, nn);
% %                 
% %             end
%             background(ii, jj) = background(ii, jj) + sum(mean(ii, jj, :) .* w(ii, jj, :));
%             
%             % if no components match, create new component
%             if (match == 0)
%                 [min_w, min_w_index] = min(w(ii, jj, :));
%                 mean(ii, jj, min_w_index) = double(im(ii, jj));
%                 sd(ii, jj, min_w_index) = sd_init;
%             end
%             
%             rank = w(ii, jj, :) ./ sd(ii, jj, :); % calculate component rank
%             rank_ind = 1:1:K;
%             
%             % sort rank values
%             for k = 2 : K
%                 
%                 for m = 1 : (k - 1)
%                     
%                     if (rank(:, :, k) > rank(:, :, m))
%                         % swap max values
%                         rank_temp = rank(:, :, m);
%                         rank(:, :, m) = rank(:, :, k);
%                         rank(:, :, k) = rank_temp;
%                         
%                         % swap max index values
%                         rank_ind_temp = rank_ind(m);
%                         rank_ind(m) = rank_ind(k);
%                         rank_ind(k) = rank_ind_temp;
%                         
%                     end
%                     
%                 end
%                 
%             end
% 
% % % sortrows looks more slower then the for loop above :/
% %             [rank, rank_ind] = sortrows(squeeze(rank), -1);
% %             rank_ind = rank_ind';
%             
%             
%             % calculate foreground
%             match = 0;
%             
%             k = 1;
%             
%             foreground(ii, jj) = 0;
%             
%             while (match == 0) && (k <= K)
%                 
%                 if w(ii, jj, rank_ind(k)) >= thresh
%                     
%                     if abs(u_diff(ii, jj, rank_ind(k))) <= D * sd(ii, jj, rank_ind(k))
%                         
%                         foreground(ii, jj) = 0;
%                         
%                         match = 1;
%                         
%                     else
%                         
%                         foreground(ii, jj) = im(ii, jj); 
%                         
%                     end
%                     
%                 end
%                 
%                 k = k + 1;
%                 
%             end
%             
%         end
%         
%     end
%     
%     
%     %subplot(1, 3, 1); imshow(im, []);
%     %subplot(1, 3, 2); imshow(uint8(background), []);
%     %subplot(1, 3, 3); imshow(uint8(foreground), []);
%     
%     %drawnow;
%     
%     foregroundFiltered = bwareaopen(foreground, 100, 8);
%     se = strel('disk', 13);
%     foregroundFiltered = imdilate(foregroundFiltered, se);
%     foregroundFiltered = bwmorph(foregroundFiltered, 'bridge', 'Inf');
%     
%     foregroundFiltered = medfilt2(foregroundFiltered, [5 5]);
%     
%     foregroundFiltered = imfill(foregroundFiltered, 'holes');
%     
%     foregroundFiltered = bwmorph(foregroundFiltered, 'erode', 5);
%     
%     foregroundFiltered = bwmorph(foregroundFiltered, 'remove');
%     
%     %foreground = bwmorph(foreground,'skel', Inf);
%     
%     
%     boundingBox  = regionprops(foregroundFiltered, 'BoundingBox');
%     
%     
%     subplot(2, 2, 1); imshow(im, []); title('Raw Image');
%     
%     if ~isempty(boundingBox)
%         for bb = 1 : numel(boundingBox)
%             rectangle('Position', boundingBox(bb).BoundingBox, 'EdgeColor','r', 'LineWidth', 2);
%         end
%     end
%     
%     subplot(2, 2, 2); imshow(foreground); title('Foreground');
%     subplot(2, 2, 3); imshow(foregroundFiltered); title('Foreground Filtered');
%     subplot(2, 2, 4); imshow(background, []); title('Background');
%     
%     drawnow;
%    
%     display(kk);
% end





%% 2.4 Eigen Background
% % % http://hal.archives-ouvertes.fr/docs/00/54/54/78/PDF/JEI.pdf
% 
% %figure('name', 'Eigen Background', 'units', 'normalized', 'outerposition', [0 0 1 1]);
% 
% k = floor(NumImages / 16);
% 
% T = 50;
% 
% [imageHeight, imageWidth] = size(ImSeq(:, :, 1));
% 
% X = zeros(imageHeight * imageWidth, NumImages);
% 
% for ii = 1 : NumImages
%     
%     image = ImSeq(:, :, ii);
%     
%     image = image(:);
%     
%     X(:, ii) = image;
%     
% end
% 
% meanImage = sum(X, 2) / NumImages;
% 
% Xhat = X - repmat(meanImage, [1 NumImages]);
% 
% [U, S, V] = svd(Xhat, 'econ');
% 
% Uk = U(:, 1:k);
% 
% 
% for ii = 1 : NumImages
%     
%     y = ImSeq(:, :, ii);
%     
%     y = y(:);
%     
%     p = Uk' * (y - meanImage);
%     
%     yHat = Uk * p + meanImage;
%     
%     foreground = abs(yHat - y) > T;
%     
%     foregroundImage = reshape(foreground, [imageHeight, imageWidth]);
%     
%     foregroundImage = bwareaopen(foregroundImage, 16, 8);
%     
%     foregroundImage = bwmorph(foregroundImage, 'bridge', 'Inf');
%     
%     %foregroundImage = bwmorph(foregroundImage, 'dilate', 5);
%     se = strel('disk', 7);
%     foregroundImage = imdilate(foregroundImage, se);
%     
%     foregroundImage = medfilt2(foregroundImage, [9 9]);
%     
%     foregroundImage = imfill(foregroundImage, 'holes');
%     
%     foregroundImage = bwmorph(foregroundImage, 'erode', 5);
%     
%     %foregroundImage = bwmorph(foregroundImage,'skel', Inf);
%     %foregroundImage = bwmorph(foregroundImage, 'remove');
%     
%     boundingBox  = regionprops(foregroundImage, 'BoundingBox');
%     
%     imshowpair(ImSeq(:, :, ii), foregroundImage, 'montage');
%     title('Eigen Background Substraction');
%     
%     if ~isempty(boundingBox)
%         for bb = 1 : numel(boundingBox)
%             rectangle('Position', boundingBox(bb).BoundingBox, 'EdgeColor','r', 'LineWidth', 2);
%         end
%     end
%     
%     drawnow;
%     
% end





















%% HERE YOU HAVE TO INITIALIZE YOUR TRACKER WITH THE POSITION OF THE OBJECT IN THE FIRST FRAME

% DESCRIBE HERE YOUR BACKGROUND SUBTRACTION METHOD !
disp('Performing Background Subtraction...');






disp(' ... OK!');

% DEFINE A BOUNDING BOX AROUND THE OBTAINED REGION : this gives the initial state

% Get ROI Parameters
%ROI_Center = ; 
%ROI_Width = ;
%ROI_Height = ;

% you can draw the bounding box and show it on the image


