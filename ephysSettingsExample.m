function settings = ephysSettings(stim)

%% Parameters
% Data folder 
dataDirectory = 'C:\Users\Alex\My Documents\Data\ephysData\';

% Device
settings.devID = 'Dev1';

% Samp Rate
settings.sampRate.out   = stim.sampleRate;
settings.sampRate.in    = 10E3;

% Camera frame rate 
settings.camRate = 30; 

% Break out box 
settings.bob.currCh = 0;
settings.bob.voltCh = 1;
settings.bob.scalCh = 2;
settings.bob.gainCh = 3;
settings.bob.freqCh = 4;
settings.bob.modeCh = 5;
settings.bob.speakerCommandCh = 6;
settings.bob.piezoSGReading = 7;
settings.bob.aiType = 'SingleEnded';
settings.bob.inChannelsUsed  = [0:7];

% Current input settings
settings.current.betaRear   = 1; % Rear switch for current output set to beta = 100mV/pA
settings.current.betaFront  = 1; % Front swtich for current output set to beta = .1mV/pA
settings.current.sigCond.Ch = 1;
settings.current.sigCond.gain = 10;
settings.current.sigCond.freq = 5;
settings.current.softGain   = 1000/(settings.current.betaRear * settings.current.betaFront * settings.current.sigCond.gain);

% Voltage input settings
settings.voltage.sigCond.Ch = 2;
settings.voltage.sigCond.gain = 10;
settings.voltage.sigCond.freq = 5;
settings.voltage.softGain = 1000/(settings.voltage.sigCond.gain * 10); % To get voltage in mV

% Pulse settings
settings.pulse.Amp = 0.0394/2; % Made pulse a bit smaller 
settings.pulse.Dur = 1;
settings.pulse.Start = 1*settings.sampRate.out + 1;
settings.pulse.End = 2*settings.sampRate.out;
settings.pulse.Command = zeros(size(stim.stimulus));

