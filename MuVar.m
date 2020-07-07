%求A中元素的均值mul和方差varl
function [ml,varl]=MuVar(A)
[m,n]=size(A);
%%%%%以下进行求均值
ml=0;
for i=1:m
    for j=1:n
        ml=ml+A(i,j)/(m*n);
    end
end
%%%%%以下进行求方差
varl=0;
for i=1:m
    for j=1:n
        varl=varl+((A(i,j)-ml).^2)/(m*n);
    end
end