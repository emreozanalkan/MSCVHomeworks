function [ goldenSectionSearchResult ] = GoldenSectionSearch2( f, a, b, tol )
%GOLDENSECTIONSEARCH2 Summary of this function goes here
% References
% http://linneus20.ethz.ch:8080/1_5_2.html
% https://en.wikipedia.org/wiki/Golden_section_search
% http://homepages.math.uic.edu/~jan/mcs471/Lec9/gss.pdf
% http://caig.cs.nctu.edu.tw/course/NM07S/slides/chap7_1.pdf
% http://www.aip.de/groups/soe/local/numres/bookcpdf/c10-1.pdf
% http://www.essie.ufl.edu/~kgurl/Classes/Lect3421/NM6_optim_s02.pdf
% http://ezekiel.vancouver.wsu.edu/~cs330/lectures/minimization/gold/gold.c
% http://mathforcollege.com/nm/mws/gen/09opt/mws_gen_opt_txt_goldensearch.pdf
% http://ezekiel.vancouver.wsu.edu/~cs330/lectures/minimization/gold/class/gold.c
% http://ezekiel.vancouver.wsu.edu/~cs330/lectures/minimization/gold/golden-search.pdf

tau = 2.0 - ((1.0 + sqrt(5)) / 2.0); % 0.381966011250105

c = (a + b) / 2.0; % mid point

x = 0.0;

if(b - c > c - a)
    x = c + (tau * (b - c));
else
    x = c - (tau * (c - a));
end


while(abs(b - a) > tol * (abs(c) + abs(x)))
    if(feval(f, x) < feval(f, c))
        if(b - c > c - a)
            % new interval becomes (a, c, b) to => (c, x, b)
            a = c;
            c = x;
        else
            % new interval becomes (a, c, b) to => (a, x, c)
            b = c;
            c = x;
        end
    else
        if(b - c > c - a)
            % new interval becomes (a, c, b) to => (a, c, x)
            b = x;
        else
            % new interval becomes (a, c, b) to => (x, c, b)
            a = x;
        end
    end
    
    c = (a + b) / 2.0;
    
    if(b - c > c - a)
        x = c + (tau * (b - c));
    else
        x = c - (tau * (c - a));
    end
    
end

goldenSectionSearchResult = (c + a) / 2.0;

end

