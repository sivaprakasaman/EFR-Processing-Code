function [f,DFT] = getDFT(tot,window,Fs,Fs0,gain,K_MRS,K_NF,I_NF)
%getDFT - Returns f - frequency, and mean DFT with noise floor removed.
%   Assumtions: 
%   -Pull 1/5th of total trials to look at and average 

len = length(tot)/2; 
numtrials = len/5; %Number of trials to pull from/polarity

%% Separate out the +/- polarities

ind = 1;

%Change numtrials to l_SAM/sq25/etc if pooling randomly!
for i = 1:1:len
    %Pos 
    temp = tot{ind}(round(window(1)*Fs0):round(window(2)*Fs0))/gain;
    pos{i} = resample(temp,Fs,round(Fs0));
    
    %Neg
    temp2 = tot{ind+1}(round(window(1)*Fs0):round(window(2)*Fs0))/gain;
    neg{i} = resample(temp2,Fs,round(Fs0));
    
    ind = ind+2;
end

fprintf('+/- Polarities Separated\n')

%% Calculate Mean Raw Spectrum
for i = 1:K_MRS
    
    [f,MRS(i,:)] = getSpectMag(pos,neg,Fs,numtrials);
    fprintf('(Spectrum) Iteration %d of %d complete.\n',i,K_MRS)
    
end

MeanDFT = mean(MRS);

plot(f,MeanDFT)

%% Calculate Noise Floor

[~, floory] = getNoiseFloor(pos,neg,numtrials,I_NF,K_NF,Fs);

DFT = MeanDFT-floory;

end



