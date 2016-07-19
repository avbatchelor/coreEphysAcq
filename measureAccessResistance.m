function [holdingCurrent,accessResistance,membraneResistance,inputResistance] = measureAccessResistance(exptInfo,varargin)
%{
MEASUREACCESSRESISTANCE

Aquires a Trial of voltage clamp data obtained when the seal test is on 
and then use this response to calculate the accessResistance,
membraneResistance and inputResistance and also the holding current. The 
obtained trace is saved


INPUT
exptInfo (struct)

OUTPUT
holdingCurrent (pA) average current being injected to hold voltage
accessResistance (MOhms) calcluated as delta_V / delta_I transient
membraneResistance (MOhms) calcluated as delta_V / delta_I steady state
inputResistance (MOhms) sum of access and membrane resistance (?)

%}

[data,settings,~,trialMeta,~] = acquireTrial('v');
df = settings.sampRate.out/settings.sampRate.in;

holdingCurrent = mean(data.current(1:round(settings.pulse.Start/df)-1));

% Access Resistance
voltDiff = abs(max(data.voltage) - min(data.voltage));
baselineStart = round(settings.pulse.Start/df/2);
baselineEnd = round(settings.pulse.Start/df)-1;
baselineCurrent = mean(data.current(baselineStart:baselineEnd));
peakCurrent = max(data.current(baselineEnd:round(settings.pulse.End/df)));

% finds amplitude of transient current (deltaI trans)
currDiff = abs(peakCurrent - baselineCurrent);
accessResistance = 1000*voltDiff/currDiff; %MOhms

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