load('cifar_transformer_features.mat');
load('cifar_transformer_lables.mat');
features=cifar_transformer_features;
labels=cifar_transformer_lables;

% load('cifar_resnet12_features.mat');
% load('cifar_resnet12_lables.mat');
% features=cifar_resnet12_features;
% lables=cifar_resnet12_lables;

% load('cifar_resnet18_features.mat');
% load('cifar_resnet18_lables.mat');
% features=cifar_resnet18_features;
% lables=cifar_resnet18_lables;

% load('cifar_resnet50_features.mat');
% load('cifar_resnet50_lables.mat');
% features=cifar_resnet50_features;
% lables=cifar_resnet50_lables;

% load('PCANET_cifar100fs_testfeatures.mat');
% load('PCANET_cifar100fs_testlabels.mat');
% features=ftest';
% lables=TestLabels;

% load('cifar_resnet34_features41.mat');
% load('cifar_resnet34_lables41.mat');
% features=cifar_resnet34_features;
% lables=cifar_resnet34_lables;

class = round(unifrnd(1,20,1,nways));
while length(unique(class))~=length(class)
    class = round(unifrnd(1,20,1,nways));
end
new_class = setdiff(1:20, class);
if length(unique(new_class)) >= newk
    new_class = randsample(new_class, 5);
else
    error('可用数字不足以选择5个与 class 中不同的数字');
end

data=zeros(600*nways,size(features,2));
data_label=zeros(600*nways,1);
data_new=zeros(600*newk,size(features,2));
data_new_label=zeros(600*newk,1);
instance=zeros(nways*sample_num,size(features,2));
instance_label=zeros(nways*sample_num,1);
instance_new=zeros(newk*new_sample_num,size(features,2));
instance_new_label=zeros(newk*new_sample_num,1);
s=1;
s2=1;
s3=1;
for i=1:nways
    class2 = round(unifrnd(1,600,1,sample_num));
while length(unique(class2))~=length(class2)
    class2 = round(unifrnd(1,600,1,sample_num));
end
   class3=round(unifrnd(1,600,1,new_sample_num));
   while length(unique(class3))~=length(class3)
       class3 = round(unifrnd(1,600,1,new_sample_num));
   end
   data(s:599+s,:)=features(labels==class(i),:);
   data_new(s:599+s,:)=features(labels==new_class(i),:);
   x=data(s:599+s,:);
   if(i<=newk)
       x1=data_new(s:599+s,:);
       instance_new(s3:new_sample_num-1+s3,:)=x1(class3,:);
       data_new_label(s:599+s)=labels(labels==new_class(i));
       y1=data_new_label(s:599+s);
       instance_new_label(s3:new_sample_num-1+s3)=y1(class3,:);
       instance_new_label(s3:new_sample_num-1+s3)=i+5;

   end
   instance(s2:sample_num-1+s2,:)=x(class2,:);
   data_label(s:599+s)=labels(labels==class(i));
   y=data_label(s:599+s);
   instance_label(s2:sample_num-1+s2)=y(class2,:);
   instance_label(s2:sample_num-1+s2)=i;
   s=s+600;
   s2=s2+sample_num;
   s3=s3+new_sample_num;
end
