function sc = Square(NT, Np )
    % --- square signal ---
    % parameter :
    %   NT : number of periods, can be non-integer
    %   Np : number of points of the signal
    % Rk : the final length can be different of Np !
    % do not use the matlab square function (irregular pattern)
    % NT can be non integer
    DT2=int16(Np/NT/2);DT=2*DT2;
    Npq=NT*DT;
    sc=0;
    for q=1:Npq
        sc(q)=-1;
        r=rem(q-1,DT)+1;
        sc(q)=sc(q)+2*(r>DT2);
    end
end

