%%%%%%����Ӧ��ֵ�˲�������˹����
clear,clc
f=imread('�¹ⱦ��.bmp');
a=0.5;
f=rgb2gray(f);%�õ��Ҷ�ͼ��
subplot(3,1,1);imshow(f);title('ԭͼ');
[M,N]=size(f);
f=double(f);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%����һ����˹�������� gn
mu=20;sigma=20; gn=normrnd(mu,sigma,M,N);
%%%����һ������ temp ���ѡ�� 20%���������ڼ����� 
temp=zeros(M,N);%%%Ĭ��ÿ��Ԫ�ض�Ϊ 0������������ 
amount=round(M*N*a); %%%������������ 
for j=1:amount 
    x=randi(M,1,1);
    y=randi(N,1,1); 
    temp(x,y)=1;%��ѡ�е����ص�ֵ��Ϊ 1������Щ���ص������
end
%%%�Ӹ�˹���� 
fgn=f+temp.*gn;
f=uint8(fgn);
subplot(3,1,2);imshow(f);title('��Gaussian����');
f = double(f);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ԭͼ�����ܸ���չ��������
row1=[f(1,1),f(1,1),f(1,1),f(1,:),f(1,N),f(1,N),f(1,N)]; %��Ϊ��������
rowm=[f(M,1),f(M,1),f(M,1),f(M,:),f(M,N),f(M,N),f(M,N)]; %��Ϊ�ײ�����
col1=f(:,1); %��Ϊ�󲿵���
coln=f(:,N); %��Ϊ�Ҳ�����
f1=[row1;row1;row1;col1,col1,col1,f,coln,coln,coln;rowm;rowm;rowm]; %��ԭͼ�����ܸ���չ��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%�����˲��������������˲�
f2=zeros(M,N);%�þ���f2����չ��ľ���f1����ȡԭ��Χ��ͼ��
Smax=7;%�����Ӵ����Ϊ7*7
for i=4:M+3
    for j=4:N+3
        m=3;%�����Ӵ���ʼΪ3*3
        while m<=Smax
            len=m*m;
            dm=(m-1)/2;
            A=f1(i-dm:i+dm,j-dm:j+dm);%�þ���Aѡȡm*n�����ص�����˲�
            B=PaiXu(A);%��������
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
title(['����Ӧ��ֵ�˲�',' , ����ϵ�� = ',num2str(a)])
%imwrite(g,'��������1% ����Ӧ��ֵ�˲�.bmp')