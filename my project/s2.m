clear
% نام فایل صوتی خود را وارد کنید
audioFilename = 'E:\mm\20240123_144908.m4a';

% خواندن فایل صوتی
[audioData, Fs_audio] = audioread(audioFilename);

% پارامترها برای سیگنال مثلثی
duration = length(audioData) / Fs_audio;
Fs_triangle = 2e3; % نرخ نمونه‌برداری برای سیگنال مثلثی (2 کیلوهرتز)
T_triangle = 1/Fs_triangle; % دوره سیگنال مثلثی

% ایجاد سیگنال مثلثی
t_triangle = 0:T_triangle:duration;
triangularSignal = sawtooth(2*pi*10*t_triangle, 0.5); % یک سیگنال مثلثی با فرکانس 10 هرتز

% تطبیق طول دو سیگنال
audioData = audioData(1:min(length(audioData), length(t_triangle)));
triangularSignal = triangularSignal(1:min(length(audioData), length(t_triangle)));

% نمودار سیگنال صوتی به مرور زمان
figure;
subplot(2, 2, 1);
plot((0:length(audioData)-1) / Fs_audio, audioData);
title('سیگنال صوتی به مرور زمان');
xlabel('زمان (ثانیه)');
ylabel('مقدار سیگنال');

% نمودار طیف فرکانسی سیگنال صوتی
subplot(2, 2, 2);
N_audio = length(audioData);
frequencies_audio = linspace(0, Fs_audio/2, N_audio/2);
Y_audio = fft(audioData);
magnitude_audio = 2/N_audio * abs(Y_audio(1:N_audio/2));
plot(frequencies_audio, magnitude_audio);
title('طیف فرکانسی سیگنال صوتی');
xlabel('فرکانس (هرتز)');
ylabel('مقدار طیف');

% نمودار سیگنال مثلثی به مرور زمان
subplot(2, 2, 3);
plot(t_triangle, triangularSignal);
title('سیگنال مثلثی به مرور زمان');
xlabel('زمان (ثانیه)');
ylabel('مقدار سیگنال');

% نمودار طیف فرکانسی سیگنال مثلثی
subplot(2, 2, 4);
N_triangle = length(triangularSignal);
frequencies_triangle = linspace(0, Fs_triangle/2, N_triangle/2);
Y_triangle = fft(triangularSignal);
magnitude_triangle = 2/N_triangle * abs(Y_triangle(1:N_triangle/2));
plot(frequencies_triangle, magnitude_triangle);
title('طیف فرکانسی سیگنال مثلثی');
xlabel('فرکانس (هرتز)');
ylabel('مقدار طیف');
