clear
% نام فایل صوتی خود را وارد کنید
audioFilename = 'E:\mm\20240123_144908.m4a';

% خواندن فایل صوتی
[audioData, Fs_audio] = audioread(audioFilename);
% پارامترها
Fc = 50e3; % فرکانس حامل (50KHz)

% تولید سیگنال پیام
t_message = (0:length(audioData)-1) / Fs_audio ;
messageSignal = audioData';

% مدولاسیون DSB
dsbSignal = messageSignal .* cos(2 * pi * Fc * t_message);

% دمدولاسیون DSB
demodulatedDSB = dsbSignal .* cos(2 * pi * Fc * t_message);

%dsbپخش کردن صدا بعد از انجام دمدولاسیون
player=audioplayer(demodulatedDSB,Fs_audio);
play(player);