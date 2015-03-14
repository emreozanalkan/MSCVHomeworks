fy = 22.76;

% Height of camera
hnot = 99.5;   %cms
tiltangle = 4;   % was 4 degress measure accordingly



upperrow = 188;
lowerrow = 916;


d0 = 552 - upperrow;
d1 = lowerrow - 552;
d0distrance = (d0*2.54)/72;
d1distrance = (d1*2.54)/72;
% lets compute alphas

alpha_not  = atand((fy/d0distrance));
alpha1 = atand((fy/d1distrance));

Height = hnot*(1 + (tand(alpha1 - tiltangle))/(tand(alpha_not + tiltangle))) 
