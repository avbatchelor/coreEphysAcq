function preExptData = preExptRoutine(exptInfo)
%{
PREEXPTROUTINE measures pipette resistance, seal resistance, access
resistance and resting voltage

Designed so that important parameters can be measured 
as the early part of patching progresses: from electrode in the bath (pipette R),
to seal (seal R) to whole cell recording (access R...) in v-clamp and finally with a measurement
of the resting voltage (Vm) upon the switch in I=0 prior to switching to I-clamp

INPUT
exptInfo  (struct)

OUTPUT
preExptData
fields:
.pipetteResistance
.sealResistance
.initialHoldingCurrent
.initialAccessResistance
.initialMembraneResistance
.initialInputResistance
.initialRestingVoltage

SUBFUNCTIONS CALLED:
measurePipetteResistance - used to measure pipette and seal R
measureAccessResistance  - used to measure Access, membrane and Input R.
acquireTrial -used to measure resting membrane voltage (run in I=0) and
saved

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
    % Save zeroCurrentTrial trial 
    [~, path, ~, idString] = getDataFileName(exptInfo);
    filename = [path,'\preExptTrials\',idString,'zeroCurrentTrial'];  
    save(filename,'data','exptInfo','trialMeta'); 
end