%�������������������������Сֵ�˲�������������
clc;
clear;
f=imread('�¹ⱦ��.bmp');
image_gray=rgb2gray(f);%�õ��Ҷ�ͼ��

f1=imnoise(image_gray,'gaussian',0.3);%��ӽ����������ͼ��
f2=ordfilt2(f1,1,ones(3,3));%��Сֵ�˲����ͼ��
f3=ordfilt2(f1,9,ones(3,3));%���ֵ�˲����ͼ��

subplot(2,2,1);
imshow(image_gray);
title('ԭͼ');
subplot(2,2,2);
imshow(f1);
title('����������Ⱦ���ͼ��');
subplot(2,2,3);
imshow(f2);
title('��Сֵ�˲�');
subplot(2,2,4);
imshow(f3);
title('���ֵ�˲�');
