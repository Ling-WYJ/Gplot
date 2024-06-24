function gplot(pns,sim_result,set_of_places)
    % 创建图形窗口
    figure('units','normalized','outerposition',[0 0 1 1], 'Color', 'w');   
    t = tiledlayout(1, 2, 'Padding', 'compact', 'TileSpacing', 'compact');
    title(t, pns.name,'FontSize',20); 
    global axl;
    global axr;
    axr = nexttile(t, 2); 
    hold(axr, 'on');
    plot_pdf(pns);
    plot_guard(pns,sim_result);
    axis(axr, 'off');
    

    axl = nexttile(t, 1); 
    hold(axl, 'on');
    plot_tokens(sim_result,set_of_places);
    axis(axl, 'off');
    hold off;
end

