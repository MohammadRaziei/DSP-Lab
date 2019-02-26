%% sinc interpolation
hr =@(t_r,Ts,Sn) sinc( ( repmat(t_r + Ts - min(t_r),Sn,1) - repmat(((1:Sn)*Ts)' , 1 , length(t_r)) ) / Ts );
% % example :
% t = linspace(-5,5,256);
% y = sinc(2*t);
% Ts = t(2)-t(1);
% t_re = linspace(-5,5,256*3);
% y_re = y * hr(t_re,Ts,256);
%%





