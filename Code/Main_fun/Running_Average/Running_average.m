clearvars -except filename pathname sigma mu
filename_notif=filename(1:end-4);
filename_result=['re-' filename_notif];
%% parameter
average_num=3;
%% initialization
y =(imreadstack([pathname '\SIM-Wiener\' filename_result '.tif'])); %observed data
y_flag=size(y,3);
if y_flag<3
    msgbox('Number of data frame is smaller than 3, Running-Average was turned off'); 
else
    Roling_average=zeros(size(y,1),size(y,2),size(y,3));
    tic
    for i = ceil((average_num-1)/2)+1:size(y,3)-floor((average_num-1)/2)
        Roling_average(:,:,i)=mean(y(:,:,i-ceil((average_num-1)/2):i+floor((average_num-1)/2)),3);
    end
    toc
    imwritestack(Roling_average,[pathname '\Running-Average\RunningAverage_' filename_notif '.tif']);
    disp('Running-Averaged Successfully');
end