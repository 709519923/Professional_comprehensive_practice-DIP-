function B=PaiXu(A)
[m,n]=size(A);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%将A的像素值存储于一维矩阵B中
len=m*n;
B=zeros(len,1);
for i=1:m
    for j=1:n
        B((i-1)*n+j,1)=A(i,j);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%对B中元素进行排序
for index = len:-1:2
    for i = 2:index
        temp = B(i,1);
        if temp<B(i-1,1)
            B(i,1) = B(i-1,1);
            B(i-1,1) = temp;
        end
    end
end