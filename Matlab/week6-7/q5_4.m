clc;clear all; close all;
image = im2double(imread('glass.tif'));
image_gray = mean(image,3);
%imshow(image_gray)
fft_2 = fft2(image_gray);
fft_norm = db(abs(fft_2));
fft_phase = angle(fft_2);
%figure;
%mesh(fft_norm);
%figure;
%mesh(fft_phase)
figure;
fft_shift = fftshift(fft_2);
imshow(fft_shift)
output = filter_(0.1* pi,fft_shift);
figure;
imshow(output)
figure;
imshow(ifft2(ifftshift(output)));