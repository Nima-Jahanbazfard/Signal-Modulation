clear
% نام فایل صوتی خود را وارد کنید
audioFilename = 'E:\mm\20240123_144908.m4a';

% خواندن فایل صوتی
[audioData, Fs_audio] = audioread(audioFilename);
miu = 0.85; % ضریب مدولاسیون
Fc = 50e3; % فرکانس حامل

t=(0:length(audioData)-1)/Fs_audio;
audioSignal = audioData';
% تابع اعوجاج غیرخطی
nonlinearChannel = @(x) x.^3 + 0.5*x.^2;

% مدولاسیون AM
amSignal =(1+miu*audioSignal)  .* cos(2*pi*Fc*t);

% مدولاسیون DSB
dsbSignal = audioSignal .* cos(2*pi*Fc*t);

% مدولاسیون FM
delta_f = 20; % اف دلتا (حداکثر تغییر فرکانس)
fmSignal = zeros(size(audioSignal));
phase = 0;

for i = 1:length(audioSignal)
    delta_phi = 2 * pi * delta_f * audioSignal(i) / Fs_audio;
    phase = phase + delta_phi;
    fmSignal(i) = cos(2 * pi * Fc * t(i) + phase);
end

% اعمال اعوجاج غیرخطی بر روی سیگنال‌ها
amSignalDistorted = nonlinearChannel(amSignal);
dsbSignalDistorted = nonlinearChannel(dsbSignal);
fmSignalDistorted = nonlinearChannel(fmSignal);

% نمایش سیگنال‌های مدوله شده
figure;
subplot(3, 1, 1);
plot(t, amSignal);
title('AM مدوله شده');

subplot(3, 1, 2);
plot(t, dsbSignal);
title('DSB مدوله شده');

subplot(3, 1, 3);
plot(t, fmSignal);
title('FM مدوله شده');

% نمایش سیگنال‌های مدوله شده و اعمال اعوجاج
figure;
subplot(3, 2, 1);
plot(t, amSignalDistorted);
title('AM مدوله شده و اعوجاج');

subplot(3, 2, 3);
plot(t, dsbSignalDistorted);
title('DSB مدوله شده و اعوجاج');

subplot(3, 2, 5);
plot(t, fmSignalDistorted);
title('FM مدوله شده و اعوجاج');

% دمدولاسیون
amDemodulated = abs(amSignalDistorted) - 1;
dsbDemodulated = dsbSignalDistorted .* cos(2*pi*Fc*t);
fmDemodulated = zeros(size(fmSignalDistorted));
phase = 0;

for i = 2:length(fmSignalDistorted)
    delta_phi = angle(fmSignalDistorted(i)) - angle(fmSignalDistorted(i-1));
    fmDemodulated(i) = delta_phi / (2 * pi * t(i));
end

% نمایش سیگنال‌های دمدوله شده
subplot(3, 2, 2);
plot(t, amDemodulated);
title('AM دمدوله شده');

subplot(3, 2, 4);
plot(t, dsbDemodulated);
title('DSB دمدوله شده');

subplot(3, 2, 6);
plot(t, fmDemodulated);
title('FM دمدوله شده');

% مقایسه سیگنال اصلی و دمدوله شده
figure;
subplot(3, 1, 1);
plot(t, audioSignal, 'g', t, amDemodulated, 'r--');
title('AM مقایسه سیگنال اصلی و دمدوله شده');
legend('سیگنال اصلی', 'AM دمدوله شده');

subplot(3, 1, 2);
plot(t, audioSignal, 'g', t, dsbDemodulated, 'r--');
title('DSB مقایسه سیگنال اصلی و دمدوله شده');
legend('سیگنال اصلی', 'DSB دمدوله شده');

subplot(3, 1, 3);
plot(t, audioSignal, 'g', t, fmDemodulated, 'r--');
title('FM مقایسه سیگنال اصلی و دمدوله شده');
legend('سیگنال اصلی', 'FM دمدوله شده');

