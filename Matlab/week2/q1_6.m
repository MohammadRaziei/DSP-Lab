clc;clear all;close all
t = 0:0.01:2;
amp = 5;
f = 1;
y = amp * sin(2 * pi * t * f);
%%
% figure(1)
% subplot(2,1,1)
% plot(t,y);
% xlabel('time');
% ylabel('5 * Sin(2*pi*1*t)');
% title('sin');
% figure(2)
% subplot(2,1,1)
% stem(t,y);
% xlabel('time');
% ylabel('5 * Sin(2*pi*1*t)');
% title('sin');
%%
n = rand(size(t))-0.5;
yn = y + n;
% figure(1)
% subplot(2,1,2)
% plot(t,yn);
% xlabel('time');
% ylabel('5 * Sin(2*pi*1*t)');
% title('sin');
% 
% figure(2)
% subplot(2,1,2)
% stem(t,yn);
% xlabel('time');
% ylabel('5 * Sin(2*pi*1*t)');
% title('sin');
%%
moving = ones(1,21)*1/21;
yf = conv(yn,moving);
% figure(3)
% % subplot(2,1,2)
% plot(((1:length(yf))-10)/100, yf);
% xlabel('time');
% ylabel('5 * Sin(2*pi*1*t)');
% title('conv');

%%
windowSize = 21;
a =1;
b = (1/windowSize)*ones(1,windowSize);
% y_d = filter(b,a,yn);
% plot(((1:length(y_d))-0)/100, y_d);
% xlabel('time');
% ylabel('5 * Sin(2*pi*1*t)');
% title('conv');

%%
% yc = singen(0.1,200);
% plot(yc)
%%
x = 0:0.01:4;
y =@(x) cos(2 * pi * x) + cos(8 * pi * x) + cos(12 * pi * x);
figure
ym = y(x);
plot(x, ym);
xs = 0:0.2:4;
hold on
ys = y(xs);
% plot(xs,ys,'o')
xn = 0:0.2:4;
yn = y(xn);
plot(xn,yn,'o')
arg_sinc = repmat(x+(xn(2) - xn(1)),size(yn,2),1  ) - repmat(((1:size(yn,2))*(xn(2)-xn(1)))' , 1 , size(ym,2));
hr = sinc( arg_sinc / (xn(2) - xn(1)) );
y_re = yn * hr;
% figure
plot(x,y_re)
% hold on
% plot(xn,yn)
% sum((y_re - yn).^2)




