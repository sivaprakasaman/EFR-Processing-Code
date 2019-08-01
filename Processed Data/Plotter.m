%Plots Means and std of the average trials:

clear all
close all

%% Import data:

PLV = 0; %if 1, plot PLV, if 0, plot MAG


if PLV == 0

    load('SAM_MAG_all_m.mat');
    load('SQ25_MAG_all_m.mat');
    load('SQ50_MAG_all_m.mat');
    
    trials = SAM_MAG_all_means(:,1);
    
    means = [SAM_MAG_all_means(:,2),SQ25_MAG_all_means(:,2),SQ50_MAG_all_means(:,2)];
    stds = [SAM_MAG_all_means(:,3),SQ25_MAG_all_means(:,3),SQ50_MAG_all_means(:,3)];


%     means = [SAM_all_means(:,2),SQ25_all_means(:,2),SQ50_all_means(:,2)];
%     stds = [SAM_all_means(:,3),SQ25_all_means(:,3),SQ50_all_means(:,3)];


    
    ti = "MAG - Sum of 6 Harmonic MAGs, 10 Bootstraps";
    yl = "Sum of First 6 Harmonics (uV)";

else
   
    load('SAM_PLV_all_m.mat');
    load('SQ25_PLV_all_m.mat');
    load('SQ50_PLV_all_m.mat');
    
    trials = SAM_PLV_all_means(:,1);

    means = [SAM_PLV_all_means(:,2),SQ25_PLV_all_means(:,2),SQ50_PLV_all_means(:,2)];
    stds = [SAM_PLV_all_means(:,3),SQ25_PLV_all_means(:,3),SQ50_PLV_all_means(:,3)];
    
      
    ti = "PLV - Sum of 6 Harmonic PLVs, 10 Bootstraps";
    yl = "Sum of First 6 PLVs";

end



hold on

    scatter(trials,means(:,1),'b');
    scatter(trials,means(:,2),'r');
    scatter(trials,means(:,3),'g');
    errorbar(trials,means(:,1),stds(:,1),'b');
    errorbar(trials,means(:,2),stds(:,2),'r');
    errorbar(trials,means(:,3),stds(:,3),'g');
    
hold off
legend("SAM","SQ25","SQ50");
title(ti)
xlabel("Number of trials/polarity/subject")
ylabel(yl)

