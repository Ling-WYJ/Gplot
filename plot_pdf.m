function plot_pdf(pns)
    global place_positions;
    global transition_positions;
    % 解析pns结构体中的信息
    places = pns.global_places;
    transitions = pns.global_transitions;
    arcs = pns.incidence_matrix;

    % 绘制库所
    num_places = numel(places); % 使用 numel 获取库所总数
    place_positions = zeros(num_places, 2);
    radius = 10; % 设置一个较大的半径，确保库所分布均匀
    for i = 1:num_places
        angle = 2 * pi * (i-1) / num_places; % 计算每个库所的角度位置
        place_positions(i, :) = radius * [cos(angle), sin(angle)];
        plot(place_positions(i, 1), place_positions(i, 2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', 'w','MarkerEdgeColor', 'k');
        text(place_positions(i, 1) -0.5, place_positions(i, 2)-1, places(i).name, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle'); 
    end

    % 绘制变迁
    num_transitions = numel(transitions); % 使用 numel 获取变迁总数
    transition_positions = zeros(num_transitions, 2);
    for i = 1:num_transitions
        angle = 2 * pi * (i-1) / num_transitions + pi / num_transitions; % 计算每个变迁的角度位置，稍微偏移
        transition_positions(i, :) = radius * 0.8 * [cos(angle), sin(angle)];
        
        % 绘制矩形变迁
        width = 1; % 变迁矩形的宽度
        height = 2; % 变迁矩形的高度
        x = transition_positions(i, 1) - width / 2;
        y = transition_positions(i, 2) - height / 2;
        rectangle('Position', [x, y, width, height], 'FaceColor', 'w');
        text(transition_positions(i, 1)-0.2 , transition_positions(i, 2)+ 1.3, transitions(i).name, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
    
    end

    % 绘制弧线（带箭头）
    for i = 1:num_transitions
        for j = 1:num_places*2
            if j <= num_places
                if arcs(i, j) ~= 0
                    start_pos = place_positions(j, :);
                    end_pos = transition_positions(i, :);
                    draw_arrow(start_pos, end_pos, arcs(i,j));
                    
                end
               
            else
                if arcs(i, j) ~= 0
                    start_pos = transition_positions(i, :);
                    end_pos = place_positions(j - num_places, :);
                    draw_arrow(start_pos, end_pos, arcs(i,j));
                end
           end
          
        end
    end



     % 设置图形属性
    axis equal;
    axis([-radius-5, radius+5, -radius-5, radius+5]); % 设置绘图范围
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    title(pns.name);

end



