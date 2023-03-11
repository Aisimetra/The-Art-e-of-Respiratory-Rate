%% FUNCTIONS FOR THE ARTE_RESPIRATORY

function answer = forward_backward(data_filtered)
distance_forward = zeros(1,1);
c=1;
d=1;
        [pos_pks,pos_loc] = findpeaks(data_filtered,"MinPeakProminence",0.0001);
        [neg_pks,neg_loc] = findpeaks(-data_filtered,"MinPeakProminence",0.0001);
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
        for point=1:numel(neg_loc_forward)
            X = [pos_loc_forward(point),neg_pks_forward(point);neg_loc_forward(point),pos_pks_forward(point)];
            distance_forward(c, point) = pdist(X,'euclidean');
            if (mean(distance_forward(c,1))==0)
                distance_forward(c,:) =[];
            end
        end

   
for c= 1:(size(distance_forward,1)-1)
    if (distance_forward(c,1)==0)
        distance_forward(c,:) = [];
    end
end

%% eliminate the one that has euclidean distance minor than 1 point something
%punt in CHECKS if the are more that that
dim_check= size(distance_forward,2)+1;
distance_forward(1, dim_check)=1;

for channel= 1:(size(distance_forward,1)-1)
    for column = 2:size(distance_forward,2)
        if(distance_forward(channel, column)==0)
            distance_forward(channel, dim_check)=distance_forward(channel, dim_check);
        elseif(distance_forward(channel, column)< 400 )
            distance_forward(channel, dim_check)=0;
        end

    end
end



%% backward


%% BACKWARD

distance_backward = zeros(1,1);
c=1;
d=1;

        [pos_pks,pos_loc] = findpeaks(data_filtered,"MinPeakProminence",0.0001);
        [neg_pks,neg_loc] = findpeaks(-data_filtered,"MinPeakProminence",0.0001);
        % check if are odds and in that case make them even cutting the
        % last for forward
        number_total_peaks = numel(pos_pks) + numel(neg_pks);
        if(rem(number_total_peaks, 2) == 1) %dispari - odd
            if(numel(pos_pks)>numel(neg_pks))
                pos_pks_backward = pos_pks(:,1:(size(pos_pks,2)-1));
                pos_loc_backward = pos_loc(:,1:(size(pos_loc,2)-1));
                neg_pks_backward= neg_pks;
                neg_loc_backward = neg_loc;
            elseif(numel(pos_pks)<numel(neg_pks))
                neg_pks_backward = neg_pks(:,2:(size(neg_pks,2)));
                neg_loc_backward = neg_loc(:,2:(size(neg_loc,2)));
                pos_pks_backward = pos_pks;
                pos_loc_backward= pos_loc;
            end
        else
            pos_pks_backward= pos_pks;
            pos_loc_backward= pos_loc;
            neg_pks_backward= neg_pks;
            neg_loc_backward = neg_loc;
        end
        for point=1:numel(neg_loc_backward)
            X = [pos_loc_backward(point),neg_pks_backward(point);neg_loc_backward(point),pos_pks_backward(point)];
            distance_backward(c, point) = pdist(X,'euclidean');
        end
        c=c+1;
    

%%
for c= 1:(size(distance_backward,1)-1)
    if (distance_backward(c,1)==0)
        distance_backward(c,:) = [];
    end
end
%% eliminate the one that has euclidean distance minor than 1 point something
%punt in CHECKS if the are more that that
dim_check= size(distance_backward,2)+1;
distance_backward(1, dim_check)=1;
for channel= 1
    for column = 2:(size(distance_backward,2)-1)
        %disp(distance_backward(channel, column))
        if(distance_backward(channel, column)==0)
            distance_backward(channel, dim_check)=distance_backward(channel, dim_check);
        elseif(distance_backward(channel, column)< 400 )
            distance_backward(channel, dim_check)=0;
        end

    end
end
%% look at remaining channels
sizes_1 = size(distance_backward,2);
sizes_2 = size(distance_forward,2);
answer =  false;

% che that both are 0 so they have a distance more that the treeshold
    if(distance_backward(1,sizes_1)==1 && distance_forward(1,sizes_2)==1)
        answer =  true;

    end

end
