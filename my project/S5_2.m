clear
% نام فایل صوتی خود را وارد کنید
audioFilename = 'E:\mm\20240123_144908.m4a';

% خواندن فایل صوتی
[audioData, Fs_audio] = audioread(audioFilename);
t=(0:length(audioData)-1)/Fs_audio;
% تنظیمات
delta_f = 2e3; % اف دلتا (حداکثر تغییر فرکانس)
Fc = 50e3; % فرکانس حامل

% مدولاسیون FM
fmSignal = zeros(size(audioData));
phase = 0;

for i = 1:length(audioData)
    delta_phi = 2 * pi * delta_f * audioData(i) / Fs_audio;% محاسبه میشودfs,delta_f تغییر فاز به نسبت مقدار نقطه متناظر در audiodata
    phase = phase + delta_phi;%تجمع فازهای تغییر یافته 
    fmSignal(i) = cos(2 * pi * Fc * t(i) + phase);%با افزودن کسینوس سیگنال مدوله شده اف ام ساخته میشود
end

demodulatedFM = zeros(size(fmSignal));
phase = 0;

for i = 2:length(fmSignal)
    % از i=2 شروع می‌کنیم تا از اندیس 1 استفاده نکنیم
    %تا از اندیس‌های قبلی در محاسبات استفاده نشود
    delta_phi = angle(fmSignal(i)) - angle(fmSignal(i-1));%محاسبه فاز یا زاویه خوده سیگنال با سیگنال قبلیش
    demodulatedFM(i) = delta_phi / (2 * pi * t(i));
end

%FM کردن صدا بعد از انجام دمدولاسیون 
player=audioplayer(demodulatedFM,Fs_audio);
play(player);