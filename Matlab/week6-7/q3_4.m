clc; clear all; close all;
%%

ImageName = im2double(imread('Image03.jpg'));
gray =@(im) (im(:,:,1) + im(:,:,2) + im(:,:,3) )/3;
ImageGray = gray(ImageName);
figure;imshow(ImageName);
[cA,cH,cV,cD] = dwt2(ImageGray,'db1');
figure;imshow( cA )
figure;imshow( cH ) 
figure;imshow( cV )
figure;imshow( cD )

mat1 = [];mat2=[];
for row = 1:size(ImageGray,1)
    [cA1,cD1] = dwt(ImageGray(row,:),'db1');
    mat1 = [ mat1;cA1];
    mat2 = [ mat2;cD1];
end
% ============
mat11 =[];mat12=[];mat21 =[];mat22 =[];
for col = 1:size(mat1,2)
    [cA1,cD1]   = dwt(mat1(:,col),'db1');
    [cA2,cD2]   = dwt(mat2(:,col),'db1');

    mat11 = [ mat11,cA1];
    mat12 = [ mat12,cD1];
    mat21 = [ mat21,cA2];
    mat22 = [ mat22,cD2];
end

figure;imshow( mat11 )
figure;imshow( mat12 )
figure;imshow( mat21 )
figure;imshow( mat22 )

% [cA1,cD1] = dwt(ImageGray,'db1');
% [cA1A,cD1A] = dwt(cA1','db1');
% [cA1D,cD1D] = dwt(cD1','db1');
% 
% figure;imshow( cA1A )
% figure;imshow( cD1A )
% figure;imshow( cA1D )
% figure;imshow( cD1D )
