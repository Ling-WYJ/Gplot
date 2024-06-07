function plot_pre(pns, sim_result)
    hold on;
    global transition_positions;
    transitions = pns.global_transitions;
    num_transitions = numel(transitions);
    filtered_lines = trace_specific_pre('tGen');
    
    % 创建一个初始隐藏的文本标签，用于显示提示信息
    label = text(0, 0, '', 'Visible', 'off', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 10,'Interpreter','none','BackgroundColor','#F5F5F5');
    
    % 获取所有 "PRE" 文字的位置
    pre_positions = get_pre_positions(transition_positions);
    
    % 为每个 "PRE" 文字添加鼠标悬停事件
    for i = 1:num_transitions
        pre_pos = transition_positions(i, :) - [1, 0]; % "PRE" 文字的位置
        h = text(pre_pos(1), pre_pos(2), 'PRE', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 12, 'FontWeight', 'bold');
        set(h, 'ButtonDownFcn', {@show_tooltip, label, filtered_lines, pre_positions});
    end
    
    % 设置鼠标移动事件处理程序
    set(gcf, 'WindowButtonMotionFcn', {@mouse_move_callback, label, filtered_lines, pre_positions});
end

function pre_positions = get_pre_positions(transition_positions)
    % 计算 "PRE" 文字的位置
    pre_positions = transition_positions - [1, 0]; % 假设 "PRE" 文字在每个变迁文字的左侧
end

function show_tooltip(~, ~, label, filtered_lines, ~)
    % 显示提示框
    x = label.UserData(1);
    y = label.UserData(2);
    label.String = filtered_lines;
    label.Position = [x, y];
    label.Visible = 'on';
end

function mouse_move_callback(~, ~, label, filtered_lines, pre_positions)
    % 获取当前鼠标位置
    pt = get(gca, 'CurrentPoint');
    x = pt(1, 1);
    y = pt(1, 2);
    
    % 更新提示框位置
    label.UserData = [x, y];
    
    % 判断鼠标是否在 "PRE" 文字附近
    near_pre = check_if_near_pre(x, y, pre_positions);
    
    % 根据判断结果显示或隐藏提示框
    if near_pre
        show_tooltip([], [], label, filtered_lines, []);
    else
        label.Visible = 'off';
    end
end

function near_pre = check_if_near_pre(x, y, pre_positions)
    % 遍历所有 "PRE" 文字的位置，检查鼠标是否接近其中任何一个
    tolerance = 0.5; % 设置一个容错范围
    near_pre = false;
    for i = 1:size(pre_positions, 1)
        pre_x = pre_positions(i, 1);
        pre_y = pre_positions(i, 2);
        if norm([x, y] - [pre_x, pre_y]) < tolerance
            near_pre = true;
            break;
        end
    end
end
