%计算未标号数据代入模型后决策层神经单元反应
%xul为未标号数据单点
%XL为标号数据集,YL为其标号向量
%w0为层间连接权重矩阵，行为记忆场，列为决策层
%hm0和hd0为记忆层和决策层的静息活性
%ud为决策层神经单元反应
function [v,u]=MSNMtest(xt,XL,YL,sigm1,w0)

[ml,n]=size(XL);%标号数据个数和特征维数
mc=max(YL);%类的个数
%定义决策层神经单元位置

XT=[XL;xt];%记忆场神经单元位置
ml=ml+1;%记忆层神经单元个数+1
sm=zeros(ml,1);
sm(ml)=1;%将待分类数据排到最后一行
tmp=w0;
w0=zeros(ml,mc);
w0(1:ml-1,:)=tmp;

%记忆层层向连接权重
Wm=dogdistm(XT,sigm1);
u=thetae(Wm*thetart(sm-0));
% v=thetart((w0'*thetart(u)));
 v=thetart(w0'*thetart(u-0));