clear
% نام فایل صوتی خود را وارد کنید
audioFilename = 'E:\mm\20240123_144908.m4a';

% خواندن فایل صوتی
[audioData, Fs_audio] = audioread(audioFilename);

Fc = 50e3; % فرکانس حامل

t=(0:length(audioData)-1)/Fs_audio;
audioSignal = audioData';
% تابع اعوجاج غیرخطی
nonlinearChannel = @(x) x.^3 + 0.5*x.^2;

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
fmSignalDistorted = nonlinearChannel(fmSignal);

fmDemodulated = zeros(size(fmSignalDistorted));
phase = 0;

for i = 2:length(fmSignalDistorted)
    delta_phi = angle(fmSignalDistorted(i)) - angle(fmSignalDistorted(i-1));
    fmDemodulated(i) = delta_phi / (2 * pi * t(i));
end
%FM کردن صدا بعد از انجام دمدولاسیون 
player=audioplayer(fmDemodulated,Fs_audio);
play(player);