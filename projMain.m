%------------------------------------------------------------------
%  ECE 446 Computer Project 1 Fall 2014
%  Project Done by: M. Iftekhar Tanveer (itanveer@cs.rochester.edu)
%  This project was coded and tested in MATLAB R2014b
%  Please run the scripts in MATLAB 2014b for correct execution
%------------------------------------------------------------------
%
% Part 1: Plot spectrums of noises
%
function projMain
clc;clear;
Fs = 20; % Given in question. Mhz is assumed 

% Generate the noise signal
Noise = .05*(rand(512000,1)-.5);

% Estimate Spectrum
NoiseSpectrum2048 = EstimateSpectrum(Noise,1024,2048);

% Plot 64 Samples from the Spectrum
figure(1);
N_x = 64;
sftSpec = fftshift(NoiseSpectrum2048);
N = length(sftSpec); % Number of samples
N_2 = floor(N/2); % Center index
sftSpec = sftSpec(N_2-N_x:N_2+N_x-1); %Shift
% Plotting on log scale for better representation
plot(sftSpec);
ylabel('Spectral Estimate');
xlabel('Samples');
axis ([0,length(sftSpec),-0.0005,0.0005]);

% Additional spectrums of noise.
NoiseSpectrum1024 = EstimateSpectrum(Noise,512,1024);
NoiseSpectrum512 = EstimateSpectrum(Noise,256,512);
NoiseSpectrum256 = EstimateSpectrum(Noise,128,256);

% Plot all the Spectrums
figure(2);
plotSpectrums({NoiseSpectrum2048,NoiseSpectrum1024,NoiseSpectrum512, ...
    NoiseSpectrum256},Fs,{'NoiseSpectrum2048','NoiseSpectrum1024', ...
    'NoiseSpectrum512','NoiseSpectrum256'});

% -------------------------------------------------------------------
% Part 2: Noise passed through a LTI system: y[n] = x[n] - 0.9*x[n-1]
% -------------------------------------------------------------------
Rp = ShapeRandomProcess(Noise);
RpSpectrum2048=EstimateSpectrum(Rp,1024,2048);
RpSpectrum1024=EstimateSpectrum(Rp,512,1024);
RpSpectrum512=EstimateSpectrum(Rp,256,512);
RpSpectrum256=EstimateSpectrum(Rp,128,256);

figure(3);
plotSpectrums({RpSpectrum2048,RpSpectrum1024,RpSpectrum512, ...
    RpSpectrum256},Fs,{'NoiseSpectrum2048','NoiseSpectrum1024', ...
    'NoiseSpectrum512','NoiseSpectrum256'});
title('Spectrum of a White Noise after transformed by y[n] = x[n] - 0.9*x[n-1]')
axis([-10,10,0,max(RpSpectrum2048)]);

% -------------------------------------------------------------------
% Part 3: Analysis on Ashokan Farewell.wav
% -------------------------------------------------------------------
clc;clear;
figure(4);
[AF, Fs] = audioread('Ashokan Farewell.wav');
subplot(311)
PlotSpectra(AF(:,1),8192,16384,10);
title({'Spectograph of Ashokan Farewell','Skip = 8192, FFTsize = 16384'})
subplot(312)
PlotSpectra(AF(:,1),2048,4096,10);
title({'Spectograph of Ashokan Farewell','Skip = 2048, FFTsize = 4096'})
subplot(313)
PlotSpectra(AF(:,1),512,256,10);
title({'Spectograph of Ashokan Farewell','Skip = 512, FFTsize = 256'})
end