%用于训练介观神经模型（MSNM）
%XL为标号训练集，每一行向量代表一个数据，每一列为一个数据维数
%YL为标号训练集类标号组成的列向量，以从1开始的连续自然数表示类别
%W为层间连接权重矩阵，h为静息活性
%sigm1为记忆层相互作用的激励宽度列向量，每个维度不同
function W0=MSNMtrain(YL)
mc=max(YL);%类别的数量
[ml,~]=size(YL);
W0=zeros(ml,mc);
for j=1:mc%每次训练一类
    for i=1:mc
    for jj=1:ml
        if YL(jj)==i
            W0(jj,i)=1;
        end
    end
    end
end
end