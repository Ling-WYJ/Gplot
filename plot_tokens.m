function plot_tokens(sim_result)

    global PN;
    PN = sim_result;
    Ps = PN.No_of_places;
    HH_MM_SS = PN.HH_MM_SS;
    no_of_rows = size(PN.LOG, 1); 
    currentStateIdx = 1;
    % 初始化状态列表和当前状态索引
    start_time = PN.LOG(1, Ps+5);
    if (HH_MM_SS)  
        finishing_time{1} = string_HH_MM_SS(start_time);
    else 
        finishing_time{1} = num2str(start_time); 
    end
    current_markings{1} = PN.LOG(1, 1:Ps);
    state{1} = num2str(0);
    
    
    for i = 2:no_of_rows
        current_row = PN.LOG(i, :);
        fired_trans = current_row(Ps+1);
        if (fired_trans)
            state{end + 1} = num2str(current_row(Ps+2));
%             ETS_index = current_row(Ps+4); 
%             start_time = current_row(Ps+5);
            if (HH_MM_SS)  
                finishing_time{end + 1} = string_HH_MM_SS(current_row(Ps+6));
            else 
                finishing_time{end + 1} = num2str(current_row(Ps+6)); 
            end
% %        disp(' '); disp('Just before new state ....');
% %        print_statespace_enabled_and_firing_trans(ETS_index-1);
             current_markings{end + 1} = current_row(1:Ps); 
%             virtual_tokens = current_row(Ps+7:end); 
            
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         % change - 2 
%             if gt(len_ETS, ETS_index), 
%                 % disp(' '); 
%                 % disp(['Right after new state-', int2str(state), ' ....']);
%                 % prnss_enabled_and_firing_trans(ETS_index+1);
%                 % disp(' '); 
%             end;
%         % end of change -1 
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                    
        end
    end  
    % num_rows = length(current_markings);
    % for i = 1:num_rows
    %     current_row = current_markings{i}; % 提取第 i 行
    %     fprintf('行 %d: ', i);
    %     disp(current_row); % 输出当前行
    % end
    

    % 在图形窗口上添加文本框
    timeText = uicontrol('Style', 'text', 'String', ['Time: ' finishing_time{currentStateIdx}], ...
                      'Position', [150, 160, 150, 40], 'FontSize', 14);
    stateText = uicontrol('Style', 'text', 'String', ['State: ' state{currentStateIdx}], ...
                      'Position', [150, 100, 150, 40], 'FontSize', 14);
    markingText = uicontrol('Style', 'text', 'String', ['Marking: ' markings_string(current_markings{currentStateIdx})], ...
                      'Position', [150, 500, 150, 100], 'FontSize', 14);                  
    % 添加前一个状态按钮
    uicontrol('Style', 'pushbutton', 'String', 'Previous', ...
              'Position', [50, 30, 100, 40], ...
              'Callback', @prevStateCallback);

    % 添加后一个状态按钮
    uicontrol('Style', 'pushbutton', 'String', 'Next', ...
              'Position', [300, 30, 100, 40], ...
              'Callback', @nextStateCallback);
    update();          
    
              % 前一个状态按钮的回调函数
    function prevStateCallback(~, ~)
        % 减少当前状态索引
        if currentStateIdx > 1
            currentStateIdx = currentStateIdx - 1;
            update();
        end
    end

    % 后一个状态按钮的回调函数
    function nextStateCallback(~, ~)
        % 增加当前状态索引
        if currentStateIdx < length(finishing_time)
            currentStateIdx = currentStateIdx + 1;
            update();
        end
    end

    % 更新文本框中的状态
    function update()
        timeText.String = ['Time: ' finishing_time{currentStateIdx}];
        stateText.String = ['State: ' state{currentStateIdx}];
        markingText.String = ['Marking: ' markings_string(current_markings{currentStateIdx})];
        plot_markings(current_markings{currentStateIdx});
    end



end
                  