%��A��Ԫ�صľ�ֵmul�ͷ���varl
function [ml,varl]=MuVar(A)
[m,n]=size(A);
%%%%%���½������ֵ
ml=0;
for i=1:m
    for j=1:n
        ml=ml+A(i,j)/(m*n);
    end
end
%%%%%���½����󷽲�
varl=0;
for i=1:m
    for j=1:n
        varl=varl+((A(i,j)-ml).^2)/(m*n);
    end
end