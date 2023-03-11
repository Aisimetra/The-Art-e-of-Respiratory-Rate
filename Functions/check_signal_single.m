%% FUNCTIONS FOR THE ARTE_RESPIRATORY

% Check if there is no signal 
% check_signal_single
% Arguments:
% - signal: the signal to analyse
% Returns:
% - answer: True if there is signal, False otherwise

function answer = check_signal_single(data)
q=1;
for u = 2:size(data,2)
    if(data(1,u)==data(1,u-1))
        q = q + 1;
    end
end
if(q==(size(data,2)))
    answer = false;
else
    answer = true;
end
end
