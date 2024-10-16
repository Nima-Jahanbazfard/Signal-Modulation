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

% مدولاسیون SSB (USB)
ssbSignal_usb = hilbert(messageSignal) .* exp(1i * 2 * pi * Fc * t_message);

%ssbuپخش کردن صدا بعد از انجام مدولاسیون
player=audioplayer(ssbSignal_usb ,Fs_audio);
play(player);