%Determining the Minimum #of trials to get good data, also does the
%averaging here instead of NEL
%Last Updated: Andrew Sivaprakasam, 06/19
%Similar lines to FFR_AnalysisCode

clear all;
close all;

%% Parameters:
Fs = 48828.125;%sampling rate
numtrials = 50; %Number of trials to pull per polarity
window = [0.1,1.3];

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

ind = 1;
for i = 1:1:numtrials
    %Pos 
    SAM_pos{i} = SAM_tot{ind}(window(1)*Fs:window(2)*Fs);
    
    %Neg
    SAM_neg{i} = SAM_tot{ind+1}(window(1)*Fs:window(2)*Fs);
    
    ind = ind+2;
end



% %% Random Sampling and Pairing Polarities
% 
% for i = 1:numtrials
%     [spectrox(i),spectroy(i),harmsum,];
%     
% end

