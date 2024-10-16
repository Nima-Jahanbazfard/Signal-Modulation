% Define the parameters
filename = 'E:\mm\20240123_144908.m4a'; % Replace with the path to your audio file
[x, fs] = audioread(filename); % Read the audio file

% Define the noise power
P_noise = 10^(-5); % Noise power in W

% Generate the noise
n = sqrt(P_noise) * randn(size(x)); % Noise samples with specified power

% Add the noise to the audio signal
y = x + n;

% Calculate the SNR
SNR = snr(x, n);

% Calculate the spectrum of the original signal
X = fft(x);

% Calculate the spectrum of the signal with noise
Y = fft(y);

% Plot the spectrum of the original signal
figure;
frequencies = linspace(0, fs, length(X));
plot(frequencies, abs(X));
title('طیف فرکانسی سیگنال پیام بدون نویز');
xlabel('فرکانس (هرتز)');

% Plot the spectrum of the signal with noise
figure;
plot(frequencies, abs(Y));
title('طیف فرکانسی سیگنال پیام با نویز');
xlabel('فرکانس (هرتز)');

% Display the SNR
disp(['SNR: ' num2str(SNR) ' dB']);

