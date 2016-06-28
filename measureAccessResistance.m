function [holdingCurrent,accessResistance,membraneResistance,inputResistance] = measureAccessResistance(exptInfo,varargin)

[data,settings,~,trialMeta,~] = acquireTrial('v');
df = settings.sampRate.out/settings.sampRate.in;

holdingCurrent = mean(data.current(1:round(settings.pulse.Start/df)-1));

% Access Resistance
voltDiff = abs(max(data.voltage) - min(data.voltage));
baselineStart = round(settings.pulse.Start/df/2);
baselineEnd = round(settings.pulse.Start/df)-1;
baselineCurrent = mean(data.current(baselineStart:baselineEnd));
peakCurrent = max(data.current(baselineEnd:round(settings.pulse.End/df)));
currDiff = abs(peakCurrent - baselineCurrent);
accessResistance = 1000*voltDiff/currDiff;

% Membrane Resistance
pulseEnd = round(settings.pulse.End/df);
pulseMid = pulseEnd - 1000;
steadyCurrent = mean(data.current(pulseMid:pulseEnd));
currDiff = abs(steadyCurrent - baselineCurrent);
membraneResistance = 1000*voltDiff/currDiff;

inputResistance = accessResistance + membraneResistance;

% Save
[~, path, ~, idString] = getDataFileName(exptInfo);
filename = [path,'\preExptTrials\',idString,'accessResistance'];
save(filename,'data','exptInfo','trialMeta');