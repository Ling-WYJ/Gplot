function [markings_str] = markings_string (markings, range_of_indices)
    %        [markings_str] = markings_string (markings, range_of_indices)
    %
    % Converts tokens vector (markings) into a dsiplay string
    % E.g. : [0 1 0 3] becomes 'pB + 3pD' 
    
    %
    %   Reggie.Davidrajuh@uis.no (c) January 2012
    
    
    global PN
    Ps = PN.No_of_places;
    
    % if markings is all zero (no tokens at all)
    if not(any(markings))
        markings_str = '(no tokens)';
        return
    end
    
    if eq(nargin, 2) % range of places are given
        start_pi = range_of_indices(1);
        stop_pi  = range_of_indices(2);
    else
        start_pi = 1;
        stop_pi  = Ps;
    end
    
    % convert token markings into a string for display
    markings_str = '';
    for i = start_pi:stop_pi
        tokens = markings(i);
        if tokens
            if eq(tokens, 1)
                tokens_nr_str = ''; % no need to print '1' before
            else
                tokens_nr_str = int2str(tokens);
            end;
            markings_str = [markings_str, tokens_nr_str, ...
                PN.global_places(i).name, ' + '];
        end; % if tokens,           
    end % for i = 1:Ps,
    
    if not(isempty(markings_str))
        markings_str(end-1) = ' '; % clear the final '+' at the end
    end
    