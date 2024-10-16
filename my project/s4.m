clear

% نام فایل صوتی خود را وارد کنید
audioFilename = 'E:\mm\20240123_144908.m4a';

% خواندن فایل صوتی
[audioData, Fs_audio] = audioread(audioFilename);

% پارامترها
Fc = 50e3; % فرکانس حامل (50KHz)
miu = 0.85; % ضریب مدولاسیون

% تولید سیگنال پیام
t_message = (0:length(audioData)-1) /1000 ;
messageSignal = audioData';

% مدولاسیون AM
amSignal = (1 + miu * messageSignal) .* cos(2 * pi * Fc * t_message);

% مدولاسیون DSB
dsbSignal = messageSignal .* cos(2 * pi * Fc * t_message);

% مدولاسیون SSB (USB)
ssbSignal_usb = hilbert(messageSignal) .* exp(1i * 2 * pi * Fc * t_message);

% دمدولاسیون AM
demodulatedAM = abs(amSignal) - 1;

% دمدولاسیون DSB
demodulatedDSB = dsbSignal .* cos(2 * pi * Fc * t_message);

% دمدولاسیون SSB (USB)
demodulatedSSB_usb = real(ssbSignal_usb);

% نمایش سیگنال‌های دمدوله شده
figure;
subplot(3, 1, 1);
plot(t_message, demodulatedAM);
title('AM دمدوله شده');
xlabel('زمان (ثانیه)');
ylabel('مقدار سیگنال');

subplot(3, 1, 2);
plot(t_message, demodulatedDSB);
title('DSB دمدوله شده');
xlabel('زمان (ثانیه)');
ylabel('مقدار سیگنال');

subplot(3, 1, 3);
plot(t_message, demodulatedSSB_usb);
title('SSB دمدوله شده (USB)');
xlabel('زمان (ثانیه)');
ylabel('مقدار سیگنال');

sgtitle('سیگنال‌های دمدوله شده');

% مقایسه سیگنال اصلی و دمدوله شده
figure;

subplot(3, 1, 1);
plot(t_message, messageSignal);
title('سیگنال پیام اصلی');
xlabel('زمان (ثانیه)');
ylabel('مقدار سیگنال');

subplot(3, 1, 2);
plot(t_message, demodulatedAM);
title('AM دمدوله شده');
xlabel('زمان (ثانیه)');
ylabel('مقدار سیگنال');

subplot(3, 1, 3);
plot(t_message, demodulatedDSB);
title('DSB دمدوله شده');
xlabel('زمان (ثانیه)');
ylabel('مقدار سیگنال');
sgtitle('مقایسه سیگنال اصلی و دمدوله شده');




