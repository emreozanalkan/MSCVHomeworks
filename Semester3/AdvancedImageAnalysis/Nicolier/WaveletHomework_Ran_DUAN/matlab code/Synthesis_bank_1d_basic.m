% wavelet homework function
% two channels synthesis bank of filter bank
% Ran DUAN 16-01-2015
function s = Synthesis_bank_1d_basic(c,d,h)

% upsampling
s1 = zeros(1,2*length(c));
s1(1:2:length(s1))=c;
s2 = zeros(1,2*length(d));
s2(1:2:length(s2))=d;

% g=h.*power(-1*ones(1,length(h)),(0:length(h)-1));
for n=1:length(h),
   g(n)=h(n)*(-1)^(n);
end;
g=g(length(g):-1:1);
% filtering
% s3 = filter(h,1,fliplr(s1));
% s4 = filter(g,1,fliplr(s2));
s3 = pconv(h,fliplr(s1));
s4 = pconv(g,fliplr(s2));

s = fliplr(s3 + s4);

end