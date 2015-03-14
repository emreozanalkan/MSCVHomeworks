function[out]=brent(f,a,b,c)
% We get help from one of the seniors for some part of the algortihm
%f=@(x) -exp(-(x.^2))+exp(-(x+1).^2);

fa=f(a);
fb=f(b);
fc=f(c);
for i=1:100
coeff=[a^2 a 1;b^2 b 1;c^2 c 1];
fmat=[fa;fb;fc];
coefbyf=coeff/fmat';
n=(((b-a)^2)*(fb-fc))-(((b-c)^2)*(fb-fa));
d=((b-a)*(fb-fc))-((b-c)-(fb-fa));
x=b-(0.5*(n/d)); 
fx= (coefbyf(1)*(x^2)) + (coefbyf(2)*x) +coefbyf(3);
if x>c 
    if fa > fc && fx > fc %axc
                b=x;
                fb=fx;
            else 
                a=c;
                fa=fc;
    end
else
    if fa > fx && fc > fx 
                b=c;
                fb=fc;
            else 
                a=x;
                fa=fx;
    end
end
r=rand(1);
c= a + r*(b-a);
fc=f(c);   
end
out=fx;