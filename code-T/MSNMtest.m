%����δ������ݴ���ģ�ͺ���߲��񾭵�Ԫ��Ӧ
%xulΪδ������ݵ���
%XLΪ������ݼ�,YLΪ��������
%w0Ϊ�������Ȩ�ؾ�����Ϊ���䳡����Ϊ���߲�
%hm0��hd0Ϊ�����;��߲�ľ�Ϣ����
%udΪ���߲��񾭵�Ԫ��Ӧ
function [v,u]=MSNMtest(xt,XL,YL,sigm1,w0)

[ml,n]=size(XL);%������ݸ���������ά��
mc=max(YL);%��ĸ���
%������߲��񾭵�Ԫλ��

XT=[XL;xt];%���䳡�񾭵�Ԫλ��
ml=ml+1;%������񾭵�Ԫ����+1
sm=zeros(ml,1);
sm(ml)=1;%�������������ŵ����һ��
tmp=w0;
w0=zeros(ml,mc);
w0(1:ml-1,:)=tmp;

%������������Ȩ��
Wm=dogdistm(XT,sigm1);
u=thetae(Wm*thetart(sm-0));
% v=thetart((w0'*thetart(u)));
 v=thetart(w0'*thetart(u-0));