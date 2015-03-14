function [ q ] = move(p, u, pCorrect, pOvershooting, pUndershooting)
%MOVE Returns a new distribution q given input distribution
%   p and the control input u (here u is the number of motions to the right
% NOTE: if u = 0; q = p
%       if u = 1; q = p // shifted to the right
%       if u = -1; q = p // shifted to the left

qCorrect = pCorrect * circshift(p, u);

qOvershooting = pOvershooting * circshift(p, u + 1);

qUndershooting = pUndershooting * circshift(p, u - 1);

q = qCorrect + qOvershooting + qUndershooting;

end


% function [ q ] = move( p, u )
% %MOVE Returns a new distribution q given input distribution
% %   p and the control input u (here u is the number of motions to the right
% % NOTE: if u = 0; q = p
% %       if u = 1; q = p // shifted to the right
% %       if u = -1; q = p // shifted to the left
% 
% q = circshift(p', u);
% 
% q = q';
% 
% end
% 
