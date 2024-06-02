function plot_markings(markings)
    global PN;
    global place_positions;

    Ps = PN.No_of_places;
    old_markers = findobj(gca, 'Tag', 'petri_net_marking');
    delete(old_markers);
  

    % if markings is all zero (no tokens at all)
    if not(any(markings))
        return
    end
    
    start_pi = 1;
    stop_pi  = Ps;

    % convert token markings into a string for display
    %markings_str = '';
    for i = start_pi:stop_pi
        tokens = markings(i);
        if tokens
            if eq(tokens, 1)
                % tokens_nr_str = ''; % no need to print '1' before
                hold on;
                plot(place_positions(i, 1), place_positions(i, 2), 'o', 'MarkerSize', 8, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k','Tag', 'petri_net_marking');
       
            else
                % tokens_nr_str = int2str(tokens);
                hold on;
                text(place_positions(i, 1), place_positions(i, 2), num2str(tokens), 'FontSize', 12, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Color', 'k','Tag', 'petri_net_marking');
            end;
            % markings_str = [markings_str, tokens_nr_str, ...
            %     PN.global_places(i).name, ' + '];
        end; % if tokens,           
    end % for i = 1:Ps,

end
    

