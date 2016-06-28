function membraneResistance = measureMembraneResistance(data,settings)

    df = settings.sampRate.out/settings.sampRate.in; 
    
    % Access Resistance
    baselineStart = round(settings.pulse.Start/df/2);
    baselineEnd = round(settings.pulse.Start/df)-1;
    
    pulseEnd = round(settings.pulse.End/df);
    pulseMid = pulseEnd - 2000; 
    
    baselineVoltage = mean(data.voltage(baselineStart:baselineEnd));
    baselineCurrent = mean(data.current(baselineStart:baselineEnd));
    
    steadyVoltage = mean(data.voltage(pulseMid:pulseEnd));
    steadyCurrent = mean(data.current(pulseMid:pulseEnd));
    
    voltDiff = abs(steadyVoltage - baselineVoltage);
    currDiff = abs(steadyCurrent - baselineCurrent);
    
    membraneResistance = 1000*voltDiff/currDiff;
    
    if membraneResistance < 1000
        fprintf(['\nMembrane Resistance = ',num2str(membraneResistance),' MOhms'])
    else
        fprintf(['\nMembrane Resistance = ',num2str(membraneResistance/1000),' GOhms'])
    end


    