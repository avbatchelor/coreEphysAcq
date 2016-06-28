function [gain,freq,mode] = decodeTelegraphedOutput(data,gainCh,freqCh,modeCh)

%% Gain
gainOut = mean(data(:,gainCh));

if gainOut> 0        && gainOut< 0.75
    gain = 0.05;
elseif gainOut> 0.75 && gainOut< 1.25
    gain = 0.1;
elseif gainOut> 1.25 && gainOut< 1.75
    gain = 0.2;
elseif gainOut> 1.75 && gainOut< 2.34
    gain = 0.5;
elseif gainOut> 2.34 && gainOut< 2.85
    gain = 1;
elseif gainOut> 2.85 && gainOut< 3.34
    gain = 2;
elseif gainOut> 3.34 && gainOut< 3.85
    gain = 5;
elseif gainOut> 3.85 && gainOut< 4.37
    gain = 10;
elseif gainOut> 4.37 && gainOut< 4.85
    gain = 20;
elseif gainOut> 4.85 && gainOut< 5.34
    gain = 50;
elseif gainOut> 5.34 && gainOut< 5.85
    gain = 100;
elseif gainOut> 5.85 && gainOut< 6.37
    gain = 200;
elseif gainOut> 6.37 && gainOut< 6.85
    gain = 500;
end

%% freq 
freqOut  = mean(data(:,freqCh));

if freqOut > 0 && freqOut < 3
    freq = 1;
elseif freqOut > 3 && freqOut < 5
    freq = 2;
elseif freqOut > 5 && freqOut < 7
    freq = 5;
elseif freqOut > 7 && freqOut < 9
    freq = 10;
elseif freqOut > 9
    freq = 100;
end

%% Mode
modeOut = mean(data(:,modeCh));

if modeOut> 0 && modeOut< 1.5
    mode = 'I-Clamp Fast';
elseif modeOut> 1.5 && modeOut< 2.5
    mode = 'I-Clamp Normal';
elseif modeOut> 2.5 && modeOut< 3.5
    mode = 'I=0';
elseif modeOut> 3.5 && modeOut< 5
    mode = 'Track';
elseif modeOut> 5
    mode = 'V-Clamp';
end
