function pre_lines = collect_pre(sim_result,trans_name,index)
    if ((sim_result.PRE_exist(index)) && (sim_result.COMMON_PRE))
        common_pre = profile_common_pre(trans_name);
        specific_pre = trace_specific_pre(trans_name);
        pre_lines = cell(numel(common_pre), 1);  % 初始化输出数组  
        pre_lines{1} = 'common_pre: ';    
        for i = 1:numel(common_pre)
            pre_lines{i+1} = common_pre{i};
        end
        pre_lines{numel(common_pre) + 2} = '';
        pre_lines{numel(common_pre) + 3} = 'specific_pre: ';
        for i = 1:numel(specific_pre)
            pre_lines{numel(common_pre) + i + 3} = specific_pre{i};
        end
       
    elseif (sim_result.PRE_exist(index))
        specific_pre = trace_specific_pre(trans_name);
        pre_lines = cell(numel(specific_pre), 1);  
        pre_lines{1} = 'specific_pre: ';      
        for i = 1:numel(specific_pre)
            pre_lines{i + 1} = specific_pre{i};
        end 
        
    elseif (sim_result.COMMON_PRE)
        common_pre = profile_common_pre(trans_name);
        pre_lines = cell(numel(common_pre), 1);  
        pre_lines{1} = 'common_pre: ';  
        for i = 1:numel(common_pre)
            pre_lines{i + 1} =  common_pre{i};
        end 
    end   
end    