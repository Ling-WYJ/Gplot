
function code_line = remove_comments(code_line)
    % 去除代码行中的注释部分
    comment_idx = strfind(code_line, '%');
    if ~isempty(comment_idx)
        code_line = strtrim(code_line(1:comment_idx(1)-1));
    end
end