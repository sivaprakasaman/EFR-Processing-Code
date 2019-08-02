%Determining the Minimum #of trials to get good data, also does the
%averaging here instead of NEL
%Last Updated: Andrew Sivaprakasam, 06/19
%Similar lines to FFR_AnalysisCode

%List of things that I still need to do:
%   -Check gain value +
%   -Randomly pool a set of n trials 
%   -Calculate the mean response
%   -FFT
%   -Remove Noise Floor
%   -Count Peaks
%   -Make plots
%   -Make this a function so you don't have to keep copying/pasting

clear all;
close all;

%% Parameters:
Fs0 = round(48828.125);%sampling rate in
Fs = 4e3; %resample to

iterations = 100;
window = [0.1,1.3];
gain = 20e3; %make this parametric at some point

%% Load Files:
subject = "Q379";

folder = strcat("MH-2019_06_07-",subject,"_FFRpilot");
cd(folder);

SAM_data = load('p0002_FFR_SNRenvSAM_atn25.mat');
sq_25_data = load('p0003_FFR_SNRenvsq_25_atn25.mat');
sq_50_data =load('p0004_FFR_SNRenvsq_50_atn25.mat');

SAM_tot = SAM_data.data.AD_Data.AD_All_V;
l_SAM = length(SAM_tot)/2; %number of trials collected/polarity

sq25_tot = sq_25_data.data.AD_Data.AD_All_V;
l_sq25 = length(sq25_tot)/2;

sq50_tot = sq_50_data.data.AD_Data.AD_All_V;
l_sq50 = length(sq50_tot)/2;

cd ../

fprintf('Files Loaded \n')
%% Number of iterations

%currently 1/5 of total trials

numtrials = l_SAM/5; %Number of trials to pull per polarity

%% Separate out the +/- polarities

ind = 1;

%Change numtrials to l_SAM/sq25/etc if pooling randomly!
for i = 1:1:l_SAM
    %Pos 
    temp = SAM_tot{ind}(round(window(1)*Fs0):round(window(2)*Fs0))/gain;
    SAM_pos{i} = resample(temp,Fs,round(Fs0));
    
    %Neg
    temp2 = SAM_tot{ind+1}(round(window(1)*Fs0):round(window(2)*Fs0))/gain;
    SAM_neg{i} = resample(temp2,Fs,round(Fs0));
    
    ind = ind+2;
end

fprintf('+/- Polarities Separated\n')

%% Calculate and average the mean raw Spectral Magnitudes 

for i = 1:iterations
    
    [f,SAM_MRS(i,:)] = getSpectMag(SAM_pos,SAM_neg,Fs,numtrials);
    fprintf('(Spectrum) Iteration %d of %d complete.\n',i,iterations )
    
end

SAM_MeanDFT = mean(SAM_MRS);

plot(f,SAM_MeanDFT)

%% Calculate Noise Floor

[floorx, floory] = getNoiseFloor(SAM_pos,SAM_neg,numtrials,100,10,Fs);

%% Plotting 
figure;
hold on
plot(floorx,SAM_MeanDFT)
plot(floorx,floory)
plot(floorx,SAM_MeanDFT-floory)
title('DFT with Noise Floor removed')
ylabel('SNR (dB)/Magnitude (dB, arbitrary)')
xlabel('Frequency')
xlim([0,2e3])
ylim([-60,max(SAM_MeanDFT-floory)+5])

legend('Raw Spectrum','Noise Floor','Adjusted')
hold off