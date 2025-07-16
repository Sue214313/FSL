function Y = LE(X, d, k, distanceMetric)
    % Laplacian Eigenmaps (LE) 降维
    % X: 输入数据矩阵，每行是一个样本
    % d: 目标维度
    % k: 邻居数
    % distanceMetric: 距离度量方式，支持 'euclidean', 'cosine', 'mahalanobis'

    % 数据标准化
    X = normalize(X);

    % 获取样本数量
    n = size(X, 1);

    if strcmp(distanceMetric, 'mahalanobis')
        % 计算协方差矩阵和其逆矩阵
        covarianceMatrix = cov(X);
        invCov = pinv(covarianceMatrix); % 使用pinv而不是inv以增加数值稳定性

        % 计算每个点的k个最近邻
        distM = zeros(n, n);
        for i = 1:n
            for j = 1:n
                diff = X(i, :) - X(j, :);
                distM(i, j) = sqrt(diff * invCov * diff');
            end
        end

        % 对距离矩阵进行排序并找到k个最近邻
        [sortedDist, sortedIdx] = sort(distM, 2);
        idx = sortedIdx(:, 2:k+1);
        dist = sortedDist(:, 2:k+1);
    else
        % 使用 knnsearch 计算每个点的k个最近邻
        [idx, dist] = knnsearch(X, X, 'K', k + 1, 'Distance', distanceMetric);
        idx = idx(:, 2:end);
        dist = dist(:, 2:end);
    end

    % 构建权重矩阵W
    W = zeros(n, n);
    for i = 1:n
        for j = 1:k
            if dist(i, j) < eps % 防止除以零或非常小的值
                dist(i, j) = eps;
            end
            W(i, idx(i, j)) = exp(-dist(i, j)^2);
            W(idx(i, j), i) = W(i, idx(i, j)); % 保证W是对称的
        end
    end

    % 构建对角矩阵D
    D = diag(sum(W, 2));

    % 构建拉普拉斯矩阵L
    L = D - W;

    % 计算广义特征值问题 L*v = λ*D*v
    [eigVec, eigVal] = eig(L, D);

    % 排序特征值
    [~, idx] = sort(diag(eigVal));
    eigVec = eigVec(:, idx);

    % 返回前d个非零特征向量
    Y = eigVec(:, 2:d+1);
end
