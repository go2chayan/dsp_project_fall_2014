%------------------------------------------------------------------
%  ECE 446 Computer Project 1 Fall 2014
%  Project Done by: M. Iftekhar Tanveer (itanveer@cs.rochester.edu)
%  This project was coded and tested in MATLAB R2014b
%  Please run the scripts in MATLAB 2014b for correct execution
%------------------------------------------------------------------
function dspcompProj2
h = FIR(pi/4,pi/2.5,6,9,0);
tDom = [zeros(121,1);h;zeros(120,1)]; % Time domain
fDom = real(fft(ifftshift(tDom)));    % Freq domain
fax = -pi:(2*pi/length(fDom)):pi-(2*pi/length(fDom)); % Freq axis
figure(1)
plot(fax,fDom)

hold on
h1=FIR(pi/4,pi/2.5,6,9,.025*pi);
tDom1 = [zeros(121,1);h1;zeros(120,1)];
fDom1 = real(fft(ifftshift(tDom1)));
plot(fax,fDom1)

h2=FIR(pi/4,pi/2.5,6,9,.050*pi);
tDom2 = [zeros(121,1);h2;zeros(120,1)];
fDom2 = real(fft(ifftshift(tDom2)));
plot(fax,fDom2)

h3=FIR(pi/4,pi/2.5,6,9,.075*pi);
tDom3 = [zeros(121,1);h3;zeros(120,1)];
fDom3 = real(fft(ifftshift(tDom3)));
plot(fax,fDom3)
hold off

xlabel('\omega')
ylabel('H(\omega)')
title('Frequency response of the FIR ideal lowpass filter')
legend({'\delta = 0','\delta = \pi/4','\delta = \pi/2','\delta = 3\pi/4'})

disp('Conclusion: Larger delta results in smaller overshoot')

figure(2);
w_box_car = Window(7,1,0,0)';
w_Hanning = Window(7,.5,-.5,0)';
w_Hamming = Window(7,.54,-.46,0)';
w_Blackman = Window(7,.42,-.5,.08)';
plot(w_box_car); 
hold on;
    plot(w_Hanning);
    plot(w_Hamming);
    plot(w_Blackman);
hold off
title('Various windows');
legend({'boxcar','Hanning','Hamming','Blackman'})

tDomBox = [zeros(121,1);w_box_car;zeros(120,1)]; % Time domain
tDomHan = [zeros(121,1);w_Hanning;zeros(120,1)]; % Time domain
tDomHam = [zeros(121,1);w_Hamming;zeros(120,1)]; % Time domain
tDomBlk = [zeros(121,1);w_Blackman;zeros(120,1)]; % Time domain

figure(3);
tax = (0:(2*pi/255):2*pi) - pi;
Hideal = 1.0*(abs(tax)<(pi/8 + pi/5));
h = real(fftshift(ifft(ifftshift(Hideal))))';
Hbox = fftshift(real(fft(fftshift(h.*tDomBox))));
HHan = fftshift(real(fft(fftshift(h.*tDomHan))));
HHam = fftshift(real(fft(fftshift(h.*tDomHam))));
Hblk = fftshift(real(fft(fftshift(h.*tDomBlk))));

hFIR=FIR(pi/4,pi/2.5,6,9,.098*pi);
tDom = [zeros(121,1);hFIR;zeros(120,1)]; % Time domain
fDom = real(fft(ifftshift(tDom)));    % Freq domain


plot(fax,Hbox);

hold on
plot(fax,HHan);
plot(fax,HHam);
plot(fax,Hblk);
plot(fax,fDom);

hold off
legend({'boxcar','Hanning','Hamming','Blackman','hFIR'});

disp('hFIR is more accurate than the other techniques');
end

function [h,w,Hw] = FIR(wp,ws,Np,Ns,delta)
M = (Np+Ns-1)/2;
% Building the frequency
wp = wp - delta;
ws = ws + delta;
wp_ = [((Np/2):-1:1)*(-2*wp/Np),0,(1:(Np/2))*(2*wp/Np)];
ws_l = -pi:(pi-ws)/floor(Ns/2):-ws-(pi-ws)/floor(Ns/2);
ws_r = ws+(pi-ws)/floor(Ns/2):(pi-ws)/floor(Ns/2):pi;
w = [ws_l,wp_,ws_r]' + pi;  
Hw = [zeros(1,length(ws_l)),ones(1,length(wp_)),zeros(1,length(ws_r))]';
[cols,rows] = meshgrid(-M:M,w);
Emat = exp(-j.*cols.*rows);
h = real(Emat\Hw);  % solution of the linear equation
% Debug
% subplot(311)
% stem(w,Hw)
% xlabel('\omega')
% ylabel('H(\omega)')
end

function h= Window(M,a,b,c)
n = -M:M;
h = a - b*cos(pi*n/(M+1)) + c*cos(2*pi*n/(M+1));
h = h.*(abs(n)<M);
end