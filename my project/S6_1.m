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

% اعمال اعوجاج غیرخطی بر روی سیگنال‌ها
amSignalDistorted = nonlinearChannel(amSignal);

% دمدولاسیون
amDemodulated = abs(amSignalDistorted) - 1;

%AMپخش صوت پس از دمدولاسیون
player=audioplayer(amDemodulated,Fs_audio);
play(player);