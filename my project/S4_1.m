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

% دمدولاسیون AM
demodulatedAM = abs(amSignal) - 1;

%AMپخش صوت پس از دمدولاسیون
player=audioplayer(demodulatedAM,Fs_audio);
play(player);