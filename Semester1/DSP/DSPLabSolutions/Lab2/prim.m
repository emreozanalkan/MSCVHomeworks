% primitive function F of f
function F=prim(f)

    F(1)=f(1); 
    for k=2:length(f)
        F(k) = F(k-1)+f(k)*1;% here Ts=1 (sampling period)
    end

end % function prim

