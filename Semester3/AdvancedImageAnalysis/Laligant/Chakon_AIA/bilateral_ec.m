function [output]=bilateral_ec(w,sigma_r,sigma_d,level)
image=level;
[x y]=meshgrid(-w:w,-w:w);
G=exp(-(x.^2+y.^2)/(2*sigma_d^2));
[r c]=size(image);
output=zeros(size(image));
for i=1:r
    for j=1:c
        imin=max(i-w,1);
        imax=min(i+w,r);
        jmin=max(j-w,1);
        jmax=min(j+w,c);
        I=image(imin:imax,jmin:jmax);
        H=exp(-(I-image(i,j)).^2/(2*sigma_r^2));
        F=H.*G((imin:imax)-i+w+1,(jmin:jmax)-j+w+1);
        Fnorm=sum(F(:));
        output(i,j)=sum(sum(F.*I))/Fnorm;
    end
end