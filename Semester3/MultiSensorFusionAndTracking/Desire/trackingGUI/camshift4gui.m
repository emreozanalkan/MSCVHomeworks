
function [ outMv ] = camshift4gui(Mv, handles)

% ******************************************************************
% initialize vari   ables
% ******************************************************************

rmin = 0; %min row value for search window
rmax = 0; %max row value for search window
cmin = 0; %min col value for search window
cmax = 0; %max col value for search window
numofframes = 0; %number of frames in the avi

centerold = [0 0]; %for convergence... previous center of window
centernew = [0 0]; %for convergence... new center of window

% ******************************************************************
% Pre code... load movie and select initial frame
% ******************************************************************

M =Mv;

% get number of frames
[dontneed numberofframes] = size(M);

% initialize matrix to hold center coordinates
%imagecenters = zeros(numberofframes, 2);

% extract the first frame from the avi
Frame1 = M(1,1);
Image1 = imresize(Frame1.cdata,[344 436],'bilinear');
set(handles.note,'String','Tracking: choose searching area...then wait for processing');

% get search window for first frame
[ cmin, cmax, rmin, rmax ] = select( Image1 );
cmin = round(cmin);
cmax = round(cmax);
rmin = round(rmin);
rmax = round(rmax);
wsize(1) = abs(rmax - rmin);
wsize(2) = abs(cmax - cmin);

% create histogram
% translate to hsv
% hsvimage = rgb2hsv(Image1);
% % pull out the h
% huenorm = hsvimage(:,:,1);


% huenorm=im2double(Image1(:,:,1));
% % scale to 0 to 255
% hue = huenorm*255;
% % set unit type
% hue=uint8(hue);
hue=Image1(:,:,1);

% Getting Histogram of Image:
histogram = zeros(256);

for i=rmin:rmax
    for j=cmin:cmax
        index = uint8(hue(i,j)+1);
        %count number of each pixel
        histogram(index) = histogram(index) + 1;
    end
end



% ******************************************************************
% Algorithm from pdf
% ******************************************************************

% for each frame
for i = 1:numberofframes


    Frame = M(1, i);
    I = imresize(Frame.cdata,[288 352],'bilinear');

    %     % translate to hsv
    %     hsvimage = rgb2hsv(I);
    %     % pull out the h
    %     huenorm = hsvimage(:,:,1);

    %     huenorm=im2double(I(:,:,1));
    %     % scale to 0 to 255
    %     hue = huenorm*255;
    %     % set unit type
    %     hue=uint8(hue);

    hue= I(:,:,1);
    [rows cols] = size(hue);

    % choose initial search window
    % the search window is (cmin, rmin) to (cmax, rmax)



    % create a probability map
    probmap = zeros(rows, cols);
    for r=1:rows
        for c=1:cols
            if(hue(r,c) ~= 0)
                probmap(r,c)= histogram(hue(r,c));
            end
        end
    end
    probmap = probmap/max(max(probmap));
    probmap = probmap*255;

    count = 0;

    rowcenter = 0;  % any number just so it runs through at least twice
    colcenter = 0;
    rowcenterold = 30;
    colcenterold = 30;
    % Mean Shift for 15 iterations or until convergence(the center doesnt
    % change)
    while (((abs(rowcenter - rowcenterold) > 2) && (abs(colcenter - colcenterold) > 2)) || (count < 15) )
        %for j = 1:5
        %disp('meanshift');
        % disp(j);
%                 rmin = rmin - 7;  %increase window size and check for center
%                 rmax = rmax + 7;
%                 cmin = cmin - 7;
%                 cmax = cmax + 7;

        rowcenterold = rowcenter; %save old center for convergence check
        colcenterold = colcenter;

        [ rowcenter colcenter M00 ] = meanshift(rmin, rmax, cmin,...
            cmax, probmap);
        % given image (I), search window(rmin rmax cmin cmax)
        % returns new center (colcenter, rowcenter) for window and
        % zeroth moment (Moo)

        % redetermine window around new center

        rmin = round(rowcenter - wsize(1)/2);
        if rmin<1
            rmin=1;
        end
        rmax = round(rowcenter + wsize(1)/2);
        if rmax<1
            rmax=1;
        end
        cmin = round(colcenter - wsize(2)/2);
        if cmin<1
            cmin=1;
        end
        cmax = round(colcenter + wsize(2)/2);
        if cmax<1
            cmax=1;
        end
        wsize(1) = abs(rmax - rmin);
        wsize(2) = abs(cmax - cmin);

        count = count + 1;
    end

    % mark center on image

    %save image
    G = .2989*I(:,:,1)...
        +.5870*I(:,:,2)...
        +.1140*I(:,:,3);
    trackim=G;

    %make box of current search window on saved image
    for r= rmin:rmax
        trackim(r, cmin:cmin+2) = 0;
        trackim(r, cmax-2:cmax) = 0;
    end
    for c= cmin:cmax
        trackim(rmin:rmin+2, c) = 0;
        trackim(rmax-2:rmax, c) = 0;
    end

    %create image movie, and probability map movie
    trackmov(:,:,i)= trackim(:,:);
    %probmov(:,:,i) = probmap(:,:);

    outMv(i).cdata(:,:,1)=uint8(trackmov(:,:,i));
    outMv(i).cdata(:,:,2)=uint8(trackmov(:,:,i));
    outMv(i).cdata(:,:,3)=uint8(trackmov(:,:,i));

    outMv(i).colormap=[];
    set(handles.note,'String','Processing done!');

    % save center coordinates as an x, y by doing col, row
   % centers(i,:) = [colcenter rowcenter];
    % Set window size = 2 * (Moo/256)^1/2
    windowsize = 100 * (M00/256)^.5;

    % get side length ... window size is an area so sqrt(Area)=sidelength
    sidelength = sqrt(windowsize);

    % determine rmin, rmax, cmin, cmax
    rmin = round(rowcenter-sidelength/2);
    if rmin<1
        rmin=1;
    end
    rmax = round(rowcenter+sidelength/2);
    if rmax<1
        rmax=1;
    end
    cmin = round(colcenter-sidelength/2);
    if cmin<1
        cmin=1;
    end
    cmax = round(colcenter+sidelength/2);
    if cmax<1
        cmax=1;
    end
    wsize(1) = abs(rmax - rmin);
    wsize(2) = abs(cmax - cmin);
end
% end for loop


