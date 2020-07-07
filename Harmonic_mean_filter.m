%%%%%%------------------谐波均值滤波器-------------
clc;
clear;
%读入图像，并转换为double型
I=imread('月光宝盒.bmp');
I=rgb2gray(I);%得到灰度图像
I_D=im2double(I);
[MM,NN]=size(I_D);
 I_D = imnoise(I_D,'gaussian',0.3);
%定义子窗口的尺寸
m=5;
n=5;
%确定要扩展的行列数
len_m=floor(m/2);
len_n=floor(n/2);
%将原始图像进行扩展，这里采用了镜像扩展，以进行图像边缘计算
I_D_pad=padarray(I_D,[len_m,len_n],'symmetric');
%获得扩展后的图像尺寸
[M,N]=size(I_D_pad);
J_Harmonic=zeros(MM,NN);
%逐点计算子窗口的谐波平均
for i=1+len_m:M-len_m
    for j=1+len_n:N-len_n
        %从扩展图像中取出子图像
        Block=I_D_pad(i-len_m:i+len_m,j-len_n:j+len_n);
        %求子窗口的谐波平均
        s=sum(sum(1./Block));
        J_Harmonic(i-len_m,j-len_n)=m*n/s;
    end
end
imshow(J_Harmonic);
title('谐波均值滤波器');
