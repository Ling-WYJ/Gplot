% function draw_arrow(start_pos, end_pos, weight)
%     % 计算箭头的方向向量
%     direction = end_pos - start_pos;
    
%     % 可以标准化方向向量以使所有箭头大小一致
%     norm_direction = direction / norm(direction);
    
%     % 设置箭头的大小
%     arrowSize = 0.5; % 可以调整箭头大小
%     headWidth = arrowSize; % 箭头的宽度
%     headLength = arrowSize; % 箭头的长度
    
%     % 计算箭头尖端和两侧翼尖的位置
%     arrowTip = end_pos;
%     arrowLeft = end_pos - headLength * norm_direction + ...
%                 headWidth / 2 * [-norm_direction(2), norm_direction(1)];
%     arrowRight = end_pos - headLength * norm_direction - ...
%                 headWidth / 2 * [-norm_direction(2), norm_direction(1)];
    
%     % 绘制箭头线条部分
%     line([start_pos(1), end_pos(1)], ...
%          [start_pos(2), end_pos(2)], 'Color', 'k', 'LineWidth', 1);
    
%     % 绘制实心三角形箭头
%     patch('XData', [arrowLeft(1), arrowTip(1), arrowRight(1)], ...
%           'YData', [arrowLeft(2), arrowTip(2), arrowRight(2)], ...
%           'FaceColor', 'k', 'EdgeColor', 'k');
    
%     % 计算弧线中点的位置
%     mid_pos = (start_pos + end_pos) / 2;
    
%     % 在弧线中点显示权重
%     text(mid_pos(1), mid_pos(2), num2str(weight), ...
%         'HorizontalAlignment', 'center', ...
%         'VerticalAlignment', 'bottom', ...
%         'FontSize', 15, 'Color', 'r');
% end


function draw_arrow(start_pos, end_pos, weight,from_place)
    % 计算箭头的方向向量
    direction = end_pos - start_pos;
    
    % 可以标准化方向向量以使所有箭头大小一致
    norm_direction = direction / norm(direction);
    
    % 设置箭头的大小
    arrowSize = 0.5; % 可以调整箭头大小
    headWidth = arrowSize; % 箭头的宽度
    headLength = arrowSize; % 箭头的长度
    
    
    
    % 计算新的起点位置（向内缩10）
    if(from_place)
        new_start_pos = start_pos + 0.4 * norm_direction;
        new_end_pos = end_pos - 0.8 * norm_direction;
    else
        new_start_pos = start_pos + 0.8 * norm_direction;
        new_end_pos = end_pos - 0.4 * norm_direction;
    end    

    % 计算箭头尖端和两侧翼尖的位置
    arrowTip = new_end_pos;
    arrowLeft = new_end_pos - headLength * norm_direction + ...
                headWidth / 2 * [-norm_direction(2), norm_direction(1)];
    arrowRight = new_end_pos - headLength * norm_direction - ...
                headWidth / 2 * [-norm_direction(2), norm_direction(1)];
    
    % 绘制箭头线条部分
    line([new_start_pos(1), new_end_pos(1)], ...
         [new_start_pos(2), new_end_pos(2)], 'Color', 'k', 'LineWidth', 1);
    
    % 绘制实心三角形箭头
    patch('XData', [arrowLeft(1), arrowTip(1), arrowRight(1)], ...
          'YData', [arrowLeft(2), arrowTip(2), arrowRight(2)], ...
          'FaceColor', 'k', 'EdgeColor', 'k');
    
    % 计算弧线中点的位置
    mid_pos = (new_start_pos + new_end_pos) / 2;
    
    % 在弧线中点显示权重
    text(mid_pos(1), mid_pos(2), num2str(weight), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'FontSize', 15, 'Color', 'r');
end
