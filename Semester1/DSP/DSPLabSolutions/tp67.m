% Recursive filtering
function recurv()
    % synthetic signal to test recursive filtering
    N=3D40;
    x =3D zeros(1,N);
    x(20) =3D 1; % impulse to observe impulse response

    % scale of the smoothing (and derivative) filter
    s=3D0.7;
    yp =3D smoothP(x, s); % causal
    yn =3D smoothN(x, s); % anti-causal

    figure(10), subplot(411), plot(x, '*-');
    subplot(412), plot(yp, '*-');

    subplot(413), plot(yn, '*-');

    yt=3Dyp+yn % total
    % check amplitude max in the plot
    subplot(414), plot(yt, '*-');

   =20
   =20
   =20
    % new test signal for derivative
    x(1:N)=3D0;
    x(N/4:N-N/4)=3D1;
    yp =3D derivP(x, s);
    yn =3D derivN(x, s);
    % rk: here we observe the problem of the discrete defintion of the
    % filter-> the step response (corresponding to the h function) has =
two
    % max while the h function has only one max!
    figure(11), subplot(411), plot(x, '*-');
    subplot(412), plot(yp, '*-');

    subplot(413), plot(yn, '*-');
    yt=3Dyp+yn;
    % check amplitude max in the plot
    subplot(414), plot(yt, '*-');

   =20
   =20
   =20
    % image filtering for edge detection
    Im =3D double(imread('barbara.gif'));
    [ni, nj] =3D size(Im);
    [ImGi, ImGj] =3D CannyDeriche(Im, s);
    figure(20), imagesc(Im); title('Image 1');colormap('gray');
    figure(21), imshow(ImGi(10:ni-10,10:nj-10), [-200 =
200]);colormap('gray');title('Gi');
    figure(22), imshow(ImGj(10:ni-10,10:nj-10), [-200 =
200]);colormap('gray');title('Gj');
    figure(23), imagesc(abs(ImGi+j*ImGj));colormap('gray');title('|G|');
    figure(24), =
imagesc(angle(ImGi+j*ImGj));colormap('gray');title('Arg[G]');

end % end of the (main) recurv function --------------------------


% Canny-Deriche edge detection
function [ImGi, ImGj] =3D CannyDeriche(Im, s)
    ImGi=3Dgrad_i(Im, s);
    ImGj=3Dgrad_j(Im, s);
end


% gradient component Gi along rows
% we smooth along the rows and, on the result obtained, we apply the
% derivative. Derivative can be applied before smoothing
function Gi =3D grad_i(Im, s)
    [ni, nj] =3D size(Im);
    % smoothing along rows
    for i=3D1:ni
        Iml(i,:)=3DsmoothP(Im(i,:), s);=20
        Iml(i,:)=3DIml(i,:)+smoothN(Im(i,:), s);=20
    end
    % derivative along columns
    for j=3D1:nj
        Gi(:,j)=3DderivP(Iml(:,j), s)'; % transpose -> '
        Gi(:,j)=3DGi(:,j)+derivN(Iml(:,j), s)';=20
    end
end

% gradient component Gj along columns
function Gj =3D grad_j(Im, s)
    [ni, nj] =3D size(Im);
    % derivative along rows
    for i=3D1:ni
        Iml(i,:)=3DderivP(Im(i,:), s);=20
        Iml(i,:)=3DIml(i,:)+derivN(Im(i,:), s);=20
    end
    % smoothing along columns
    for j=3D1:nj
        Gj(:,j)=3DsmoothP(Iml(:,j), s)'; % transpose -> '
        Gj(:,j)=3DGj(:,j)+smoothN(Iml(:,j), s)';=20
    end
end

% causal smmothing
function yp =3D smoothP(x, s)
    N =3D length(x);
    T=3D1; % sampling
    l=3Ds*T;% alpha
    a=3Dexp(-l);
    yp=3D0;
    yp(1:2)=3D0; % initialization of the two first responses
    for k=3D3:N
        yp(k)=3Dx(k)+a*(l-1)*x(k-1)+2*a*yp(k-1)-a^2*yp(k-2);
    end=20
end


% anti-causal smoothing
function yn =3D smoothN(x, s)
    N =3D length(x);
    T=3D1;
    l=3Ds*T;% alpha
    a=3Dexp(-l);
    yn=3D0;
    yn(N-1:N)=3D0;
    for k=3DN-2:-1:1
        yn(k)=3Da*(l+1)*x(k+1)-a*a*x(k+2)+2*a*yn(k+1)-a^2*yn(k+2);
    end
end


% causal derivative
function yp =3D derivP(x, s)
    N =3D length(x);
    T=3D1;
    l=3Ds*T;% alpha
    a=3Dexp(-l);
    yp=3D0;
    yp(1:2)=3D0;
    for k=3D3:N
        yp(k)=3D-l*s*a*x(k-1)+2*a*yp(k-1)-a^2*yp(k-2);
    end=20
end

% anti-causal derivative
function yn =3D derivN(x, s)
    N =3D length(x);
    T=3D1;
    l=3Ds*T;% alpha
    a=3Dexp(-l);
    yn=3D0;
    yn(N-1:N)=3D0;
    for k=3DN-2:-1:1
        yn(k)=3Dl*s*a*x(k+1)+2*a*yn(k+1)-a^2*yn(k+2);
    end
end




