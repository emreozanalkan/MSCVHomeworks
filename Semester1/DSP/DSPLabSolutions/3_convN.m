% function y = convN(x, h, zeroh, border)
%  1D convolution
% parameters
%  - signal x
%  - impulse response h
%  - 0-location of the impulse response 
%     example: if h=[1 -3 2] -> zeroh = 1 (coef. 1) or 2 (-3) or 3 (2)
%  - process of the border for signal extension
%     'sym'  : symmetry, example: 10 8 7 ... => ... 7 8 10 8 7 ...
%     'T'    : periodic, example: 10 8 7 ... 5 4 => ... 5 4 10 8 7 ...
%     '0pad' : 0 padding, example: 10 8 7 ... => ... 0 0 10 8 7 ...
%     'vpad' : border-value padding, example: 10 8 7 ... => ... 10 10 10 8 7 ...
%     'vsym' : asymmetric / border-value extension 
%              example: 10 8 7 ... => ... 13 12 10 8 7 ...
%   
function y = convN(x, h, zeroh, border)

    Nh = length(h);    
    N = length(x);
    if ((zeroh <1) | (zeroh>Nh))
        disp('error zero-location in the impulse response');
        y=0;
        return;
    end
    % check length of the signal / h
    if (N < Nh-1)
        disp('signal too short !');
        y=0;
        return;
    end
    % h flipping
    hf = fliplr(h);
    zerohf = Nh-zeroh+1;
    
    % signal extension: we do not take into account the zero-location to
    %  allocate memory -> systematically the added length on each side is
    %  Nh-1
    xe(Nh:N+Nh-1) = x;
    switch lower(border)
        case {'sym'}
            xe(1:Nh-1) = fliplr(x(2:Nh));
            xe(Nh+N:Nh+N+Nh-2) = fliplr(x(N-Nh+1:N-1));
        case {'t'}
            xe(1:Nh-1) = x(N-Nh+2:N);
            xe(Nh+N:Nh+N+Nh-2) = x(1:Nh-1);
        case {'0pad'}
            xe(1:Nh-1) = 0;
            xe(Nh+N:Nh+N+Nh-2) = 0;
        case {'vpad'}
            xe(1:Nh-1) = x(1);
            xe(Nh+N:Nh+N+Nh-2) = x(N);
        case {'vsym'}
            xe(1:Nh-1) = 2*x(1)-fliplr(x(2:Nh));
            xe(Nh+N:Nh+N+Nh-2) = 2*x(N)-fliplr(x(N-Nh+1:N-1));
        otherwise
            disp('unknown border extension');
    end
    %xe
    M = length(xe);
    % convolution
    for k=1:M-Nh+1
        ye(k)=sum(hf.*xe(k:k+Nh-1));
    end
    %ye
    % signal with same length / x
    y = ye(1+zeroh-1:N+zeroh-1);

end % function convN



