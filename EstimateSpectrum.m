function Spectrum = EstimateSpectrum(x,skip,FFTsize)
if(size(x,1)<size(x,2))
    x=x';
end
N = length(x); % Length of the signal
N_Sec = floor(N/skip); % Total number of sections

% Cropping out the sections, calculating PSD
% and taking average of the PSD's
X_n = zeros(FFTsize,1);
for n = 1:N_Sec-1
    % Minimizing memory usage by not saving each section
    X_n = X_n + (abs(fft(x((1:FFTsize) + (n-1)*skip))).^2)/FFTsize;
end
Spectrum = X_n/N_Sec;
end

