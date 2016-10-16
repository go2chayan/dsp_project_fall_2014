function timerCallback()
global player
nSample=get(player,'currentSample');
plot(floor(nSample/44100)+1,1,'*w','LineWidth',8);