%% FUNCTIONS FOR THE ARTE_RESPIRATORY

function answer = spike(data)
        % non ha spike
        answer=true;
    for count= 1:size(data,2)-100
        if(abs((max(data(count:count+100)-min(data(count:count+100)))))>0.07) % before wa 0.01

            answer=false;
        end
    end
end

