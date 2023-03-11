%% FUNCTIONS FOR THE ARTE_RESPIRATORY

% Script to decide which approach should be used, it returns the number of breath retrieved by the best channels
% choose_approch
% Arguments:
% - data: data from the mattress
% - data_ground: data from the ground display_ground_truth
% - approach:
%           0 - binary with Savitz Golay filter
%           1 - binary with Waveleft
%           2 - weighed with Savitz Golay filter
%           3 - weighed with Waveleft
% - confidence: level of confidence to select channel
% - plot_data: if plot or not the data from the function that allow it
% - resp: true if in the ground truth is present the respiration rate
% - confidence_plot: level of confidence to plot the data, usually higher than confidence
% - slice: dimension of window
% - folder: folder where to store the plot
% Returns:
% - answer: number of breaths calculated as the average of the obtained result of the best channels


function answer = choose_approch(data, data_ground, approch, confidence, plot_data, resp,confidence_plot, slice, folder)

% to save the checks passed for each channel
% 1 row - checks
% 2 row - peaks
% 3 row - channel
passed = zeros(3,1);
save_breath = zeros(1,1);

% --- to plot the active channels ---
omino = zeros(1,1);

for signal = 1: size(data,1)
    if(check_signal_single(data(signal,:)))
        omino(1,signal) = 0.5;
        if(spike(data(signal,:)))
            % store the useful data
            %  passed(3,signal) = signal;

            switch approch
                case 0
                    [passed(1,signal),passed(2,signal),~, data_filtered] = checkS_binary_sg(data(signal,:), data_ground,plot_data);


                case 1
                    [passed(1,signal),passed(2,signal),~,data_filtered] = checkS_binary_wave(data(signal,:), data_ground,plot_data);

                case 2
                    [passed(1,signal),passed(2,signal),~,data_filtered] = checkS_weighed_sg(data(signal,:),data_ground,plot_data);

                case 3
                    [passed(1,signal),passed(2,signal),~,data_filtered] = checkS_weighed_wave(data(signal,:),data_ground,plot_data);

            end

            if (passed(1,signal) >= confidence && save_breath(1,1) == 0)
                 disp(['Channel ' num2str(signal) ' has percentage of passed checks of ' num2str(passed(1,signal)) '% and retrieve ' num2str(passed(2,signal)) ' breaths'])
                 save_breath(1,size(save_breath,2))= passed(2,signal);

            elseif (passed(1,signal) >= confidence_plot && (approch==0 || approch==2))
                 disp(['Channel ' num2str(signal) ' has percentage of passed checks of ' num2str(passed(1,signal)) '% and retrieve ' num2str(passed(2,signal)) ' breaths'])
                 save_breath(1,size(save_breath,2)+1)= passed(2,signal);

            elseif (passed(1,signal) >= confidence_plot && (approch==1 || approch==3))
                 disp(['Channel ' num2str(signal) ' has percentage of passed checks of ' num2str(passed(1,signal)) '% and retrieve ' num2str(passed(2,signal)) ' breaths'])
                 save_breath(1,size(save_breath,2)+1)= passed(2,signal);
                
            elseif (passed(1,signal) >= confidence )
                 disp(['Channel ' num2str(signal) ' has percentage of passed checks of ' num2str(passed(1,signal)) '% and retrieve ' num2str(passed(2,signal)) ' breaths'])
                 save_breath(1,size(save_breath,2)+1)= passed(2,signal);

            end
        end
    end
end

disp('')
disp(['Breath retrieved from the channels that  have at least ' num2str(confidence) '%  ->' num2str(save_breath) '<-']); % newline ?
disp('')
disp(['Mean of the breath retrieved ' num2str(mean(save_breath))]);
answer = mean(save_breath);

% fill the last space to arrive to 1056
numeros=true;
while (numeros)
    if(size(passed,2)<1056)
        passed(1:2,size(passed,2)+1)=0;
    else
        numeros=false;
    end
end

% fill the last space to arrive to 1056
numeros=true;
while (numeros)
    if(size(omino,2)<1056)
        omino(1,size(omino)+1)=0;
    else
        numeros=false;
    end
end

display_and_order(passed, 48, omino, slice, folder);
display_ground_truth(data_ground, resp, slice, folder);


end
