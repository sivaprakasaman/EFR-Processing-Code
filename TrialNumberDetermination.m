%Determining the Minimum #of trials to get good data, also does the
%averaging here instead of NEL
%Last Updated: Andrew Sivaprakasam, 06/19
%Similar lines to FFR_AnalysisCode

%List of things that I still need to do:
%   -Check gain value
%   -Randomly pool a set of n trials 
%   -Calculate the mean response
%   -FFT
%   -Remove Noise Floor
%   -Count Peaks
%   -Make plots

clear all;
close all;

%% Parameters:
Fs = 48828.125;%sampling rate
numtrials = 500; %Number of trials to pull per polarity
window = [0.1,1.3];
gain = 20000;

%% Load Files:
subject = "Q379";

folder = strcat("MH-2019_06_07-",subject,"_FFRpilot");
cd(folder);

SAM_data = load('p0002_FFR_SNRenvSAM_atn25.mat');
sq_25_data = load('p0003_FFR_SNRenvsq_25_atn25.mat');
sq_50_data =load('p0004_FFR_SNRenvsq_50_atn25.mat');

SAM_tot = SAM_data.data.AD_Data.AD_All_V;

sq25_tot = sq_25_data.data.AD_Data.AD_All_V;
sq50_tot = sq_50_data.data.AD_Data.AD_All_V;


%% Separate out the +/- polarities
ind = 1;
for i = 1:1:numtrials
    %Pos 
    SAM_pos{i} = SAM_tot{ind}(window(1)*Fs:window(2)*Fs)/gain;
    %Neg
    SAM_neg{i} = SAM_tot{ind+1}(window(1)*Fs:window(2)*Fs)/gain;
    
    ind = ind+2;
end

%Possibly separate all the odds and evens, and pool a random n from each
%set

%% Calculate the mean of all trials
%Setting this up in a way that should work well with the above logic 

%Here's the problem
sum_SAM = zeros([1,length(SAM_pos{i})]);
for i = 1:numtrials
    temp = SAM_pos{i} + SAM_neg{i};
    sum_SAM = sum_SAM + temp;
end 

mean_SAM = sum_SAM/(2*numtrials);
mean_SAM = mean_SAM - mean(mean_SAM);
%% FFT

mag_SAM_envresponse = fft(mean_SAM);
T = 1/Fs; %Sampling Period
L = length(mean_SAM);
P2 = abs(mag_SAM_envresponse/L);
P1_SAM = P2(1:L/2+1); 

f = Fs*(0:(L/2))/L;

plot(f,P1_SAM)

%% Calculate Noise Floor



% %% Random Sampling and Pairing Polarities
% 
% for i = 1:numtrials
%     [spectrox(i),spectroy(i),harmsum,];
%     
% end

