%% FUNCTIONS FOR THE ARTE_RESPIRATORY

% Script to plot the ground truth
% display_ground_truth
% Arguments:
% - data_ground: data from the ground display_ground_truth
% - resp: true if in the ground truth is present the respiration rate
% - folder: folder where to store the plot

% possible data from the ground truth to be displayed
% 'bedSyncPulse',
%  'bedSyncPulseCoun',
%  'ECG',
%  'Flow',
%  'Heart Rate',
%  'Nasal Pressure',
%  'Pulse',
%  'Resp Rate',
%  'RIP Flow',
%  'Channel 1',
%  'isbigendian',
%  'step',

function display_ground_truth(data_ground,resp, slice,folder)

if(resp)
    f = figure('visible','off');
    f.Position = [10 10 1050 600];
    subplot(4,1,1)
    plot(data_ground(4,:))
    title({sprintf('Flow')})
    xlabel('seconds');
    ylabel('Flow');
    xticks(0:1000:15000)
    xlim([0 15000])
    xt = get(gca ,'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(((xt/250)),1))

    subplot(4,1,2)
    plot(data_ground(6,:))
    title({sprintf(' Nasal Pressure')})
    ylabel('Nasal Pressure');
    xlabel('seconds');
    xticks(0:1000:15000)
    xlim([0 15000])

    xt = get(gca ,'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(((xt/250)),1))

    subplot(4,1,3)
    plot(data_ground(8,:))
    title(sprintf('Resp Rate'))
    xlabel('seconds');
    ylabel('rpm');
    xticks(0:1000:15000)
    xlim([0 15000])

    xt = get(gca ,'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(((xt/250)),1))
    %yticks(0.01:0.001:0.02)

    yt = get(gca ,'YTick');
    set(gca, 'YTick', yt, 'yTickLabel',(yt*(10^(3))))

    subplot(4,1,4)
    plot(data_ground(9,:))
    title(sprintf('RIP Flow'))
    xlabel('seconds');
    ylabel('RIP Flow');
    xticks(0:1000:15000)
    xlim([0 15000])

    xt = get(gca ,'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(((xt/250)),1))
    sgtitle(['Ground Truth of ' num2str(((slice/250)/60)) ' minute'])
%     tit = [folder '/' num2str(((slice/250)/60)) '_minute_ground.png' ] ;
%     saveas(gcf,tit)

else
    f = figure('visible','off');

    f.Position = [10 10 1050 600];
    subplot(3,1,1)
    plot(data_ground(9,:))
    title({sprintf('RIP Flow')})
    xlabel('seconds');
    ylabel('RIP Flow');
    xticks(0:1000:15000)
    xlim([0 15000])

    xt = get(gca ,'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(((xt/250)),1))

    subplot(3,1,2)
    plot(data_ground(4,:))
    title({sprintf(' Flow')})
    ylabel('Flow');
    xlabel('seconds');
    xticks(0:1000:15000)
    xlim([0 15000])

    xt = get(gca ,'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(((xt/250)),1))

    subplot(3,1,3)
    plot(data_ground(6,:))
    title(sprintf('Nasal Pressure'))
    xlabel('seconds');
    ylabel('Nasal Pressure');
    xticks(0:1000:15000)
    xlim([0 15000])

    xt = get(gca ,'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(((xt/250)),1))
    sgtitle(['Ground Truth of ' num2str(((slice/250)/60)) ' minute'])
%     tit = [folder '/' num2str(((slice/250)/60)) '_minute_ground.png' ] ;
%     saveas(gcf,tit)

end
end
