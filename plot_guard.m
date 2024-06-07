function plot_guard(pns, sim_result) 
    hold on;
    global transition_positions;
    transitions = pns.global_transitions;
    num_transitions = numel(transitions);

    label = text(0, 0, '', 'Visible', 'off', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 10,'Interpreter','none','BackgroundColor','#F5F5F5');
    post_label = text(0, 0, '', 'Visible', 'off', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 10,'Interpreter','none','BackgroundColor','#F5F5F5');

    pre_positions = get_pre_positions(transition_positions);
    post_positions = get_post_positions(transition_positions);
    
    % 初始化结构体来存储不同变迁的 filtered_lines 和 post_lines
    transition_data = struct();

    for i = 1:num_transitions
        pre_pos = transition_positions(i, :) - [1.2, 0]; 
        post_pos = transition_positions(i, :) + [1.5, 0];
        if ((sim_result.PRE_exist(i)) || (sim_result.COMMON_PRE))
            transition_data(i).filtered_lines = collect_pre(sim_result,transitions(i).name,i);
            pre_h = text(pre_pos(1), pre_pos(2), 'PRE', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 12, 'FontWeight', 'bold');
            set(pre_h, 'ButtonDownFcn', {@show_tooltip, label, transition_data(i).filtered_lines, pre_positions});
        end
        if ((sim_result.POST_exist(i)) || (sim_result.COMMON_POST))
            transition_data(i).post_lines = collect_post(sim_result,transitions(i).name,i);
            post_h = text(post_pos(1), post_pos(2), 'POST', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 12, 'FontWeight', 'bold');
            set(post_h, 'ButtonDownFcn', {@show_tooltip, post_label, transition_data(i).post_lines, post_positions});
        end   
       
       
        
      
    end

    set(gcf, 'WindowButtonMotionFcn', {@mouse_move_callback, label, post_label, pre_positions, post_positions, transition_data});
end

function mouse_move_callback(~, ~, label, post_label, pre_positions, post_positions, transition_data)
    pt = get(gca, 'CurrentPoint');
    x = pt(1, 1);
    y = pt(1, 2);

    label.UserData = [x, y];
    post_label.UserData = [x, y];

    % Initialize indices for filtered and post lines
    filtered_idx = [];
    post_idx = [];

    % Check if mouse is near any "PRE" position
    for i = 1:size(pre_positions, 1)
        if check_if_near(x, y, pre_positions(i, :))
            filtered_idx = i;
            break;
        end
    end

    % Check if mouse is near any "POST" position
    for i = 1:size(post_positions, 1)
        if check_if_near(x, y, post_positions(i, :))
            post_idx = i;
            break;
        end
    end

    % Show tooltip if near "PRE" position
    if ~isempty(filtered_idx)
        show_tooltip([], [], label, transition_data(filtered_idx).filtered_lines, []);
    else
        label.Visible = 'off';
    end

    % Show tooltip if near "POST" position
    if ~isempty(post_idx)
        show_tooltip([], [], post_label, transition_data(post_idx).post_lines, []);
    else
        post_label.Visible = 'off';
    end
end



function show_tooltip(~, ~, label, filtered_lines, ~)
    % 显示提示框
    x = label.UserData(1);
    y = label.UserData(2);
    disp(label.UserData);

    label.String = filtered_lines;
    label.Position = [x, y];
    label.Visible = 'on';
end

function pre_positions = get_pre_positions(transition_positions)
    % 计算 "PRE" 文字的位置
    pre_positions = transition_positions - [1.2, 0]; % 假设 "PRE" 文字在每个变迁文字的左侧
end

function post_positions = get_post_positions(transition_positions)
    % 计算 "POST" 文字的位置
    post_positions = transition_positions + [1.5, 0]; % 假设 "POST" 文字在每个变迁文字的右侧
end

function near = check_if_near(x, y, positions)
    % 遍历所有位置，检查鼠标是否接近其中任何一个
    tolerance = 0.5; % 设置一个容错范围
    near = false;
    for i = 1:size(positions, 1)
        pos_x = positions(i, 1);
        pos_y = positions(i, 2);
        if norm([x, y] - [pos_x, pos_y]) < tolerance
            near = true;
            break;
        end
    end
end