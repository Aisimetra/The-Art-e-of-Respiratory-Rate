%% FUNCTIONS FOR THE ARTE_RESPIRATORY

function [data_filtered,n_peaks] = sG_filter(data, plot_data,ground)

rd = 9;
fl = 2201;
data_filtered = sgolayfilt(data,rd,fl);
n_peaks = numel(findpeaks(data_filtered,"MinPeakProminence",0.0001));

if plot_data
    figure()
    subplot(4,1,1)
    plot(data_filtered)
    findpeaks(data_filtered,"MinPeakProminence",0.0001);
    title({sprintf('Filtered with sgolayfilt')})
    xlabel('seconds');
    ylabel('Amplitude (sgolayfilt)');
    xticks(0:1000:15000)
    xt = get(gca ,'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(((xt/250)),1))

    subplot(4,1,2)
    plot(data)
    title({sprintf(' Raw Data')})
    ylabel('RawData');
    xlabel('seconds');
    xticks(0:1000:15000)
    xt = get(gca ,'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(((xt/250)),1))

    subplot(4,1,3)
    plot(ground(5,:))
    title(sprintf('Flow'))
    xlabel('seconds');
    ylabel('Flow');
    xticks(0:1000:15000)
    xt = get(gca ,'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(((xt/250)),1))

    subplot(4,1,4)
    plot(ground(6,:))
    title(sprintf('RIP Flow'))
    xlabel('seconds');
    ylabel('RIP Flow');
    xticks(0:1000:15000)
    xt = get(gca ,'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(((xt/250)),1))
% 
%     tit = ['maybe_wrong_allign/' num2str(((slice-1)/250)/60) '_minute_ ' num2str(signal) '_channel_' num2str(passed(1,signal)) '_percentage.png' ] ;
%     saveas(gcf,tit)
end
end
