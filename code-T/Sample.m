%�������ݲ���
%XΪ���ݼ�ȫ�壬������Ϊ���ݣ���Ϊ����
%YΪX������
%ratioΪ��������
%typeΪ������ʽ��balanceΪ���������ÿ�����ݸ�����ͬ��unbalanceΪ�����������ÿ�����ݰ�����������������ͬ
%LΪ��ȡ���ݵ���ţ�ratioLΪ��ʵ��������
function [L,ratioL]=Sample(X_15shot,Y_15shot,ratio,type)
[m,~]=size(X_15shot);%mΪ�������������nΪ����ά��
mc=max(Y_15shot);%��������    
P=(1:m)';%�����ݼ��������
if strcmp(type,'balance')
%     mlk=floor(floor(m*ratio)/mc);%���ȳ�ȡʱÿ�����ȡ������
    mlk=ratio;
    ml=mc*mlk;%������ݸ���
    L=zeros(ml,1);%���ڴ洢�����������λ��,Ϊ������ʽ
    %�Ӳ��Լ��г�ȡ�������ѵ������������ѡԪ�شӲ��Լ���ɾ��
    for k=1:mc%����ÿһ�����ȡ
        Pk=P(Y_15shot==k);%Ѱ�����ݼ��ڵĵ�k���������
        [mk,~]=size(Pk);%��k�����ݵ�����
        Ltmp=randperm(mk,mlk);%��mtmp(1)�����������ȡmlc��
        Lc=Pk(Ltmp);
        L((k-1)*mlk+1:k*mlk)=Lc;
    end
    ratioL=ml/m;
else
    for k=1:mc        
        Pk=P(Y_15shot==k);%Ѱ�����ݼ��ڵĵ�k���������
        [mk,~]=size(Pk);%��k�����ݵ�����
        mlk=max(floor(mk*ratio),1);
        Ltmp=randperm(mk,mlk);%��mtmp(1)�����������ȡmlc��
        Lc=Pk(Ltmp);
        L((k-1)*mlk+1:k*mlk)=Lc;
    end
    L(L==0)=[];
    [Lr,~]=size(L);
    ratioL=Lr/m;
end