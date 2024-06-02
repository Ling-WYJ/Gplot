function gplot(pns,sim_result)
    % 创建图形窗口
    figure('units','normalized','outerposition',[0 0 1 1], 'Color', 'w');    
    hold on;
    plot_pdf(pns)
    plot_tokens(sim_result,pns);
    hold off;
end