function [floorx,floory] = getNoiseFloor(pos_all,neg_all,N,I,K,Fs)
%getNoiseFloor returns the noise floor using method outlined in...
%N = #of trials/polarity. Make sure to pass truncated pos and neg vectors
%I = #iterations
%K = #of distributions
    L = length(pos_all{1}); %Lengths should be the same    
    f = Fs*(0:(L/2))/L;
    len_f = length(f);
    len = length(pos_all);
    %preallocating for speed lol
    nsum = zeros(I,len_f);
    kfloor = zeros(K,len_f);
    fft_pos_r = zeros(N,floor(L/2)+1);
    fft_neg_r = zeros(N,floor(L/2)+1);
    
    %Calculate spectrograms for +/-
    
    for k = 1:K
        tic;
        for i = 1:I
            
            %Draw N random trials/polarity
            r_odds = randi([1,len],[N,1]);
            r_evens = randi([1,len],[N,1]);
            
            for m = 1:1:N
                
                pos_r{m} = pos_all{r_odds(m)};
                neg_r{m} = neg_all{r_evens(m)};
                
            end
            
            
            for n=1:N
                w_n = rand([N,1])*2*pi();
                w_m = rand([N,1])*2*pi();
                
                %pos
                pos = pos_r{n};
                fft_pos = fft(pos*1e6);
                fft_pos_r_twoside = abs((fft_pos/L)).*exp(j.*w_n); %twosided FFT
                fft_pos_r(n,:) = fft_pos_r_twoside(n,1:floor(L/2)+1); %onesided FFT
                %make sure you check sidedeness and account for it!
                
                %neg
                neg = neg_r{n};
                fft_neg = fft(neg*1e6);
                L = length(neg);
                fft_neg_r_twoside = abs((fft_neg/L)).*exp(j.*w_m); %twosided FFT
                fft_neg_r(n,:) = fft_neg_r_twoside(n,1:floor(L/2)+1); %onesided FFT          
            end
            fprintf("(Noise Floor), %d th iteration, %d of %d spectral averages.\n",k,i,I)
            nsum(i,:) = 20*log10(abs((sum(fft_pos_r)+sum(fft_neg_r))/N)); %removed taking magnitude of a sum of magnitudes?*
        end
        kfloor(k,:) = sum(nsum)/I;
        k
        toc;    
    end
    
    floory = sum(kfloor)/K;
    floorx = f;
end

