clc; clear all; close all;
image = im2double(imread('image04.png'));
image_gray = mean(image,3);
imshow(image_gray)
noise =  fspecial('motion', 15, 20);
blured = imfilter(image_gray, noise,'replicate');
figure;
imshow(blured)
figure;
for i = 1:10
    wnr = deconvwnr(blured, noise, 0.005 * i);
    subplot(5, 2,i)
    imshow(wnr)
end