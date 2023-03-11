%% FUNCTIONS FOR THE ARTE_RESPIRATORY

function [passed,n_peaks,checkS,data_filtered] = checkS_weighed_wave(signal, signal_ground,plot_data)

checkS = zeros(1,1);

% check if is it part of the signal that are zero
checkS(size(checkS,2)) = check_partial_zero_signal(signal);

% check diff oscillation
[answer,answer_2,~] = oscillation(signal);
% is not in the correct intervall
checkS(size(checkS,2)+1) = answer*100;
checkS(size(checkS,2)+1) = answer_2;

% wavelet
[data_filtered, n_peaks] = wavelet_transform(signal,plot_data,signal_ground);

% check_breaths
answer = check_breaths(n_peaks);
checkS(size(checkS,2)+1) = answer*100;

% check the distance between x and y axis for valleys and peaks
[distance_x_axis,~]=distance_high_low(data_filtered,plot_data);

% check forward and backwarde
answer = forward_backward(data_filtered);
checkS(size(checkS,2)+1) = answer*100;
%snr
% Signal-to-noise ratio (SNR or S/N) is a measure used in science and engineering
% that compares the level of a desired signal to the level of background noise.
% SNR is defined as the ratio of signal power to the noise power, often expressed in decibels.
answer = snr_ratio(signal);
checkS(size(checkS,2)+1) = answer*100;

% distance between x_axis almost costant?
answer = distance_x_constant(distance_x_axis);
checkS(size(checkS,2)+1) = answer*100;

passed = sum(checkS,'all')/numel(checkS);


end




















