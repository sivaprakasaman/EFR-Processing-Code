function [outputArg1,outputArg2] = getSum(pFile,Fs0,Fs,numtrials,window,gain,harmonics)
%getSum Outputs the mean sum of first 5 harmonics and the standard
%deviation. Also makes a plot 
% pFile = pFile with the data you are using
% Fs0 = initial sample rate
% Fs = downsampled to 
% numtrials = number of trials you want to pull from data set
% window = [start stop] in seconds for truncation
% gain = usually 20k
% harmonics = number of harmonics to pull 
outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

