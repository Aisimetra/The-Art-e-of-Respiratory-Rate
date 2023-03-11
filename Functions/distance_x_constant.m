%% FUNCTIONS FOR THE ARTE_RESPIRATORY

% Check if the distance between the peaks and the valleys on x axis differ no more than 20 percent (more or less)
% distance_x_constant
% Arguments:
% - distance_x_axis: result from distance_hig_low()
% - plot_data: true/false


function answer = distance_x_constant(distance_x_axis)
distance = zeros(1,1);

for u = 1:size(distance_x_axis,2)-1
    distance(u) = abs(distance_x_axis(u) - distance_x_axis(u+1));
end
c=1;
for u = 1:2:size(distance,2)-1
    if((distance(u)<=(distance(u) + distance(u)*0.2)) || (distance(u)>=(distance(u) - distance(u)*0.2)))
        c=c+1;
    end
end

if(c>size(distance,2)/2)
    answer=true;

else
    answer=false;
end

%     answer_binary = 100*((size(data,2))-c)/size(data,2);
%     if (answer_binary >= 99)
%         answer_binary= 100;
%     end

end
