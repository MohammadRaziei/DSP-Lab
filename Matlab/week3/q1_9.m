%% init workspace
clc;clear all;close all;
%% def problem parameters 
t = 0:1/(2*pi):100;
x = zeros(size(t));
for fi = pi.*[ 1/16,5/16,9/16,13/16]
    x = x + cos(2*pi*fi*t);
end
%% a) plot fft and fftshift
fft_x = fft(x,512);
fftshift_x = fftshift(fft_x);
W_fft =  linspace(0,2*pi,length(fft_x));
W_fftshift =  linspace(-pi,pi,length(fftshift_x));

figure;
subplot(211);   plot(W_fft/pi,abs(fft_x),'r'); xlabel('fft');
subplot(212);   plot(W_fftshift/pi,abs(fftshift_x),'g'); xlabel('fftshift');

%% b) xlsread
close all;
H = xlsread('filters.xls',1);
F = xlsread('filters.xls',2);
%% c) H -> F
 flt = [];
for i = 1:4
    flt_temp = filter(H(i,:),1,x);
%     flt_temp = downsample(flt_temp,4);
    flt_temp = flt_temp(1:4:length(flt_temp));
    flt = [flt;flt_temp];
end
flt2 = zeros(size(flt));

flt2(1,:) = flt(1,:) * 2;
flt2(3,:) = flt(3,:);
flt2(4,:) = flt(4,:) * 0.5;
% upsample
flt3 = zeros(4,size(flt,2)*4);
flt3(:,1:4:length(flt3)) = flt2; 

y = 0;
for i = 1:4
    flt_temp = filter(F(i,:),1,flt3(i,:));
    y = y + flt_temp;
end

%% plot x,y
fftshift_y = fftshift(fft(y,512));
figure; hold on;
plot(W_fftshift/pi,abs(fftshift_x),'r'); %xlabel('fftshift : x');
plot(W_fftshift/pi,abs(fftshift_y),'g'); %xlabel('fftshift : y');
legend('fftshift : x','fftshift : y');


 
