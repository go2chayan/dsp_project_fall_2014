% MaxFreq is in KHz
function Spectra =PlotSpectra(x,skip,FFTsize,MaxFreq)
if(size(x,1)<size(x,2))
    x=x';
end
Fs = 44100/1024;
maxF_idx = floor(FFTsize*MaxFreq/Fs);

n_win = floor(length(x)/44100); % number of time windows
Spectra = [];
for idx = 1:n_win
    spec = EstimateSpectrum(x((1:(Fs*1024)) + (idx-1)*(Fs*1024)),skip,FFTsize);
    Spectra = [Spectra,spec(1:maxF_idx)];
end
Spectra = log(Spectra);
x = 0:(n_win-1);
y = (0:(maxF_idx-1))*Fs/FFTsize;
imagesc(x,y,Spectra);
colormap('Jet');
colorbar;
axis xy
ax = gca();
ax.XTick = min(x):25:max(x);
xlabel('Time (Sec)');
ylabel('Frequency (KHz)');