%% FUNCTIONS FOR THE ARTE_RESPIRATORY

function [data_filtered, n_peaks] = wavelet_transform(data,plot_data, ground)
levelForReconstruction = [false,false,false,false,false,false,false,false,true,true,false,false,false];
    wt = modwt(data,'db2',12);
    mra = modwtmra(wt,'db2');
    F1 = sum(mra(levelForReconstruction,:),1);
    data_filtered = F1;
    n_peaks=numel(findpeaks(F1,"MinPeakProminence",0.0001));
    if plot_data
                figure()

        subplot(4,1,1)
        plot(data_filtered)
        findpeaks(F1,"MinPeakProminence",0.0001);
        title({sprintf('Filtered with waveleft')})
        xlabel('seconds');
        ylabel('Amplitude (MOWDT)');
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
    end
end

