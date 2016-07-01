function preExptData = preExptRoutine(exptInfo)
%{
PREEXPTROUTINE



%}



%% Measure pipette resistance 
contAns = input('Would you like to measure pipette resistance? ','s');
if strcmp(contAns,'y')
    type = 'pipette'; 
    preExptData.pipetteResistance = measurePipetteResistance(exptInfo,type);
    fprintf(['\nPipette Resistance = ',num2str(preExptData.pipetteResistance),' MOhms\n\n'])
end

%% Measure seal resistance 
contAns = input('Would you like to measure seal resistance? ','s');
if strcmp(contAns,'y')
    type = 'seal';
    preExptData.sealResistance = measurePipetteResistance(exptInfo,type);
    fprintf(['\nSeal Resistance = ',num2str(preExptData.sealResistance/1000),' GOhms\n\n'])
end

%% Measure access and membrane resistance and holding current
fprintf('\n*****Switch off seal test, stay in voltage clamp****\n')
contAns = input('Would you like to measure access resistance? ','s');
if strcmp(contAns,'y')
    [preExptData.initialHoldingCurrent, preExptData.initialAccessResistance, preExptData.initialMembraneResistance, preExptData.initialInputResistance] = measureAccessResistance(exptInfo);
    fprintf(['\nHolding Current = ',num2str(preExptData.initialHoldingCurrent),' pA\n'])
    fprintf(['Access Resistance = ',num2str(preExptData.initialAccessResistance),' MOhms\n'])
    fprintf(['Membrane Resistance = ',num2str(preExptData.initialMembraneResistance),' MOhms\n\n'])
%     fprintf(['Input Resistance = ',num2str(preExptData.initialInputResistance),' MOhms\n\n'])
end


%% Measure resting voltage 
contAns = input('Would you like to run a trial in I=0? ','s');
if strcmp(contAns,'y')
    [data,~,~,trialMeta,~] = acquireTrial;
    preExptData.initialRestingVoltage = mean(data.voltage); 
    fprintf(['\nResting Voltage = ',num2str(preExptData.initialRestingVoltage),' mV\n\n'])
    % Save trial 
    [~, path, ~, idString] = getDataFileName(exptInfo);
    filename = [path,'\preExptTrials\',idString,'zeroCurrentTrial'];  
    save(filename,'data','exptInfo','trialMeta'); 
end