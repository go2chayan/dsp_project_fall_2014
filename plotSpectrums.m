function plotSpectrums(Specs,Fs,LegendText)
for idx=1:length(Specs)
    N = length(Specs{idx}); % Number of samples
    f = (Fs/N)*((0:N-1) - ceil(N/2))'; % Freq axis
    
    % Shift the signal
    specSft = fftshift(Specs{idx});
    
    % Plotting on log scale for better representation
    plot(f,specSft);
    hold on
end
hold off

ylabel('Spectral Estimate');
xlabel('Frequency (MHz)');
axis ([min(f),max(f),-0.0005,0.0005]);
legend(LegendText);

end