function [PC] = select_points(I, number_points)
% this function allows the manual selection of number_points points in
% image I.
% the coordinates of selected points are return in the matrix PC, with
% PC(i,:) containg the homegeneous coordinates of the ith point
%
% Written on March 14th, 2011
% D. Sidibe, LE2I UMR CNRS 5158

PC = ones(number_points, 3);
figure; imshow(I,[]);
for i=1:number_points
   %figure; 
   drawnow; hold on;
   [x,y] = ginput(1);
   plot(x,y,'ro');
   text_handle = text( x+5, y, num2str(i) );
   set(text_handle,'Color',[1 1 1])
   PC(i,1:2) = [x,y];
end
hold off;
