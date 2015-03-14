function  [normal_mat,d_mat] = projector(source,pattern)

% light source is a 3D point (x,y,z)
% pattern is x1,y1,z1,x2,y2,z2 * n
% where n are number of lines
normal_mat = [];
d_mat = [];
P1 = source;
% figure,
% hold on;
for i = 1:size(pattern,1)
    P2 = pattern(i,1:3);
    P3 = pattern(i,4:6);
   [normal, d] = plot_line(P1, P2, P3);
    normal_mat(i,:) = normal;
    d_mat(i,:) = d;
end

end