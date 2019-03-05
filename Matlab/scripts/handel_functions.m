%% sinc interpolation
% H_sinc_inter =@(t_r,Ts,Sn) sinc( ( repmat(t_r + Ts - min(t_r),Sn,1) - repmat(((1:Sn)*Ts)' , 1 , length(t_r)) ) / Ts );
% % % example :
% % t = linspace(-5,5,256);
% % y = sinc(2*t);
% % Ts = t(2)-t(1);
% % t_re = linspace(-5,5,256*3);
% % y_re = y * H_sinc_inter(t_re,Ts,256);

sinc_inter =@(t_r,y,k) y * sinc( ( repmat(t_r - (t_r(2) - t_r(1)) - min(t_r),length(y),1) - repmat( ((0:length(y)-1) *(t_r(2) - t_r(1)) * k)' , 1 , length(t_r)) ) / ((t_r(2) - t_r(1)) * k) );
% Sn = length(y)
% Ts = ((t_r(2) - t_r(1)) * k)
% % Fs = k * fs
% y_re = sinc_inter(t_re,y,k)
%%



