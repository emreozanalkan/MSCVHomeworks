function [ q ] = sense(p, z, pHit, pMiss, world)

[m, n] = size(p);

q = ones(m, n);

for ii = 1 : m
    
    for jj = 1 : n
        
        if strcmp(world(ii, jj), z)
            q(ii, jj) = pHit * p(ii, jj);
        else
            q(ii, jj) = pMiss * p(ii, jj);
        end
        
    end
    
end

q = q / sum(q(:));

end


% function [q] = sense(p, z, pHit, pMiss, world)
% %SENSE Returns the posterior distribution q given the
% %   prior distribution p and the measurement z
% 
% n = numel(p);
% 
% q = zeros(1, n);
% 
% for ii = 1 : n
%     
%     if strcmp(world{ii}, z)
%         q(ii) = pHit * p(ii);
%     else
%         q(ii) = pMiss * p(ii);
%     end
%     
% end
% 
% q = q / sum(q);
% 
% end
% 
