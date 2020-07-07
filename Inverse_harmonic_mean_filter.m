%%%%%%------------------��г����ֵ�˲���--------------------------------
clc;
clear;
%����ͼ�񣬲�ת��Ϊdouble��
I=imread('�¹ⱦ��.bmp');
I=rgb2gray(I);%�õ��Ҷ�ͼ��
I_D=im2double(I);
I_D=imnoise(I_D,'gaussian',0.3);
[MM,NN]=size(I_D);
%�����Ӵ��ڵĳߴ�
m=3;
n=3;
%ȷ��Ҫ��չ��������
len_m=floor(m/2);
len_n=floor(n/2);
%��ԭʼͼ�������չ����������˾�����չ���Խ���ͼ���Ե����
I_D_pad=padarray(I_D,[len_m,len_n],'symmetric');
%�����չ���ͼ��ߴ�
[M,N]=size(I_D_pad);
%�˲�������
Q=1.5;
J_Contraharmonic=zeros(MM,NN);
%�������Ӵ��ڵ�г��ƽ��
for i=1+len_m:M-len_m
    for j=1+len_n:N-len_n
        %����չͼ����ȡ����ͼ��
        Block=I_D_pad(i-len_m:i+len_m,j-len_n:j+len_n);
        %���Ӵ��ڵ�г��ƽ��
        s1=sum(sum(Block.^(Q+1)));
        s2=sum(sum(Block.^Q));
        J_Contraharmonic(i-len_m,j-len_n)=s1/s2;
    end
end
imshow(J_Contraharmonic);
title('��г����ֵ�˲���');