%�����������������������ξ�ֵ�˲�������������
%����ͼ��
img = imread('�¹ⱦ��.bmp');
img=rgb2gray(img);%�õ��Ҷ�ͼ��
figure;subplot(2,2,1);
imshow(img);title('ԭʼͼ��');%�ֱ���Ӽ����˹�����ͽ�������
f2 = imnoise(img,'salt & pepper',0.3);
subplot(2,2,2);imshow(f2);
title('��������');
f2 = double(f2);
[M,N] = size(f2);

%���ξ�ֵ�˲���
n = 5; %ģ���С
f21 = f2 + ones(M,N); %��ֹ�и����ص�Ϊ0�����³˻�Ϊ0
f12 = f21;
for i = 1:M-n+1    
    for j = 1:N-n+1        
        g2 = f21(i:i+n-1,j:j+n-1);        
        s2 = prod(g2(:));        %���ĵ��ֵ����ͼ��ļ��ξ�ֵ����       
        f12(i+(n-1)/2,j+(n-1)/2) = s2.^(1/numel(g2));
    end
end
img2 = uint8(f12);
subplot(2,2,3);
imshow(img2);
title('���ξ�ֵ�˲����');