function [TOKEN_MATRIX] = plotp_time(simResults, set_of_places, time, plotCOLOR, plotLINEWIDTH)
    %        [TOKEN_MATRIX] = plotp(simResults, set_of_places, ...
    %                           plotCOLOR, plotLINEWIDTH)
    %           Plot the tokens on the places
    % Purpose:    
    % To plot how tokens change with time 
    % 
    % Arguments:
    % Inputs:    Simulation Results (the structure output by ‘gpensim’)
    %           {set_of_place_names}
    %           optional: plotCOLOR, plotLINEWIDTH, and time
    % Outputs:    TOKEN_MATRIX (contains tokens of places with time)
    % 
    % Functions used:    
    %       extractp  (extracts tokens from the SIM results structure)
    %
    % Used by:    [main simulation file]
    % 
    % Usage:    
    %   % in main simulation file
    %   sim = gpensim(png, dynamic);
    %   plotp_time(sim, {'p1','p2','p3'}, '12:00:00'); 
    %   plotp_time(sim, {'p1','p2','p3'}, '12:00:00', 'r', 10); 
    
    %  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    global PN;
    PN = simResults;
    
    TOKEN_MATRIX = extractp(set_of_places);
    [nr_rows, nr_columns] = size(TOKEN_MATRIX);
    
    time_series = TOKEN_MATRIX(2:nr_rows, 1); % skip place indices
    TOKENS = TOKEN_MATRIX(2:nr_rows, 2:nr_columns); % ONLY TOKENS
    
    % Calculate the maximum token value across the entire time series
    max_token_value = max(TOKENS(:));
    
    % Convert the time parameter to numeric format if it is in HH:MM:SS format
    if isfield(PN, 'HH_MM_SS') && PN.HH_MM_SS
        time_value = string_HH_MM_SS(time); % Assume this function exists
    else
        time_value = str2double(time);
    end
    
    % Identify the index up to which data should be displayed
    end_index = find(time_series <= time_value, 1, 'last');
    
    % Truncate the data to only include up to the end_index
    truncated_time_series = time_series(1:end_index);
    truncated_TOKENS = TOKENS(1:end_index, :);
    
    xunits = 'Time'; % initially
    if isfield(PN, 'HH_MM_SS')
        if (PN.HH_MM_SS)
            if gt(PN.completion_time, 60*60)
                xunits = [xunits ' in HOURS']; 
                truncated_time_series = truncated_time_series / (60*60);
                time_series = time_series / (60*60); % for x-axis
                time_value = time_value / (60*60);
            elseif gt(PN.completion_time, 60)
                xunits = [xunits ' in MINUTES']; 
                truncated_time_series = truncated_time_series / 60;
                time_series = time_series / 60; % for x-axis
                time_value = time_value / 60;
            else
                xunits = [xunits ' in SECS'];
            end
        end
    end
    
    disp(time_series);
    
    % Define a set of colors for plotting
    colors = lines(length(set_of_places)); % Use MATLAB's 'lines' colormap for distinct colors
    
    % Set default values for plotLINEWIDTH if not provided
    if nargin < 5
        plotLINEWIDTH = 1; % default line width
    end
    
    % Plot the truncated data with different colors for each place
    hold on;
    for i = 1:length(set_of_places)
        plot(truncated_time_series, truncated_TOKENS(:, i), ... % DEFAULT:: linewidth=.5, MarkerSize=10
            '-h', 'linewidth', plotLINEWIDTH, 'MarkerSize', 5, 'color', colors(i, :), 'DisplayName', set_of_places{i});
    end
    
    % Plot the complete x-axis range with invisible lines to ensure full x-axis range
    plot(time_series, zeros(size(time_series)), 'k.', 'MarkerSize', 1, 'HandleVisibility', 'off');
    
    % Set y-axis limits based on the maximum token value from the entire time series
    ylim([0, max_token_value]);
    
    grid on; grid minor; 
    legend('show'); xlabel(xunits); ylabel('Number of tokens');
    hold off;
    end
    
    function timeValue = string_HH_MM_SS(timeString)
        timeParts = sscanf(timeString, '%d:%d:%d');
        timeValue = timeParts(1) * 3600 + timeParts(2) * 60 + timeParts(3);
    end
    