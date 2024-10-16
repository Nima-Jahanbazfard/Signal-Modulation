clear
% نام فایل صوتی خود را وارد کنید
audioFilename = 'E:\mm\20240123_144908.m4a';

% خواندن فایل صوتی
[audioData, Fs_audio] = audioread(audioFilename);
% پارامترها
Fc = 50e3; % فرکانس حامل (50KHz)
miu = 0.85; % ضریب مدولاسیون

% تولید سیگنال پیام
t_message = (0:length(audioData)-1) / Fs_audio ;
messageSignal = audioData';

% مدولاسیون AM
amSignal = (1 + miu * messageSignal) .* cos(2 * pi * Fc * t_message);
% مدولاسیون DSB
dsbSignal = messageSignal .* cos(2 * pi * Fc * t_message);

% مدولاسیون SSB (USB)
ssbSignal_usb = hilbert(messageSignal) .* exp(1i * 2 * pi * Fc * t_message);

% نمایش سیگنال‌ها
figure;

subplot(4, 1, 1);
plot(t_message, messageSignal);
title('سیگنال پیام');
xlabel('زمان (ثانیه)');
ylabel('مقدار سیگنال');

subplot(4, 1, 2);
plot(t_message, amSignal);
title('AM مدوله شده');
xlabel('زمان (ثانیه)');
ylabel('مقدار سیگنال');

subplot(4, 1, 3);
plot(t_message, dsbSignal);
title('DSB مدوله شده');
xlabel('زمان (ثانیه)');
ylabel('مقدار سیگنال');

subplot(4, 1, 4);
plot(t_message, real(ssbSignal_usb)); % نمایش بخش حقیقی USB
title('SSB مدوله شده (USB)');
xlabel('زمان (ثانیه)');
ylabel('مقدار سیگنال');

sgtitle('سیگنال‌های مدوله شده');
