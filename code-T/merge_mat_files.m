% 定义输入和输出文件路径
file1 = 'cifar10_transformer_train_labels.mat'; % 第一个 .mat 文件路径
file2 = 'cifar10_transformer_test_labels.mat'; % 第二个 .mat 文件路径
output_file = 'cifar10_transformer_labels.mat'; % 输出合并后的 .mat 文件路径

% 加载两个 .mat 文件
data1 = load(file1);
data2 = load(file2);

% 检查两个文件是否包含矩阵变量
fieldnames1 = fieldnames(data1);
fieldnames2 = fieldnames(data2);

if length(fieldnames1) ~= 1 || length(fieldnames2) ~= 1
    error('Each .mat file should contain exactly one matrix variable.');
end

% 提取矩阵
matrix1 = data1.(fieldnames1{1}); % 提取第一个文件中的矩阵
matrix2 = data2.(fieldnames2{1}); % 提取第二个文件中的矩阵

% 确保矩阵的维度兼容（例如列数相同，适用于按行合并）
if size(matrix1, 2) ~= size(matrix2, 2)
    error('The two matrices must have the same number of columns to concatenate.');
end

% 合并矩阵（按行拼接）
cifar10_transformer_labels = [matrix1; matrix2]; % 按行拼接

% 保存到新的 .mat 文件
save(output_file, 'cifar10_transformer_labels');

disp(['Matrices have been merged and saved to: ' output_file]);
