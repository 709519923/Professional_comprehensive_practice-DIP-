%%%%%%����Ӧ�ֲ������˲�������˹����
clear,clc
f=imread('�¹ⱦ��.bmp');
a=0.3;
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
varn=400;%��֪��������Ϊ400
m=5;%�����Ӵ�Ϊ5*5
dm=(m-1)/2;
for i=4:M+3
    for j=4:N+3
        A=f1(i-dm:i+dm,j-dm:j+dm);%�þ���Aѡȡm*m�����ص�����˲�
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
subplot(3,1,3);imshow(g);title('����Ӧ�ֲ������˲�');