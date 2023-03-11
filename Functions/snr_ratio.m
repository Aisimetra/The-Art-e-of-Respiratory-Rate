%% FUNCTIONS FOR THE ARTE_RESPIRATORY

function answer = snr_ratio(data)
 if(snr(data,250)>2 && snr(data,250)<7)
     answer=true;
 else 
     answer=false;
 end
end

