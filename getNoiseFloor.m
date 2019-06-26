function [floorx,floory] = getNoiseFloor(pos_all,neg_all,N,I,K,Fs)
%getNoiseFloor returns the noise floor using method outlined in...
%N = #of trials/polarity. Make sure to pass truncated pos and neg vectors
%I = #iterations
%K = #of distributions
    L = length(pos_all{1}); %Lengths should be the same    
    f = Fs*(0:(L/2))/L;
    len_f = length(f);
    
    %preallocating for speed lol
    nsum = zeros(I,len_f);
    kfloor = zeros(K,len_f);
    fft_pos_r = zeros(N,floor(L/2)+1);
    fft_neg_r = zeros(N,floor(L/2)+1);
    
    %Calculate spectrograms for +/-
    
    for k = 1:K
        tic;
        for i = 1:I
            for n=1:N
                w_n = rand([N,1])*2*pi();
                w_m = rand([N,1])*2*pi();
                
                %pos
                pos = pos_all{n};
                fft_pos = fft(pos*1e6);
                fft_pos_r_twoside = abs((fft_pos/L)).*exp(j.*w_n); %twosided FFT
                fft_pos_r(n,:) = fft_pos_r_twoside(1:floor(L/2)+1); %onesided FFT
                %make sure you check sidedeness and account for it!
                
                %neg
                neg = neg_all{n};
                fft_neg = fft(neg*1e6);
                L = length(neg);
                fft_neg_r_twoside = abs((fft_neg/L)).*exp(j.*w_m); %twosided FFT
                fft_neg_r(n,:) = fft_neg_r_twoside(1:floor(L/2)+1); %onesided FFT          
            end
            i
            nsum(i,:) = abs((sum(fft_pos_r)+sum(fft_neg_r))/N); %removed taking magnitude of a sum of magnitudes?*
        end
        kfloor(k,:) = sum(nsum)/I;
        k
        toc;    
    end
    
    floory = sum(kfloor)/K;
    floorx = f;
end

