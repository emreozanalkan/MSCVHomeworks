function x=rpadd(R,K)
% rpadd is to To remove padding
% R     = input matrix 
% K     = (2*K + 1) is the window size
% x     = output
for i=1:K
    R(1,:)=[];
    R(:,1)=[];
    [ro cl]= size(R);
    R(ro,:)=[];
    R(:,cl)=[];;
end
x=R;