function [f,P1] = getSpectMag(pos,neg,Fs,numtrials)
%Returns the mean raw spectral magnitude in dB
% Example:
%all_trials = converted pfile
% Fs0 = 48828.125; %sampling rate in
% Fs = 15e3; %resample to
% numtrials = 100; %Number of trials to pull per polarity
% window = [0.1,1.3];
% gain = 20e3;

%% Parameters
len = length(pos); %number of trials collected/polarity

%% Pool random odds and evens from separated trials

%since already separated, just need to pick a random set of n trials from
%1-length of total #

%THIS WON"T WORK UNLESS ABOVE SECTION IMAX is changed!
r_odds = randi([1,len],[numtrials,1]);
r_evens = randi([1,len],[numtrials,1]);

for i = 1:1:numtrials

     pos_r{i} = pos{r_odds(i)};
     neg_r{i} = neg{r_evens(i)};

end

%% Calculate the mean of all trials
%Setting this up in a way that should work well with the above logic

pos_sum = zeros([1,length(pos{1})]);
neg_sum = zeros([1,length(neg{1})]);

%Compute the averages of pos and neg polarities, remove DC, and get a sum
for i = 1:numtrials
    pos_sum = pos_r{i} + pos_sum;
end

mean_pos = (pos_sum-mean(pos_sum))/numtrials;

for i = 1:numtrials
    neg_sum = neg_r{i} + neg_sum;
end

mean_neg = (neg_sum-mean(neg_sum))/numtrials;

sum_all = mean_pos+mean_neg;
%% FFT
mag_envresponse = fft(sum_all*1e6);
L = length(sum_all);
P2 = 20*log10((abs(mag_envresponse/L)));
P1 = P2(1:L/2+1);

f = Fs*(0:(L/2))/L;

end

