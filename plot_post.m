function plot_post(pns, sim_result)
    hold on;
    global transition_positions;
    transitions = pns.global_transitions;
    num_transitions = numel(transitions);
    post_lines= profile_common_post('tA');
    
    % 创建一个初始隐藏的文本标签，用于显示提示信息
    post_label = text(0, 0, '', 'Visible', 'off', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 10,'Interpreter','none','BackgroundColor','#F5F5F5');
    
    % 获取所有 "POST" 文字的位置
    post_positions = get_post_positions(transition_positions);
    
    % 为每个 "POST" 文字添加鼠标悬停事件
    for i = 1:num_transitions
        post_pos = transition_positions(i, :) + [1.5, 0]; % "POST" 文字的位置
        post_h = text(post_pos(1), post_pos(2), 'POST', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 12, 'FontWeight', 'bold');
        set(post_h, 'ButtonDownFcn', {@show_post, post_label, post_lines, post_positions});
    end
    
    % 设置鼠标移动事件处理程序
    set(gcf, 'WindowButtonMotionFcn', {@mouse_move_callback_post, post_label, post_lines, post_positions});
end

function post_positions = get_post_positions(transition_positions)
    % 计算 "POST" 文字的位置
    post_positions = transition_positions + [1.5, 0]; % 假设 "POST" 文字在每个变迁文字的右侧
end

function show_post(~, ~, post_label, post_lines, ~)
    % 显示提示框
    x = post_label.UserData(1);
    y = post_label.UserData(2);
    post_label.String = post_lines;
    post_label.Position = [x, y];
    post_label.Visible = 'on';
end

function mouse_move_callback_post(~, ~, post_label, post_lines, post_positions)
    % 获取当前鼠标位置
    pt = get(gca, 'CurrentPoint');
    x = pt(1, 1);
    y = pt(1, 2);
    
    % 更新提示框位置
    post_label.UserData = [x, y];
    
    % 判断鼠标是否在 "POST" 文字附近
    near_post = check_if_near_post(x, y, post_positions);
    
    % 根据判断结果显示或隐藏提示框
    if near_post
        show_post([], [], post_label, post_lines, []);
    else
        post_label.Visible = 'off';
    end
end

function near_post = check_if_near_post(x, y, post_positions)
    % 遍历所有 "POST" 文字的位置，检查鼠标是否接近其中任何一个
    tolerance = 0.5; % 设置一个容错范围
    near_post = false;
    for i = 1:size(post_positions, 1)
        post_x = post_positions(i, 1);
        post_y = post_positions(i, 2);
        if norm([post_x, post_y] - [x, y]) < tolerance
            near_post = true;
            break;
        end
    end
end

