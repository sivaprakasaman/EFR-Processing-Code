%Take FFRs, process them, and calculate the cummulative sum of Harmonic
%Magnitudes. Should be generalized enough to run with any trial.
%Last Updated: Andrew Sivaprakasam, 6/2019

clear all;
close all;

%% Parameters:
Fs0 = round(48828.125);%sampling rate in
Fs = 4e3; %resample to

iterations = 100;
window = [0.1,1.3];
gain = 20e3; %make this parametric at some point

K_MRS = 100;
K_NF = 10;
I_NF = 100;

harmonics = 6;
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

cd ../

fprintf('Files Loaded \n')
%% Calculate the DFT for Responses

[SAM_f,SAM_DFT] = getDFT(SAM_tot,window,Fs,Fs0,gain,K_MRS,K_NF,I_NF);
[sq25_f,sq25_DFT] = getDFT(sq25_tot,window,Fs,Fs0,gain,K_MRS,K_NF,I_NF);
[sq50_f,sq50_DFT] = getDFT(sq50_tot,window,Fs,Fs0,gain,K_MRS,K_NF,I_NF);

figure;
hold on;
plot(SAM_f,SAM_DFT)
plot(sq25_f,sq25_DFT)
plot(sq50_f,sq50_DFT)
title('DFT with Noise Floor removed')
ylabel('SNR (dB)/Magnitude (dB, arbitrary)')
xlabel('Frequency')
xlim([0,2e3])
ylim([-60,max(SAM_MeanDFT-floory)+5])
legend('Raw Spectrum','Noise Floor','Adjusted')

hold off;
%% Get peaks and sum them

[SAM_SUM] = getSum(SAM_f,SAM_DFT,harmonics);


