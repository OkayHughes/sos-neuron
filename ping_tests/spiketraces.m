function [timevec,traces,traces_all] = spiketraces(num,spiketimes)

% timestamps=[-1.22 0.33 0.34 0.35 0.40 3.70 7.30]; % sec
% timestamps2=timestamps+2;
% timestamps = [timestamps; timestamps2];

srate=10;      % number of time points per msec 
min_timevec=50;  % msec
max_timevec=200;   % msec
sigma=2;       % msec standard deviation of gaussian
peak=1;  %value of the peak of the gaussian (use peak=0 for gaussian 
%       integral = 1; thus sum(trace) is equal to the number of spikes) 
 
traces = zeros(num,(max_timevec-min_timevec)*srate+1);
 
 for i = 1:num
    stimes=spiketimes(spiketimes(:,2)==i,1);
    [trace,timevec,~]=spikegauss(stimes,srate,min_timevec,max_timevec,sigma,peak);
    traces(i,:) = trace';

%      figure(3)
%      subplot(2,1,1)
%      hold on
%      plot(timevec,traces(i,:))

 end

 traces_all = mean(traces);
%  subplot(2,1,2)
%  plot(timevec,traces_all)
%  figure(3); hold off;
 
 

end