%% FUNCTIONS FOR THE ARTE_RESPIRATORY

% Create heatmap to display active channel
% display_and_order
% Arguments:
% - matrix_with_data: matrix of data
% - dimension: needed to reshape and recreate the mattress
% - slice: necessary to create the file name
% - folder: folder where to save the plot
% Returns:
% - matrix_with_data: matrix composed by the data, the position of each data in original sort, the position with the ordered matrix.


function matrix_with_data = display_and_order(matrix_with_data, dimension, omini,slice,folder)

% save the position in the matrix for each data
for u=1:size(matrix_with_data,2)
    matrix_with_data(2,u)= u;
end

% sort the matrix with the data in the first line
[~, order] = sort(matrix_with_data(1,:));
matrix_with_data = matrix_with_data(:,order);

% new position of the data
for u=1:size(matrix_with_data,2)
    matrix_with_data(3,u)= u;
end

% order with the original one
[~, order] = sort(matrix_with_data(2,:));
matrix_with_data = matrix_with_data(:,order);
for u=1:size(matrix_with_data,2)
    if matrix_with_data(1,u)==0
        matrix_with_data(3,u)= matrix_with_data(3,(dimension*22));
    end
end

figure('visible','off');
subplot(1,2,1)
hat_handle = heatmap(transpose(reshape(omini(1,:), [],dimension)),'Colormap', jet,'CellLabelColor','none','ColorMethod','median');
clim(hat_handle,[0, 1]);
title('Active Channel in the mattres');
subplot(1,2,2)
hat_handle = heatmap(transpose(reshape(matrix_with_data(1,:), [],48)),'Colormap', jet,'CellLabelColor','white','ColorMethod','median');
clim(hat_handle,[0, 100]);
title('Useful Channels');
% sgtitle(['Display last instante on the mattress of ' num2str(round((slice/250)/60)) ' minute'])
% tit = [folder '/' num2str(round((slice/250)/60)) '_minute_full.png' ];
% saveas(gcf,tit)

end
