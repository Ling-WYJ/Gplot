function filtered_lines = trace_specific_pre(transition_name)
    % 构造文件名
    file_name = [transition_name, '_pre.m'];
    
    % 检查文件是否存在
    if ~isfile(file_name)
        error('File %s does not exist.', file_name);
    end
    
    % 打开文件读取
    fid = fopen(file_name, 'r');
    if fid == -1
        error('Could not open file %s.', file_name);
    end
    
    % 读取文件内容
    lines = {};
    while ~feof(fid)
        line = fgetl(fid);
        if ischar(line)
            lines{end+1} = line; %#ok<AGROW>
        end
    end
    
    % 关闭文件
    fclose(fid);
    
    % 过滤掉 function 语句和注释行
    filtered_lines = {};
    for i = 1:length(lines)
        line = strtrim(lines{i});
        if startsWith(line, 'function')
            continue;
        end
        if startsWith(line, 'disp')
            continue;
        end
        if startsWith(line, '%')
            continue;
        end
        code_line = remove_comments(lines{i});
        filtered_lines{end+1} = code_line; %#ok<AGROW>
    end

     % 打印执行过的代码行
     disp(['Executed lines in ', transition_name, '_pre:']);
    for i = 1:length(filtered_lines)
        disp(filtered_lines{i});
    end
end
