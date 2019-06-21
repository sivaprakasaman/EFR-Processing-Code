function [floorx,floory] = getNoiseFloor(pos_all,neg_all,N,I,K,Fs)
%getNoiseFloor returns the noise floor using method outlined in...
%N = #of trials/polarity. Make sure to pass truncated pos and neg vectors
%I = #iterations
%K = #of distributions
    

    w_n = rand([N,1])*2*pi();
    w_m = rand([N,1])*2*pi();
   
    L = length(pos_all{N}); %Lengths should be the same    
    f = Fs*(0:(L/2))/L;
    len_f = length(f);
    
    %preallocating for speed lol
    nsum = zeros(I,len_f);
    
    %Calculate spectrograms for +/-
    
    for k = 1:K
        for i = 1:I
            for n=1:N
                %pos
                pos = cell2mat(pos_all{n});
                fft_pos = fft(pos)
                T = 1/Fs; %Sampling Period
                fft_pos_r(n,1:len_f) = (fft_pos/L)*exp(j*w_n(n));
                
                %neg
                neg = cell2mat(neg_all{n});
                fft_neg = fft(neg)
                T = 1/Fs; %Sampling Period
                L = length(neg);
                fft_neg_r(n) = (fft_neg/L)*exp(j*w_m(n));
                  
            end
            nsum(i) = 20*log10((sum(abs(fft_pos_r))+sum(abs(fft_neg_r))))/n; 
        end
        kfloor(k) = sum(nsum(i))/i;
    end
        
end

