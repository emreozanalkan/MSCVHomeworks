function [boundaries] = FindBoundary(mu1,sigma1,mu2,sigma2,start,stop)
    runflag = 1;
    x = start;
    while(runflag)
        y1 = 1/(sigma1*sqrt(2*pi))*exp(-(x-mu1)^2/(2*sigma1^2));
        y2 = 1/(sigma2*sqrt(2*pi))*exp(-(x-mu2)^2/(2*sigma2^2));
        x = x + 0.000001;
        if(abs(y1 - y2) < 0.00001)
            runflag = 0;
            boundaries = x;
        end
        if x > stop
            boundaries = NaN;
        end
    end
end