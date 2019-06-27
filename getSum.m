function [harmsum] = getSum(f,DFT,harmonics)
%getSum Outputs the sum of first 5 harmonics of a given .
%deviation. Also makes a plot.
%f = frequency vector
%DFT = DFT.
%harmonics = number of harmonics to pull 

[PKS, LOCS] = findpeaks(DFT,f,'MinPeakHeight',11,'MinPeakDistance',80);
PKS = PKS.*(LOCS>99);
harmsum = sum(PKS(1:harmonics));

%plot
%findpeaks(DFT,f,'MinPeakHeight',11,'MinPeakDistance',80)

end

