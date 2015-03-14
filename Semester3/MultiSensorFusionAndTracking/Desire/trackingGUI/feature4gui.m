function [ outMv ] = feature4gui(Mv, handles)


M =Mv;

% get number of frames
[dontneed numberofframes] = size(M);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% interlaced = 0;     % Set to 1, if images are interlaced
bPlot = 1;          % Set to 1 to get graphical output
% FigureNumber = 1;   % output figure number
bMovieout = 1;      % Can be used only if bPlot activated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global resolution winx winy saturation ...
    wintx winty spacing boundary boundary_t ...
    Nmax thresh levelmin levelmax ThreshQ ...
    N_max_feat method;

resolution = 0.03; 			% Required resolution (for the track, in pixel)
winx = 1; winy = 1;         % Selection window sizes (size =2*winx+1 x 2*winy+1
saturation = 7000; 			% saturation in Q for selection (win=1)
wintx = 4; winty = 4; 		% Tracking window sizes
spacing = 5;				% min spacing between 2 feats (in pixel).
boundary = 5;				% rejected pixels around the screen (selection)
boundary_t = 1;				% rejected pixels around the screen (tracking)
Nmax = 1000;                % max. selected features in selection
thresh = 0.05; 				% Threshold of selection
levelmin = 0; 				% lower level in the pyramid
levelmax = 2;				% higher level in the pyramid
ThreshQ = 0.1;				% Thresh of ejection of a point
% through the track
N_max_feat = 500;			% Minimum space reserved for the
% feature storage
method = 0;                 % Set to 1 to take into consideration
                            % the saturation (used in selection
                            % and tracking)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

good = zeros(N_max_feat,numberofframes);
featx = zeros(N_max_feat,numberofframes);
featy = zeros(N_max_feat,numberofframes);
featq = zeros(N_max_feat,numberofframes);

%process the first image

Ipi(:,:,1) = double(M(1).cdata(:,:,1));

[nrow,ncol] = size(Ipi(:,:,1));
SampleSize(:,1) = [nrow;ncol];

set(handles.note,'String','Feature selection on initial image');

%select feature point from Ipi
%only on the grid points
xtt = SelectFeature(Ipi);

Nini = size(xtt,2); 			% init # of features
if Nini < N_max_feat,
    xtt = [xtt,zeros(2,N_max_feat-Nini)];
    goodfeat = [ones(Nini,1);zeros(N_max_feat-Nini,1)];
else
    xtt = xtt(:,1:N_max_feat);
    goodfeat = ones(N_max_feat,1);
end;

%note that SampleSize is only computed once here
%therefore all the images must have the same size
for ii=1:levelmax,
    % compute downsampled images
    [tt,SampleSize(:,ii+1)] ...
        = DownSample(Ipi(:,:,ii),SampleSize(:,ii));
    Ipi(1:SampleSize(1,ii+1),1:SampleSize(2,ii+1),ii+1) = tt;
end;


Qtt = ComputeQuality(Ipi,xtt,goodfeat,wintx,winty);
%quality_computation; 		% computes the quality vector Qtt from xtt and Ipi used to test lost tracks!

good(:,1) = goodfeat;
featx(:,1) = xtt(1,:)';
featy(:,1) = xtt(2,:)';
featq(:,1) = Qtt;

axes(handles.output_fig);

image(Ipi(:,:,1));colormap(gray(256));
axis('equal'); axis([1 ncol 1 nrow]);
hold on;
xf = xtt(:,find(goodfeat));
if size(xf,1) > 0,
    plot(xf(2,:),xf(1,:), 'r+');
end;
hold off; drawnow;

set(handles.note,'String','Processing...');
%%% MAIN TRACKING LOOP - BELOW
for nbri=2:numberofframes;


    for ii = 1:levelmax+1,
        Ii(:,:,ii) = Ipi(:,:,ii);
    end;

    Qt = Qtt;
    xt = xtt;
    
    tt=double(M(nbri).cdata(:,:,1));
    Ipi(:,:,1) = tt;

    % Downsampling images
    for ii = 1:levelmax,
        Ipi(1:SampleSize(1,ii+1),1:SampleSize(2,ii+1),ii+1) ...
            = DownSample(Ipi(:,:,ii),SampleSize(:,ii));
    end;

    %track between image Ii and Ipi
    %also their downsampled versions
    %results are in xtt Qtt goodfeat
    [xttnew,Qtt,goodfeat] = TKTrack(Ii,Ipi,SampleSize,xtt,goodfeat);

    good(:,nbri) = goodfeat;
    featx(:,nbri) = xttnew(1,:)';
    featy(:,nbri) = xttnew(2,:)';
    featq(:,nbri) = Qtt;

    xtt = xttnew;

    %%%%%%%%%%%%%%%%%

    fprintf(1, 'After track #%d: %d features\n',nbri-1, size(find(goodfeat),1));
   
    %visualization

    axes(handles.output_fig);

    image(Ipi(:,:,1)); colormap(gray(256));
    axis('equal'); axis([1 ncol 1 nrow]);
    hold on;
    xf = xtt(:,find(goodfeat));
    if size(xf,1) > 0,
        plot(xf(2,:),xf(1,:), 'r+');
        ind_tracked = find(good(:,nbri-1) & good(:,nbri));
        if ~isempty(ind_tracked),
            plot([featy(ind_tracked,nbri-1),featy(ind_tracked,nbri)]',[featx(ind_tracked,nbri-1),featx(ind_tracked,nbri)]', 'y-');
        end;
    end;
    hold off; drawnow;

    outMv(:,nbri-1) = getframe;

end;
%%% MAIN TRACKING LOOP - ABOVE9
 set(handles.note,'String','Process done!');


