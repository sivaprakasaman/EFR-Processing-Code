%Plots Means and std of the average trials:

clear all
close all

%% Import data:

cond = 3;

load('SAM_all_m.mat');
load('SQ25_all_m.mat');
load('SQ50_all_m.mat');

trials = SAM_all_means(:,1);

means = [SAM_all_means(:,2),SQ25_all_means(:,2),SQ50_all_means(:,2)];
stds = [SAM_all_means(:,3),SQ25_all_means(:,3),SQ50_all_means(:,3)];

hold on

    scatter(trials,means(:,1),'b');
    scatter(trials,means(:,2),'r');
    scatter(trials,means(:,3),'g');
    errorbar(trials,means(:,1),stds(:,1),'b');
    errorbar(trials,means(:,2),stds(:,2),'r');
    errorbar(trials,means(:,3),stds(:,3),'g');
    
hold off
legend("SAM","SQ25","SQ50");
title("SNR (Sum of 6 Harmonic Magnitudes) of 5 'Chins' over number of trials")
xlabel("Number of trials/polarity/chin")
%ylabel("Sum of SNR (dB)/Magnitude (dB, arbitrary)")

ylabel("Sum of First 6 Harmonics (uV)")

