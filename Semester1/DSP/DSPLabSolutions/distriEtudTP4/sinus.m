
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


