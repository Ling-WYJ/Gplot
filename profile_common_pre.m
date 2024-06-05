function executed_lines = profile_common_pre(trans_name)
    % 启动profiler
    profile on;

    % 根据传入name包装成一个transition
    transition.name = trans_name;  % name of enabled trans
    transition.new_color = {};
    transition.override = 0; % by default - inherit
    transition.selected_tokens = []; 
    transition.additional_cost = 0; % by default: variable cost = 0

    % 调用COMMON_PRE函数
    [fire, newtrans] = COMMON_PRE(transition);

    % 停止profiler
    profile off;

    % 获取profiler收集的数据
    profData = profile('info');

    % 找到COMMON_PRE函数的调用记录
    commonPreIdx = findcalltree(profData.FunctionTable, 'COMMON_PRE');

    % 提取执行过的代码行
    if ~isempty(commonPreIdx)
        commonPreData = profData.FunctionTable(commonPreIdx);
        executed_lines = commonPreData.ExecutedLines;
        
        % 获取COMMON_PRE函数的源代码
        commonPreSrc = get_source_code('COMMON_PRE');
        
        % 过滤执行过的代码行，去除不满足条件的行
        executed_lines = filter_executed_lines(executed_lines, commonPreSrc);
    else
        executed_lines = [];
    end

    % 打印执行过的代码行
    disp('Executed lines in COMMON_PRE:');
    for i = 1:size(executed_lines, 1)
        disp(executed_lines(i, :));
    end
end

function idx = findcalltree(calltree, funcname)
    % 找到调用树中指定函数的索引
    idx = [];
    for i = 1:length(calltree)
        if strcmp(calltree(i).FunctionName, funcname)
            idx = i;
            break;
        end
    end
end

function src = get_source_code(funcname)
    % 获取函数的源代码
    % 这里假设函数源文件和函数名一致，并且在当前路径下存在
    filename = [funcname, '.m'];
    fid = fopen(filename, 'rt');
    src = {};
    if fid ~= -1
        tline = fgetl(fid);
        while ischar(tline)
            src{end+1} = tline;
            tline = fgetl(fid);
        end
        fclose(fid);
    end
end

function filtered_lines = filter_executed_lines(executed_lines, src)
    % 过滤执行过的代码行，去除不满足条件和包含'return'的行
    filtered_lines = [];
    for i = 1:size(executed_lines, 1)
        line_num = executed_lines(i, 1);
        code_line = strtrim(src{line_num});
        if ~startsWith(code_line, 'if') && ...
           ~startsWith(code_line, 'else') && ...
           ~startsWith(code_line, 'elseif') && ...
           ~startsWith(code_line, 'end') && ...
           ~contains(code_line, 'return')
            filtered_lines = [filtered_lines; executed_lines(i, :)];
        end
    end
end


