%%%%%%自适应局部降噪滤波——高斯噪声
clear,clc
f=imread('月光宝盒.bmp');
a=0.3;
f=rgb2gray(f);%得到灰度图像
subplot(3,1,1);imshow(f);title('原图');
[M,N]=size(f);
f=double(f);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%构造一个高斯噪声矩阵 gn
mu=20;sigma=20; gn=normrnd(mu,sigma,M,N);
%%%构造一个矩阵 temp 随机选出 20%的像素用于加噪声 
temp=zeros(M,N);%%%默认每个元素都为 0，即不加噪声 
amount=round(M*N*a); %%%加噪像素总量 
for j=1:amount 
    x=randi(M,1,1);
    y=randi(N,1,1); 
    temp(x,y)=1;%将选中的像素点值置为 1，对这些像素点加噪声
end
%%%加高斯噪声 
fgn=f+temp.*gn;
f=uint8(fgn);
subplot(3,1,2);imshow(f);title('加Gaussian噪声');
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%将原图像四周各扩展三行三列
row1=[f(1,1),f(1,1),f(1,1),f(1,:),f(1,N),f(1,N),f(1,N)]; %此为顶部的行
rowm=[f(M,1),f(M,1),f(M,1),f(M,:),f(M,N),f(M,N),f(M,N)]; %此为底部的行
col1=f(:,1); %此为左部的列
coln=f(:,N); %此为右部的列
f1=[row1;row1;row1;col1,col1,col1,f,coln,coln,coln;rowm;rowm;rowm]; %将原图像四周各扩展三行三列
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%设置滤波器参数并进行滤波
f2=zeros(M,N);%用矩阵f2从扩展后的矩阵f1中提取原范围的图像
varn=400;%已知噪声方差为400
m=5;%设置子窗为5*5
dm=(m-1)/2;
for i=4:M+3
    for j=4:N+3
        A=f1(i-dm:i+dm,j-dm:j+dm);%用矩阵A选取m*m个像素点进行滤波
        [ml,varl]=MuVar(A);
        if varl>=varn
            f2(i-3,j-3)=f1(i,j)-(varn/varl)*(f1(i,j)-ml);
            f1(i,j)=f2(i-3,j-3);
        else
            f2(i-3,j-3)=ml;
            f1(i,j)=ml;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=uint8(f2);
subplot(3,1,3);imshow(g);title('自适应局部降噪滤波');