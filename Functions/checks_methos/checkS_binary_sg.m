%% FUNCTIONS FOR THE ARTE_RESPIRATORY

function [passed,n_peaks_sg,checkS, data_filtered_sg] = checkS_binary_sg(signal, signal_ground,plot_data)

checkS = zeros(1,1);
% the data are pre-checked if the signal is zero or not or have spikes

% check if is it part of the signal that are zero
[~,~,checkS(size(checkS,2))] = check_partial_zero_signal(signal);

% spike in the signal
% checkS(size(checkS,2)) = spike(signal);

% check diff oscillation
[checkS(size(checkS,2)+1),~,~,checkS(size(checkS,2)+1)] = oscillation(signal);

%savitz golay filter
[data_filtered_sg,n_peaks_sg] = sG_filter(signal,plot_data, signal_ground);

% check_breaths
checkS(size(checkS,2)+1) = check_breaths(n_peaks_sg);

% check the distance between x and y axis for valleys and peaks
[distance_x_axis,~]=distance_high_low(data_filtered_sg,plot_data);

% check forward and backwarde
checkS(size(checkS,2)+1) = forward_backward(data_filtered_sg);

% snr
% Signal-to-noise ratio (SNR or S/N) is a measure used in science and engineering
% that compares the level of a desired signal to the level of background noise.
% SNR is defined as the ratio of signal power to the noise power, often expressed in decibels.
checkS(size(checkS,2)+1) = snr_ratio(signal);

% distance between x_axis almost costant?
checkS(size(checkS,2)+1) = distance_x_constant(distance_x_axis);

% percentage of passed checkS
passed = 100*sum(checkS,'all')/numel(checkS);
end
