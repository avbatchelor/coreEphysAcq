function pipetteResistance = measurePipetteResistance(exptInfo,type,varargin)
    
    [data,~,~,trialMeta,~] = acquireTrial;
    
    highVoltageLog1 = data.voltage > mean(data.voltage);
    
    allPulseStarts = strfind(highVoltageLog1',[0 1]);
    pulseStart = allPulseStarts(1) + 1;
    allPulseEnds = strfind(highVoltageLog1',[1 0]);
    pulseEnd = allPulseEnds(1); 
    if pulseEnd < pulseStart
        pulseEnd = allPulseEnds(2); 
    end     
    pulseEnd = pulseEnd - 3; 
    pulseMid = round(pulseEnd - ((pulseEnd - pulseStart)/2));

    troughStart = pulseEnd + 1; 
    troughEnd = allPulseStarts(2) -3 ;
    troughMid = round(troughEnd - ((troughEnd - troughStart)/2));
    
    peakCurrent = mean(data.current(pulseMid:pulseEnd));
    peakVoltage = mean(data.voltage(pulseMid:pulseEnd));
    baselineCurrent = mean(data.current(troughMid:troughEnd));
    baselineVoltage = mean(data.voltage(troughMid:troughEnd));
    
    voltDiff = peakVoltage - baselineVoltage;
    currDiff = peakCurrent - baselineCurrent; 
    
    pipetteResistance = ((voltDiff*1e-3)/(currDiff*1e-12))/1e6;  
    
    if nargin ~= 0 
        [~, path, ~, idString] = getDataFileName(exptInfo);
        switch type
            case 'pipette'
                filename = [path,'\preExptTrials\',idString,'pipetteResistance'];    
            case 'seal'
                filename = [path,'\preExptTrials\',idString,'sealResistance'];
        end
        save(filename,'data','exptInfo','trialMeta'); 
    end



