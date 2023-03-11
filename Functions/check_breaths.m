%% FUNCTIONS FOR THE ARTE_RESPIRATORY

% Check the number or breath
% check_breaths
% Arguments:
% - signal: n_breaths retrived by peak finder on filtered signal
% Returns:
% - answer: true if there number of signal is inside the range, False otherwise

function in_range = check_breaths(n_breaths)
    if(n_breaths <31 || n_breaths >4)
        in_range = true;
    else 
        in_range = false;
    end
end
