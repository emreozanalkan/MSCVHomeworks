close all;
clear all;
clc;

worldWidth = 10;
worldHeight = 10;

world = [ 'r', 'g', 'g', 'r', 'r', 'r', 'g', 'g', 'r', 'r';
          'r', 'r', 'g', 'r', 'r', 'r', 'r', 'g', 'r', 'r';
          'r', 'r', 'g', 'g', 'r', 'r', 'r', 'g', 'g', 'r';
          'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r';
          'g', 'g', 'g', 'g', 'g', 'g', 'g', 'g', 'g', 'g';
          'r', 'g', 'g', 'r', 'r', 'r', 'g', 'g', 'r', 'r';
          'r', 'r', 'g', 'r', 'r', 'r', 'r', 'g', 'r', 'r';
          'r', 'r', 'g', 'g', 'r', 'r', 'r', 'g', 'g', 'r';
          'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r';
          'g', 'g', 'g', 'g', 'g', 'g', 'g', 'g', 'g', 'g'];

worldProbabilty = ones(worldWidth, worldHeight) ./ (worldWidth * worldHeight);
imagesc(worldProbabilty); title('Prior Probability of World');

z = ['g', 'g', 'g', 'r', 'g', 'r', 'r', 'r', 'g', 'r'];

pHit = 0.7;
pMiss = 0.3;

pMove = 0.8;
pUndershoot = 0.1;
pOvershoot = 0.1;

u = [[0 1];
     [1 0];
     [0 1];
     [1 0];
     [1 0];
     [0 1];
     [0 1];
     [1 0];
     [1 0];
     [0 1]];
 
 
pathCount = numel(z);

for ii = 1 : pathCount
    
    worldProbabilty = sense(worldProbabilty, z(ii), pHit, pMiss, world);
    
    worldProbabilty = move(worldProbabilty, u(ii, :), pMove, pOvershoot, pUndershoot);
    
end

pause(2);

imagesc(worldProbabilty); title('Posterior Probability of World');

% %
% clear all; close all; clc;
% n = 5;
% 
% p = [1/5; 1/5; 1/5; 1/5; 1/5];
% 
% world = {'green'; 'red'; 'red'; 'green'; 'green'};
% 
% 
% pHit = 0.6; % correct measurement
% pMiss = 0.2; % wrong measurement
% 
% 
% % % %
% % %measurement
% % z = 'red';
% % 
% % p = sense(p, z, pHit, pMiss, world);
% % 
% % display(p);
% 
% % %
% % Question 4
% % Now we have multiple measurements z = red and green which means the robot
% % first senses red then green
% 
% p = [1/5; 1/5; 1/5; 1/5; 1/5];
% 
% z = {'red'; 'green'};
% 
% u = [1; 1];
% 
% zN = numel(z);
% 
% for ii = 1 : zN
%     p = sense(p, z{ii}, pHit, pMiss, world);
%     display(p);
%     p = move(p, u(ii));
%     display(p);
% end