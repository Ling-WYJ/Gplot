function post_lines = collect_post(sim_result,trans_name,index)
    if ((sim_result.POST_exist(index)) && (sim_result.COMMON_POST))
        common_post = profile_common_post(trans_name);
        specific_post = trace_specific_post(trans_name);
        post_lines = cell(numel(common_post), 1);  % 初始化输出数组  
        post_lines{1} = 'common_post: ';    
        for i = 1:numel(common_post)
            post_lines{i+1} = common_post{i};
        end
        post_lines{numel(common_post) + 2} = '';
        post_lines{numel(common_post) + 3} = 'specific_post: ';
        for i = 1:numel(specific_post)
            post_lines{numel(common_post) + i + 3} = specific_post{i};
        end
       
    elseif (sim_result.POST_exist(index))
        specific_post = trace_specific_post(trans_name);
        post_lines = cell(numel(specific_post), 1);  
        post_lines{1} = 'specific_post: ';      
        for i = 1:numel(specific_post)
            post_lines{i + 1} = specific_post{i};
        end 
        
    elseif (sim_result.COMMON_POST)
        common_post = profile_common_post(trans_name);
        post_lines = cell(numel(common_post), 1);  
        post_lines{1} = 'common_post: ';  
        for i = 1:numel(common_post)
            post_lines{i + 1} =  common_post{i};
        end 
    end   
end    