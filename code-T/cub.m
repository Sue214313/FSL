
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 

load('cub_transformer_features.mat')
load('cub_transformer_lables.mat')
features=cub_transformer_features;
lables=cub_transformer_lables;

% load('cub_resnet12_features.mat')
% load('cub_resnet12_lables.mat')
% features=cub_resnet12_features;
% lables=cub_resnet12_lables;

% load('cub_resnet50_features.mat')
% load('cub_resnet50_lables.mat')
% features=cub_resnet50_features;
% lables=cub_resnet50_lables;

% load('cub_resnet18_features.mat')
% load('cub_resnet18_lables.mat')
% features=cub_resnet34_features;
% lables=cub_resnet34_lables;

% load('cub_resnet34_features53.mat')
% load('cub_resnet34_lables53.mat')
% features=cub_resnet34_features;
% lables=cub_resnet34_lables;

% 随机选择nways个类别
class = round(unifrnd(1, 50, 1, nways));
while length(unique(class)) ~= length(class)
    class = round(unifrnd(1, 50, 1, nways));
end

% 选择与class不重复的新类别
new_class = setdiff(1:50, class);
if length(new_class) >= newk
    new_class = randsample(new_class, newk);
else
    error('可用数字不足以选择5个与 class 中不同的数字');
end

% 初始化数据变量
data = zeros(size(features,1), size(features,2));
data_new = zeros(size(features,1), size(features,2));
data_label = zeros(size(features,1), 1);
data_new_label = zeros(size(features,1), 1);
data_label_unique = unique(class);
data_label_unique_new = unique(new_class);

a = 1;
a1 = 1;

% 按照类别填充 data 和 data_new
for i = 1:nways
    ii = data_label_unique(i);
    ij = data_label_unique_new(i);
    b = lables(lables == ii);    % 找到当前类别的数据
    b1 = lables(lables == ij);  % 找到新类别的数据
    i_num = length(b);          % 当前类别的样本数量
    i_num_new = length(b1);     % 新类别的样本数量
    
    % 填充 data 和 data_new
    data(a:a + i_num - 1, :) = features(lables == ii, :);
    data_new(a1:a1 + i_num_new - 1, :) = features(lables == ij, :);
    
    % 标签赋值
    data_label(a:a + i_num - 1, :) = i;
    data_new_label(a1:a1 + i_num_new - 1, :) = i;
    
    a = a + i_num;
    a1 = a1 + i_num_new;
end

% 删除标签为0的样本
data(data_label == 0, :) = [];
data_label(data_label == 0) = [];
data_new(data_new_label == 0, :) = [];
data_new_label(data_new_label == 0) = [];

% 初始化实例存储变量
instance = zeros(nways * sample_num, size(features, 2));
instance_new = zeros(nways * new_sample_num, size(features, 2));
instance_label = zeros(nways * sample_num, 1);
instance_new_label = zeros(nways * new_sample_num, 1);

c = 1;
c1 = 1;
d = 1;
d1 = 1;

% 随机选取样本填充实例
for i = 1:nways
    len = length(lables(lables == class(i)));
    len1 = length(lables(lables == new_class(i)));
    
    % 随机选择样本索引
    class2 = round(unifrnd(1, len, 1, sample_num));
    class3 = round(unifrnd(1, len1, 1, new_sample_num));
    
    % 确保选择的样本是唯一的
    while length(unique(class2)) ~= length(class2)
        class2 = round(unifrnd(1, len, 1, sample_num));
    end
    while length(unique(class3)) ~= length(class3)
        class3 = round(unifrnd(1, len1, 1, new_sample_num));
    end
    
    % 提取当前类别的数据
    xxx = data(c:c + len - 1, :);
    yyy = data_new(c1:c1 + len1 - 1, :);
    
    % 填充实例数据
    instance(d:d + sample_num - 1, :) = xxx(class2, :);
    instance_new(d1:d1 + new_sample_num - 1, :) = yyy(class3, :);
    
    % 填充实例标签
    instance_label(d:d + sample_num - 1) = i;
    instance_new_label(d1:d1 + new_sample_num - 1) = i+5;
    
    c = c + len;
    c1 = c1 + len1;
    d = d + sample_num;
    d1 = d1 + new_sample_num;
end
