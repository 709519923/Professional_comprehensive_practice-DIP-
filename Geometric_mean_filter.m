%——————————几何均值滤波——————
%读入图像
img = imread('月光宝盒.bmp');
img=rgb2gray(img);%得到灰度图像
figure;subplot(2,2,1);
imshow(img);title('原始图像');%分别添加加入高斯噪声和椒盐噪声
f2 = imnoise(img,'salt & pepper',0.3);
subplot(2,2,2);imshow(f2);
title('椒盐噪声');
f2 = double(f2);
[M,N] = size(f2);

%几何均值滤波器
n = 5; %模板大小
f21 = f2 + ones(M,N); %防止有个像素点为0而导致乘积为0
f12 = f21;
for i = 1:M-n+1    
    for j = 1:N-n+1        
        g2 = f21(i:i+n-1,j:j+n-1);        
        s2 = prod(g2(:));        %中心点的值用子图像的几何均值代替       
        f12(i+(n-1)/2,j+(n-1)/2) = s2.^(1/numel(g2));
    end
end
img2 = uint8(f12);
subplot(2,2,3);
imshow(img2);
title('几何均值滤波结果');