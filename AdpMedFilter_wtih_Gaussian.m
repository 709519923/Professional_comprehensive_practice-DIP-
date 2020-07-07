%%%%%%自适应中值滤波——高斯噪声
clear,clc
f=imread('月光宝盒.bmp');
a=0.5;
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
f = double(f);
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
Smax=7;%设置子窗最大为7*7
for i=4:M+3
    for j=4:N+3
        m=3;%设置子窗初始为3*3
        while m<=Smax
            len=m*m;
            dm=(m-1)/2;
            A=f1(i-dm:i+dm,j-dm:j+dm);%用矩阵A选取m*n个像素点进行滤波
            B=PaiXu(A);%进行排序
            zmin=B(1,1);
            zmax=B(len,1);
            zmed=B((1+len)/2,1);
            A1=zmed-zmin;
            A2=zmed-zmax;
            B1=f1(i,j)-zmin;
            B2=f1(i,j)-zmax;
            if A1>0&&A2<0
                if B1>0&&B2<0
                    f2(i-3,j-3)=f1(i,j);
                    break;
                else
                    f2(i-3,j-3)=zmed;
                    break;
                end
            else
                m=m+2;
            end
            f2(i-3,j-3)=zmed;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=uint8(f2);
subplot(3,1,3);
imshow(g);
title(['自适应中值滤波',' , 噪声系数 = ',num2str(a)])
%imwrite(g,'椒盐噪声1% 自适应中值滤波.bmp')