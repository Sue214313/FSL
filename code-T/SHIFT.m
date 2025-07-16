function [Q_set,Q_set_label] = SHIFT(Q_set,Q_set_label)
A=[Q_set,Q_set_label];
% 获取随机排列的行索引
shuffled_row_idx = randperm(size(A, 1));
% 按照行索引重排矩阵
B = A(shuffled_row_idx, :);
Q_set=B(:,1:end-1);
Q_set_label=B(:,end);