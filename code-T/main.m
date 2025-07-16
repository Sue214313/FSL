clc
clear

sampletype='balance';
dataset='imagenet';
nways=5;
kshot=10;
sample_num=20;
times=10;
acc=zeros(times,1);
acc1=zeros(times,1);
acc2=zeros(times,1);
H=zeros(times,1);
runtime=zeros(times,1);
newk = 5;%新类的种类
new_sample_num=10;%新类采样的个数

for z= 1:times
    if strcmp(dataset,'cub')
        cub;
    elseif strcmp(dataset,'cifar')
        cifar;
    elseif strcmp(dataset,'imagenet')
        imagenet;
    elseif strcmp(dataset,'cifar10')
        cifar10;
    end
    
    [L,ratioL]=Sample(instance,instance_label,kshot,sampletype);
    tic;
    %[COEFF, SCORE, LATENT, TSQUARED] = pca((instance)) ;%想办法找到东西替
    %SCORE=tsne((instance));%数据降维t-sne
    % [COEFF,SCORE,PCVAR] = ppca((instance),5);
    % [SCORE,umap] = run_umap((instance),'n_neighbors', 100, 'min_dist', 0.3, 'n_components', 20);
    %使用Umap降维
    % SCORE = lle((instance),99,4,'manhattan');%lle降维
    SCORE = LE((instance),4,99,'cosine');%LE降维
    SCORE1 = LE((instance_new),4,49,'cosine');%对新类的LE降维
    % SCORE = LE_new((instance),4,99,'correlation');%LE_new降维
    % SCORE = LE_new((instance),4,99,'minkowski',3);%LE_new降维minkowski专用
    % SCORE = LE((instance),4,99,'euclidean');%LE降维(相对数量级太小了)
    % SCORE = LDA(instance,instance_label,5);%acc十分的离谱
    % SCORE = (instance);%不降维直接用
    instance_redu=SCORE(:,:);%orinigal
    S_set=instance_redu(L,:);%original
    S_set_label=instance_label(L,:);%original
    Q_set=[instance_redu;SCORE1];
    Q_set_label=[instance_label;instance_new_label];
    Q_set(L,:)=[];%original
    Q_set_label(L,:)=[];%original
    [Q_set,Q_set_label] = SHIFT(Q_set,Q_set_label);
    %Q_set_label_pre=MSNMclassifier(S_set,S_set_label,Q_set);%好使的
    [Q_set_label_pre,Q_set,Q_set_label,max_ud]=MSNMclassifier1(S_set,S_set_label,Q_set,Q_set_label,nways);%OWL好使的
    %[Q_set_label_pre,Q_set,Q_set_label]=MSNMclassifier2(S_set,S_set_label,Q_set,Q_set_label,nways);%OWL
    %[Q_set_label_pre,Q_set,Q_set_label]=MSNMclassifier3(S_set,S_set_label,Q_set,Q_set_label,nways);%OWL
    %[Q_set_label_pre,Q_set,Q_set_label]=MSNMclassifier4(S_set,S_set_label,Q_set,Q_set_label,nways);%OWL
    %[Q_set_label_pre,Q_set,Q_set_label,ud]=MSNMclassifier5(S_set,S_set_label,Q_set,Q_set_label,nways);%OWL好使的
    % [Q_set_label_pre,Q_set,Q_set_label,ud]=MSNMclassifier6(S_set,S_set_label,Q_set,Q_set_label,nways);%OWL好使的
    % acc(z)=mean(Q_set_label_pre==Q_set_label);
    %Q_set_label_pre=knnClassifier(S_set,S_set_label,Q_set,3);
    % Q_set_label_pre=my_MultiSvm(S_set,S_set_label,Q_set);
    time=toc;
    acc(z)=mean(Q_set_label_pre==Q_set_label);
    %接下来的部分用于计算Supacc和Incacc还有H-measure
    [L_new,~]=find(Q_set_label>nways);
    [L_new_1,~]=find(Q_set_label<=nways);
    acc1(z)=mean(Q_set_label(L_new)==Q_set_label_pre(L_new));
    acc2(z)=mean(Q_set_label(L_new_1)==Q_set_label_pre(L_new_1));
    % labels = transform(Q_set_label,nways);
    % labels_new = transform(Q_set_label_pre,nways); 
    % H(z)=h_measure(max_ud,labels);
    %
    runtime(z,1)=time;
    disp(z);
end
disp(['The ', num2str(nways),'way-',num2str(kshot),'shot acc of ',dataset,' = ',num2str(mean(acc))]);
disp(['The ', num2str(nways),'way-',num2str(kshot),'shot sup acc of ',dataset,' = ',num2str(mean(acc2))]);
disp(['The ', num2str(nways),'way-',num2str(kshot),'shot inc acc of ',dataset,' = ',num2str(mean(acc1))]);
disp(['The ', num2str(nways),'way-',num2str(kshot),'shot H-measure of ',dataset,' = ',num2str(mean(H))]);
% SaveResultToExcel(acc',num2str(mean(acc)));
% disp(['The ', num2str(nways),'way-',num2str(kshot),'shot time of ',dataset,' = ',num2str(mean(runtime))]);
% SaveResultToExcel(runtime',num2str(mean(runtime)));