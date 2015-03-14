% Testing cameraman
img1 = double(imread('cameraman.tif'))/255; % camerana.tif

folderName = 'out2';

mkdir(folderName);

% Adding some noise
img1 = img1 + 0.03 * randn(size(img1));
img2 = img2 + 0.03 * randn(size(img2));
img1(img1 < 0) = 0; 
img1(img1 > 1) = 1;
img2(img2 < 0) = 0;
img2(img2 > 1) = 1;

% Bilateral filter parameters.
w     = 5;       % bilateral filter half-width
sigma = [3 0.1]; % bilateral filter standard deviations

% To output results for my report
for wa = [3 5 7 9]
    for sq = [[2 0.4];[5 0.4];[8 0.4]]'
        w = wa;
        sigma = sq';
        bflt_img1 = bfilter2(img1, w, sigma);
        figure;
        imshow(bflt_img1);
        title(['Result of Bilateral Filtering with w = ' num2str(w) ' and \sigma = ' num2str(sigma(1))] );
        drawnow;
        %print('-dpng', '-r0', ['out3\w' num2str(w) 's' num2str(sigma(1))]);
        print('-dpng', '-r0', [folderName '\w' num2str(w) 's' num2str(sigma(1))]);
    end
end
