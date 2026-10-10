%% Signal Generation, Spectrum Analysis and Noise Filtering
% A beginner DSP project using base MATLAB 
% Steps: generate signal -> add noise -> FFT -> filter -> compare.

clear; clc; close all;

%% 1. Parameters
fs = 1000;              % sampling frequency (Hz)
t  = 0:1/fs:1-1/fs;     % 1 second of time samples
N  = length(t);
f1 = 50;                % first tone (Hz)
f2 = 120;               % second tone (Hz)

%% 2. Generate clean signal and add noise
clean = sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t);
noisy = clean + 0.8*randn(size(t));

%% 3. Frequency spectrum (single-sided FFT)
f = (0:N/2-1) * fs/N;                       % frequency axis
spectrum = @(x) abs(fft(x))/N*2;            % amplitude spectrum
S_clean = spectrum(clean);
S_noisy = spectrum(noisy);

%% 4. Filter 1: Moving average (simple smoothing)
win = 5;
y_ma = movmean(noisy, win);

%% 5. Filter 2: FIR low-pass filter (windowed-sinc, built by hand)
fc = 150;                       % cutoff frequency (Hz)
M  = 50;                        % filter order (even number)
n  = -M/2:M/2;
h  = (2*fc/fs) * sinc(2*fc/fs * n);         % ideal low-pass impulse response
w  = 0.54 + 0.46*cos(2*pi*n/M);             % Hamming window
h  = h .* w;
h  = h / sum(h);                            % unity gain at DC
y_fir = conv(noisy, h, 'same');

S_ma  = spectrum(y_ma);
S_fir = spectrum(y_fir);

%% 6. Plots
figure('Name','Time domain','Position',[100 100 900 700]);
subplot(4,1,1); plot(t, clean); title('Clean signal (50 Hz + 120 Hz)');
subplot(4,1,2); plot(t, noisy); title('Noisy signal');
subplot(4,1,3); plot(t, y_ma);  title(sprintf('Moving average filter (window = %d)', win));
subplot(4,1,4); plot(t, y_fir); title(sprintf('FIR low-pass filter (fc = %d Hz)', fc));
for k = 1:4, subplot(4,1,k); xlim([0 0.2]); xlabel('Time (s)'); ylabel('Amplitude'); grid on; end

figure('Name','Frequency domain','Position',[150 150 900 700]);
subplot(4,1,1); plot(f, S_clean(1:N/2)); title('Spectrum: clean');
subplot(4,1,2); plot(f, S_noisy(1:N/2)); title('Spectrum: noisy');
subplot(4,1,3); plot(f, S_ma(1:N/2));    title('Spectrum: moving average');
subplot(4,1,4); plot(f, S_fir(1:N/2));   title('Spectrum: FIR low-pass');
for k = 1:4, subplot(4,1,k); xlabel('Frequency (Hz)'); ylabel('Magnitude'); grid on; end

%% 7. Quantify the result (Signal-to-Noise Ratio)
snr = @(ref, x) 10*log10(sum(ref.^2) / sum((x-ref).^2));
fprintf('SNR noisy      : %.2f dB\n', snr(clean, noisy));
fprintf('SNR moving avg : %.2f dB\n', snr(clean, y_ma));
fprintf('SNR FIR LPF    : %.2f dB\n', snr(clean, y_fir));

%% 8. Save figures for the GitHub README
if ~exist('results','dir'), mkdir('results'); end
saveas(figure(1), fullfile('results','time_domain.png'));
saveas(figure(2), fullfile('results','frequency_domain.png'));
