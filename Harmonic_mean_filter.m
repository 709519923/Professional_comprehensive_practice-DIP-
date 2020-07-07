%%%%%%------------------г����ֵ�˲���-------------
clc;
clear;
%����ͼ�񣬲�ת��Ϊdouble��
I=imread('�¹ⱦ��.bmp');
I=rgb2gray(I);%�õ��Ҷ�ͼ��
I_D=im2double(I);
[MM,NN]=size(I_D);
 I_D = imnoise(I_D,'gaussian',0.3);
%�����Ӵ��ڵĳߴ�
m=5;
n=5;
%ȷ��Ҫ��չ��������
len_m=floor(m/2);
len_n=floor(n/2);
%��ԭʼͼ�������չ����������˾�����չ���Խ���ͼ���Ե����
I_D_pad=padarray(I_D,[len_m,len_n],'symmetric');
%�����չ���ͼ��ߴ�
[M,N]=size(I_D_pad);
J_Harmonic=zeros(MM,NN);
%�������Ӵ��ڵ�г��ƽ��
for i=1+len_m:M-len_m
    for j=1+len_n:N-len_n
        %����չͼ����ȡ����ͼ��
        Block=I_D_pad(i-len_m:i+len_m,j-len_n:j+len_n);
        %���Ӵ��ڵ�г��ƽ��
        s=sum(sum(1./Block));
        J_Harmonic(i-len_m,j-len_n)=m*n/s;
    end
end
imshow(J_Harmonic);
title('г����ֵ�˲���');
