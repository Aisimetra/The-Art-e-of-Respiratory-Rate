%% ARTE RESPIRATORY

%{ Main script to start the analysis on mattress recording
    the script will run on a moving window 60 second long along all the recording given as input
    all the recording are 4 minute long
    60 second = 15000 samples
    250hz mattress
    input: mattress data and ground truth data already aligned
    output: matrix with the respiratory rate per minute in that period %}

% --- load data ---
% load ground truth data and data coming from the mattress
load('data.mat')

% --- rescale data ---
data = rescale(data,0,1);
data_ground = rescale(data_ground,0,1);

% --- folder where to save the plots ---
folder = "folder"

% flag if the ground truth have Respiration Rate
resp = true;

% --- choose the approch to be used ---
% 0 - binary with Savitz Golay filter
% 1 - binary with Waverightterai
% 2 - weighed with Savitz Golay filter
% 3 - weighed with Waveright

% --- level of confidence to be used ---
confidence = 80;

% --- level of confidence necessary to plot the channels ---
confidence_plot=90;

% --- plot the data  --
plot_data = false;


row=1;
% --- matrix to save the result ---
result_to_be_saved = zeros(1,1);

% --- window of 60 second ---
slice =15000;

% --- window is moving every minute, for a total of 4 time ---
for time=1:15000:45000
    % disp(time)
    % disp(num2str(((time-1)/250)/60))
    result_to_be_saved(row,1) = choose_approch(data(:,time:time+slice), data_ground(:,time:time+slice), 0, confidence, plot_data, resp, confidence_plot, time, folder);
    result_to_be_saved(row,2) = choose_approch(data(:,time:time+slice), data_ground(:,time:time+slice), 1, confidence, plot_data, resp, confidence_plot, time, folder);
    result_to_be_saved(row,3) = choose_approch(data(:,time:time+slice), data_ground(:,time:time+slice), 2, confidence, plot_data, resp, confidence_plot, time, folder);
    result_to_be_saved(row,4) = choose_approch(data(:,time:time+slice), data_ground(:,time:time+slice), 3, confidence, plot_data, resp, confidence_plot, time, folder);
    result_to_be_saved(row,5) = recreate_breath_groundtruth(data_ground(8,time+slice), factor_limitation);

    disp(['result from the ground truth ' num2str(recreate_breath_groundtruth(data_ground(8,time+slice)))])

    row = row+1;
end
disp('result for the chosen approach')
disp(result_to_be_saved)

