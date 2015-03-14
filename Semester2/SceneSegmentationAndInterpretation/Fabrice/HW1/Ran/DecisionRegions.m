function [regions,error] = DecisionRegions(class1,class2,p1,p2,choice)
    error = 0;
    if(strcmp(choice,'MAP'))
        for i = 1:length(class1)
            if(class1(i)*p1 > class2(i)*p2)
                regions(i) = 1;
                error = error + class2(i)*p2;
            elseif(class1(i)*p1 < class2(i)*p2)
                regions(i) = 2;
                error = error + class1(i)*p1;
            else
                regions(i) = 0;
                error = error + class1(i)*p1;
            end
        end
    else
        for i = 1:length(class1)
            if(class1(i) > class2(i))
                regions(i) = 1;
                error = error + class2(i);
            elseif(class1(i) < class2(i))
                regions(i) = 2;
                error = error + class1(i);
            else
                regions(i) = 0;
                error = error + class1(i);
            end
        end
    end
end