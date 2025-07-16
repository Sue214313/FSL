function SaveResultToExcel(y, x)
    % 文件名和工作表名称
    filename = 'run run run your code-metric.xlsx';
    sheet = 'LE-min';

    % 将向量 y 写入 Excel 文件
    xlswrite(filename,y',sheet, 'F2');  % 注意 y' 是为了确保数据按列写入

    % 创建一个表格，包含平均值字符串 x
    T = table({x}, 'VariableNames', {'cub'});

    % 检查文件是否存在
    if isfile(filename)
        % 读取现有数据
        existingData = readtable(filename, 'Sheet', sheet);

        % 确定新数据写入的起始位置
        startRow = size(existingData, 1) + 2;  % +2 因为需要跳过标题行和现有数据行
        range = ['A', num2str(startRow)];

        % 将新数据写入 Excel 文件
        writetable(T, filename, 'Sheet', sheet, 'Range', range, 'WriteVariableNames', false);
    else
        % 如果文件不存在，直接写入新数据
        writetable(T, filename, 'Sheet', sheet);
    end

    % 显示成功消息
    disp(['Data successfully written to ', filename]);
end
