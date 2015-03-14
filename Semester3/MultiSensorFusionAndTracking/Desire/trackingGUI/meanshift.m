% Adam Kukucka
% Zach Clay
% Marcelo Molina    
% CSE 486 Project 3

function [ rowcenter colcenter M00 ] = meanshift(rmin, rmax, cmin,...
    cmax, probmap)
%inputs
%   rmin, rmax, cmin, cmax are the coordiantes of the window
%   I is the image
%outputs
%   colcenter rowcenter are the new center coordinates
%   Moo is the zeroth mean

% **********************************************************************
% initialize
% **********************************************************************

M00 = 0; %zeroth mean
M10 = 0; %first moment for x
M01 = 0; %first moment for y

% **********************************************************************
% Main code
% **********************************************************************


% determine zeroth moment
for c = cmin:cmax
    for r = rmin:rmax
        M00 = M00 + probmap(r, c);
    end
end

% determine first moment for x(col) and y(row)
for c = cmin:cmax
    for r = rmin:rmax
        M10 = M10 + c*probmap(r,c);
        M01 = M01 + r*probmap(r,c);
    end
end

% determine new centroid
% x is cols
    colcenter = M10/M00;

% y is rows
    rowcenter = M01/M00;



