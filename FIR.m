function h = FIR(wp,ws,Np,Ns,delta)
M = (Np+Ns-1)/2
wp_ = [((Np/2):-1:1)*(-2*wp/Np),0,(1:(Np/2))*(2*wp/Np)];
ws_l = -pi:(pi-ws)/floor(Ns/2):-ws-(pi-ws)/floor(Ns/2);
ws_r = ws+(pi-ws)/floor(Ns/2):(pi-ws)/floor(Ns/2):pi;
w = [ws_l,wp_,ws_r]';
Hw = [zeros(1,length(ws_l)),ones(1,length(wp_)),zeros(1,length(ws_r))]';

[cols,rows] = meshgrid(-M:M,w);
Emat = exp(-j.*cols.*rows)';    % I took transpose to make h real
h = real(Emat\Hw);
% subplot(311)
% stem(w,Hw)
% xlabel('\omega')
% ylabel('H(\omega)')
end