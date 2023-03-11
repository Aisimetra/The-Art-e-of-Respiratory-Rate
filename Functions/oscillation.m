%% FUNCTIONS FOR THE ARTE_RESPIRATORY

% in this case without label
function [answer,answer_2,diff_oscillation,aswer_binary] = oscillation(data)
diff_oscillation = max(data)-min(data);

%remove the channel over 0.0150 of oscillation
% amplitude of the signal is more than 0.01
answer=true;
if (diff_oscillation>0.015)
    answer=false;
elseif(diff_oscillation<0.009)
    answer=false;
end

%oscillazione quasi nulla in una parte, osservo la forma particoalre
%data dalle onde
save_o=0;
slice = 500; % 1 seconds
for u = 1:slice:(size(data,2)-slice)
    differences = mean(abs(diff(data(u:u+slice))));

    if(differences < 0.00001)
        save_o=save_o + 1;
    end

end

answer_2 = 100*((size(data,2)/slice)-save_o)/(size(data,2)/slice);
if (answer_2 >= 99)
    answer_2= 100;
end

if(save_o > 10)
    aswer_binary = false;
else
    aswer_binary = true;
end
end
