function [floorx,floory] = getNoiseFloor_andrew(pos_all,neg_all,nTrials,nIter,nDist,fs)

%getNoiseFloor returns the noise floor using method outlined in...
%nTrials = #of trials/polarity. Make sure to pass truncated pos and neg vectors
%nIter = #iterations
%nDist = #of distributions
L = length(pos_all{1}); %Lengths should be the same
f = fs*(0:(L/2))/L;
len_f = length(f);
len = length(pos_all);
%preallocating for speed lol
nsum = zeros(nIter,len_f);
kfloor = zeros(nDist,len_f);

%Calculate spectrograms for +/-

for distVar = 1:nDist
    for iterVar = 1:nIter
        
        %Draw N random trials/polarity
        r_odds = randsample(len, nTrials, false); % false means without replacement
        r_evens = randsample(len, nTrials, false);
        
        pos_r= cell2mat(pos_all(r_odds)')' *1e6; % each column is a vector (also convert to uV)
        neg_r= cell2mat(neg_all(r_evens)')' *1e6;
        
        %         nfft= 2^nextpow2(size(pos_r,1));
        nfft= size(pos_r,1);
        
        fft_pos_r_twoside = abs(fft(pos_r, nfft)).*exp(1i*2*pi*rand(nfft, size(pos_r,2)))/L;
        fft_neg_r_twoside = abs(fft(neg_r, nfft)).*exp(1i*2*pi*rand(nfft, size(pos_r,2)))/L;
        %         fft_pos_r_twoside = abs(fft(pos_r, nfft)).*repmat(exp(1i*2*pi*rand(1, size(pos_r,2))), nfft, 1)/L;
        %         fft_neg_r_twoside = abs(fft(neg_r, nfft)).*repmat(exp(1i*2*pi*rand(1, size(pos_r,2))), nfft, 1)/L;
        nsum(iterVar,:)= 20*log10(abs(sum(fft_pos_r_twoside(1:floor(L/2)+1, :) + fft_neg_r_twoside(1:floor(L/2)+1, :), 2))/ nTrials);
    end
    kfloor(distVar,:) = sum(nsum,1)/nIter;
end

floory = sum(kfloor,1)/nDist;
floorx = f;
end

