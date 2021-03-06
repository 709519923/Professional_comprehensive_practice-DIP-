%——————————最大、最小值滤波——————
clc;
clear;
f=imread('月光宝盒.bmp');
image_gray=rgb2gray(f);%得到灰度图像

f1=imnoise(image_gray,'gaussian',0.3);%添加椒盐噪声后的图像
f2=ordfilt2(f1,1,ones(3,3));%最小值滤波后的图像
f3=ordfilt2(f1,9,ones(3,3));%最大值滤波后的图像

subplot(2,2,1);
imshow(image_gray);
title('原图');
subplot(2,2,2);
imshow(f1);
title('椒盐噪声污染后的图像');
subplot(2,2,3);
imshow(f2);
title('最小值滤波');
subplot(2,2,4);
imshow(f3);
title('最大值滤波');
