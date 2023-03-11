%% FUNCTIONS FOR THE ARTE_RESPIRATORY

% Check if there is no signal
% check_signal_single
% Arguments:
% - signal: the signal to analyse
% Returns:
% - answer: True if there is signal, False otherwise
% - aswer_binary: percetage of null input

function [answer,q,aswer_binary] = check_partial_zero_signal(data)
    q=1;
    for u = 2:size(data,2)
        if(data(1,u)==data(1,u-1))
            q = q + 1;
        end
    end
    
    % percentage of null input
    answer = 100*((size(data,2))-q)/size(data,2);
    if (answer >= 99)
        answer= 100;
    end

    aswer_binary = true;
    if(q> 1000)
        aswer_binary= false;
    end
end
