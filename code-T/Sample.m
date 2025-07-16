%用于数据采样
%X为数据集全体，行向量为数据，列为特征
%Y为X的类标号
%ratio为采样比例
%type为采样方式，balance为均衡采样，每类数据个数相同，unbalance为不均衡采样，每类数据按比例采样，数量不同
%L为抽取数据的序号，ratioL为真实采样比例
function [L,ratioL]=Sample(X_15shot,Y_15shot,ratio,type)
[m,~]=size(X_15shot);%m为标号数据数量，n为数据维数
mc=max(Y_15shot);%类别的数量    
P=(1:m)';%对数据集加上序号
if strcmp(type,'balance')
%     mlk=floor(floor(m*ratio)/mc);%均匀抽取时每个类抽取的数量
    mlk=ratio;
    ml=mc*mlk;%标号数据个数
    L=zeros(ml,1);%用于存储标号数据所在位置,为索引形式
    %从测试集中抽取数据组成训练集，并将所选元素从测试集中删除
    for k=1:mc%对于每一个类抽取
        Pk=P(Y_15shot==k);%寻找数据集在的第k个类的数据
        [mk,~]=size(Pk);%第k类数据的数量
        Ltmp=randperm(mk,mlk);%在mtmp(1)个数中随机抽取mlc个
        Lc=Pk(Ltmp);
        L((k-1)*mlk+1:k*mlk)=Lc;
    end
    ratioL=ml/m;
else
    for k=1:mc        
        Pk=P(Y_15shot==k);%寻找数据集在的第k个类的数据
        [mk,~]=size(Pk);%第k类数据的数量
        mlk=max(floor(mk*ratio),1);
        Ltmp=randperm(mk,mlk);%在mtmp(1)个数中随机抽取mlc个
        Lc=Pk(Ltmp);
        L((k-1)*mlk+1:k*mlk)=Lc;
    end
    L(L==0)=[];
    [Lr,~]=size(L);
    ratioL=Lr/m;
end