function [Yt, Q_set,Q_set_label,X]=MSNMclassifier1(S_set,S_set_label,Q_set,Q_set_label,nways)
restart = true;
while restart
    restart = false;
    W0 = MSNMtrain(S_set_label); % 更新连接矩阵
    [mt, ~] = size(Q_set);
    Yt = zeros(mt, 1);
    X = zeros(mt,1);
    adt = 100; % 最大查找次数
    for i = 1:mt
        sigm1 = 1;
        sigm1U = sigm1 * 3;
        sigm1L = sigm1 / 3;
        xt = Q_set(i, :);
        ud = MSNMtest(xt, S_set, S_set_label, sigm1, W0);
        [ud_pos, ~] = size(ud(ud > 0));
        for j = 1:adt
            if ud_pos ~= 1
                [sigm1, sigm1U, sigm1L] = SigAdapt(ud_pos, sigm1, sigm1U, sigm1L);
                [ud, ~] = MSNMtest(xt, S_set, S_set_label, sigm1, W0);
                [ud_pos, ~] = size(ud(ud > 0));
            end
            % if (ud_pos >= length(unique(S_set_label))-1||ud_pos==0)%ori
            if(ud_pos >= length(unique(S_set_label))-4||ud_pos==0)%&&j >=adt*0.02
                % 检测到新的类别，重新学习
                disp('检测到全新类别需要重新学习');
                restart = true;
                %disp('S_set size before adding new vector:');
                %disp(size(S_set));
                % 将当前的 Q_set(i, :) 直接添加到 S_set 中
                S_set = [S_set; Q_set(i, :)];
                S_set_label = [S_set_label; Q_set_label(i)];
                % 从 Q_set 和 Q_set_label 中移除该向量
                %disp('S_set size after adding new vector:');
                %disp(size(S_set));
                Q_set(i, :) = [];
                Q_set_label(i) = [];
                break;
            end
        end
        if restart
            % 若检测到新类别，跳出 for 循环，并重启 while 循环
            break;
        end
        % 分类决策
       new_ud = ud(:, nways + 1:end);
       sub_new_ud = new_ud(new_ud > 0); 
       if ~isempty(sub_new_ud)
          [~, c1] = max(sub_new_ud);
       else
          c1 = 0;
       end
       [~, c] = max(ud);
       if c1 > 0
         if c1* sub_new_ud(c1) > c * ud(c)
            Yt(i) = c1;
            X(i) =sub_new_ud(c1);
         else
            Yt(i) = c;
            X(i) = 1-ud(c);
         end
       else
         Yt(i) = c;
         X(i) = 1-ud(c);
       end
    end
end
