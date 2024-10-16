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

% مدولاسیون DSB
dsbSignal = audioSignal .* cos(2*pi*Fc*t);

% اعمال اعوجاج غیرخطی بر روی سیگنال‌ها
dsbSignalDistorted = nonlinearChannel(dsbSignal);
%دمدولاسیون سیگنال اعوجج یافته DSB
dsbDemodulated = dsbSignalDistorted .* cos(2*pi*Fc*t);

%DSBپخش کردن صدا بعد از انجام دمدولاسیون 
player=audioplayer(dsbDemodulated,Fs_audio);
play(player);