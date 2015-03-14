function signalSystem()

N=100;
s = Dirac(10, N);
s = s+step(20, N);
s = ramp(10, 2, N);
s = geo(10, 1.2, N);
s = box(10, 2, N);
sum(s)
s = sinus(10, 0, 2, 'N', 40);
figure(1), plot(s, '*-');

end % function signalSystem

%--------------------------------------------------
% deterministic signals
%--------------------------------------------------

% --- Dirac function ---
% parameter : k -> Dirac(k); N -> length of the discrete signal
function s = Dirac(k, N) % dirac existe en matlab
    if ((k<1) | (k>N))
        disp('!!!! k must be in the range [1,N]');
        s=0;
        return
    end
    s = zeros(1,N);
    s(k) = 1;
end % function dirac
 

function s = step(k, N)
    if ((k<1) | (k>N))
        disp('!!!! k must be in the range [1,N]');
        s=0;
        return
    end
    s(1:k) = zeros(1,k);
    s(k+1:N) = ones(1,N-k);
end % function step
 

function s = ramp(k, slope, N)
    if ((k<1) | (k>N))
        disp('!!!! k must be in the range [1,N]');
        s=0;
        return
    end
    s(1:k) = zeros(1,k);
    s(k+1:N) = slope*(1:N-k);
end % function ramp


function s = geo(k, a, N)
    if ((k<1) | (k>N))
        disp('!!!! k must be in the range [1,N]');
        s=0;
        return
    end
    s(1:k) = zeros(1,k);
    s(k+1:N) = a.^(1-1:N-k-1);
end % function geometric sequence


function s = box(center, midWidth, N)
    if ((center-midWidth<1) | (center+midWidth>N))
        disp('!!!! Box must be in the range [1,N]');
        s=0;
        return
    end
    s(1:N) = zeros(1,N);
    s(center-midWidth:center+midWidth) = 1/(2*midWidth+1);
end % function box



% --- Sinus function ---
% parameter : f -> frequency; phase_rd -> dephasage, 
%             nbPeriod -> nombre de périodes, peut être non entier
%             'Fs', value  or 'N', value  -> sampling frequency or signal
%               length
% Remark 1 : if the number of period is an integer, the last point
%  cannot be the beginning of the repeated signal
% Remark 2 : if 'Fs' is chosen, the exact temporal length N*Fs can be different
% from the expected one Ttotal = nbPeriod/f 
function s = sinus(f, phase_rd, nbPeriod, varargin) %fs or N)
    Ttotal = nbPeriod/f;
    if (strcmp(varargin{1},'N'))
        N = varargin{2};
        Fs = 1/(Ttotal/N);
    else
        Fs = varargin{2}
        N = round(Ttotal*Fs); % ne tombe pas forécement sur un entier => N retenu puisque dicté pas Ts
        disp('Warning: the length of the signal can be different from N*Ts');
    end
    Ts = 1/Fs;
    s = sin(2*pi*f*(0:N-1)*Ts+phase_rd);
end % function sinus



 
















