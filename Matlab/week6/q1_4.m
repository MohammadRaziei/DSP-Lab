clc; clear all; close all;
%%
gray =@(im) (im(:,:,1) + im(:,:,2) + im(:,:,3) )/3;

lena = imread('lena.bmp');
lena_d = im2double(lena);
imshow(lena_d);
lena_gray = gray(lena_d);
lena_h = imhist(lena_gray);

figure;imshow(lena_gray);
figure;
lena_hq = histeq(lena_gray);
figure;imshow(lena_hq);
subplot(211);imhist(lena_gray);
subplot(212);imhist(lena_hq);