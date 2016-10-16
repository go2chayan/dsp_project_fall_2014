function player=runAF(skip,fftSize)
global player
AF=audioread('Ashokan Farewell.wav');
player = audioplayer(AF, 44100);
set(player,'TimerFcn','timerCallback','TimerPeriod',1);
Spectra =PlotSpectra(AF(:,1),skip,fftSize,10);
hold on;
play(player);