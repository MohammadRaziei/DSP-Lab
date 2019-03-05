%% init workspace
clc;clear all;close all;
addpath('../scripts');
% includes :
run handel_functions.m
%% def problem parameters 
t = 0:1/(2*pi):100;
x = zeros(size(t));
for fi = pi.*[ 1/16,5/16,9/16,13/16]
    x = x + cos(2*pi*fi*t);
end
%% plot fft and fftshift
fft_x = fft(x,512);
fftshift_x = fftshift(fft_x);
W_fft =  linspace(0,2*pi,length(fft_x));
W_fftshift =  linspace(-pi,pi,length(fftshift_x));

figure;
subplot(211);   plot(W_fft/pi,abs(fft_x)); xlabel('fft');
subplot(212);   plot(W_fftshift/pi,abs(fftshift_x)); xlabel('fftshift');

%%