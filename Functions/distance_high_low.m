%% FUNCTIONS FOR THE ARTE_RESPIRATORY

% Script to plot the ground truth
% distance_high_low
% Arguments:
% - data: data to be analysed
% - plot_data: true/false
% Return:
% - distance_x_axis: distanca between peaks/vally on x axis
% - distance_y_axis: distanca between peaks/vally on y axis

function [distance_x_axis,distance_y_axis] = distance_high_low(data,plot_data)

% distanza between valley and peaks on x asxis
distance_x_axis = zeros(1);
x_axis = zeros(1);
% distanza between valley and peaks on y asxis
distance_y_axis = zeros(1,1);
y_axis = zeros(1,1);
c=1;
for channel=1:(size(data,1))
    [pos_pks,pos_loc] = findpeaks(data,"MinPeakProminence",0.0001);
    [neg_pks,neg_loc] = findpeaks(-data,"MinPeakProminence",0.0001);
    % check if are odds and in that case make them even cutting the
    % last for forward
    number_total_peaks = numel(pos_pks) + numel(neg_pks);
    if(rem(number_total_peaks, 2) == 1) %dispari - odd
        if(numel(pos_pks)>numel(neg_pks))
            pos_pks_forward = pos_pks(:,2:(size(pos_pks,2)));
            pos_loc_forward = pos_loc(:,2:(size(pos_loc,2)));
            neg_pks_forward = neg_pks;
            neg_loc_forward = neg_loc;
        elseif(numel(pos_pks)<numel(neg_pks))
            neg_pks_forward = neg_pks(:,1:(size(neg_pks,2)-1));
            neg_loc_forward = neg_loc(:,1:(size(neg_loc,2)-1));
            pos_pks_forward = pos_pks;
            pos_loc_forward = pos_loc;
        end
    else
        pos_pks_forward = pos_pks;
        pos_loc_forward = pos_loc;
        neg_pks_forward = neg_pks;
        neg_loc_forward = neg_loc;
    end

    % change to create the two vectors x-axis,yaxis
    i=1;
    x_axis = sort(cat(2,neg_loc_forward , pos_loc_forward));
    for point=1:(size(neg_loc_forward,2)*2)
        if(rem(point,2)==1)
            y_axis(point) = neg_pks_forward(i);
        else
            y_axis(point) = pos_pks_forward(i);
            i=i+1;
        end
    end

    %distanza tra il primo e il successivo
    for point=1:(size(x_axis,2)-1)
        distance_x_axis(point) = abs(x_axis(point+1)) - abs(x_axis(point));
    end
    for point=1:(size(y_axis,2)-1)
        distance_y_axis(point) = abs(abs(y_axis(point+1)) - abs(y_axis(point)));
    end

    c=c+1;
    if(plot_data)
        figure()
        plot(data)
        title("Filtred")
        hold on
        plot(pos_loc,  pos_pks, '^r')
        plot(neg_loc, -neg_pks, 'vg')
        hold off
        grid
        xlabel('seconds');
        xticks(0:250:15000)
        xt = get(gca ,'XTick');
        set(gca, 'XTick', xt, 'XTickLabel', round(((xt/250)),1))
    end
end
end
