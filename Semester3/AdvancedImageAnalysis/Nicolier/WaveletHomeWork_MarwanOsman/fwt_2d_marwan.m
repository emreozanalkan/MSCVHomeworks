function [ output ] = fwt_2d_marwan(mode, input, nlevel, h )
% Forward and Inverse Filter Wavelet Transfrom on 2D images
% mode : 0 for forward / 1 for inverse
% input: input image / input coefficients
% nlevel: number of levels for the wavelet transform
% h: Analysis low pass filter

% construction of high pass filter
for n=0:length(h)-1,
   g(n+1)=h(n+1)*(-1)^(n+1);
end;
g=g(length(g):-1:1);

% initialize some variables
N = size(input,1);
output = zeros(N,N);
temp = zeros(N,N);

if (mode == 0)
  % FWT 1D on each row
  for ii=1:N  
    % low pass filtering
    sph=pconv(h,input(ii,:));
    sc1=sph(1:2:length(sph)); % downsampling

    % high pass filtering 
    spg=pconv(g,input(ii,:));
    sd1=spg(1:2:length(spg));

    % row temporary output of level nlevel
    temp(ii,:) = [sc1, sd1];
  end;

  % FWT 1D on each column
  for jj=1:N  
    % low pass filtering
    sph=pconv(h,temp(:,jj)');
    sc1=sph(1:2:length(sph)); % downsampling

    % high pass filtering 
    spg=pconv(g,temp(:,jj)');
    sd1=spg(1:2:length(spg));

    % output of level nlevel
    output(:,jj) = [sc1, sd1];
  end;

  % Recursive call to the wavelet transform for deeper levels
  if(nlevel > 1)
    output(1:N/2,1:N/2) = fwt_2d_marwan(mode, output(1:N/2,1:N/2), nlevel-1, h );
  end
   
elseif (mode == 1)
  
  % Recursive call to the inverse wavelet transform for deeper levels
  if(nlevel > 1)
    input(1:N/2,1:N/2) = fwt_2d_marwan(mode, input(1:N/2,1:N/2), nlevel-1, h );
  end;
  
  % Inverse FWT 1D on each column
  for jj=1:N
    % upsampling
    sc1 = input(1:N/2,jj);
    sc11=zeros(1,2*length(sc1));
    sc11(1:2:length(sc11))=sc1;

    sd1 = input((N/2)+1:N,jj);
    sd11=zeros(1,2*length(sd1));
    sd11(1:2:length(sd11))=sd1;

    % low pass filter
    sc2 = pconv(h,fliplr(sc11));

    % hig pass filter
    sd2 = pconv(g,fliplr(sd11));

    % column temporary reconstruction of level nlevel
    temp(:,jj) = fliplr(sd2 + sc2);
  end;
  
  % Inverse FWT 1D on each row
  for ii=1:N  
    % upsampling
    sc1 = temp(ii,1:N/2);
    sc11=zeros(1,2*length(sc1));
    sc11(1:2:length(sc11))=sc1;

    sd1 = temp(ii,(N/2)+1:N);
    sd11=zeros(1,2*length(sd1));
    sd11(1:2:length(sd11))=sd1;

    % low pass filter
    sc2 = pconv(h,fliplr(sc11));

    % hig pass filter
    sd2 = pconv(g,fliplr(sd11));

    % reconstruction of level nlevel
    output(ii,:) = fliplr(sd2 + sc2);
  end
 
end
end

