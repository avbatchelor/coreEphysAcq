function stimSet_012(exptInfo,preExptData)

% To play a range of stimuli for 15um piezo

%% Set up and acquire with the stimulus set
numberOfStimuli = 21;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 3
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    stim = pickStimulus(trialMeta.stimNum);
    acquireTrial('i',stim,exptInfo,preExptData,trialMeta);
    if count == numberOfStimuli
        count = 1;
        stimRan = randperm(numberOfStimuli);
        repeat = repeat + 1;
    else
        count = count+1;
    end
end

end

function stim = pickStimulus(stimNum)
switch stimNum
    case 1
        stim = PipStimulus;
        stim.speaker = 2;
        stim.maxVoltage = 4; 
    case 2
        stim = Chirp;
        stim.speaker = 2;
        stim.maxVoltage = 4; 
        stim.startFrequency  = 400;
        stim.endFrequency    = 17;
        stim.mode = 'piezo';
    case 3
        stim = Chirp;
        stim.startFrequency  = 17;
        stim.endFrequency    = 400;
        stim.maxVoltage = 4;
        stim.mode = 'piezo';
    case 4
        stim = CourtshipSong;
        stim.speaker = 2;
        stim.maxVoltage = 4; 
    case 5
        stim = PulseSong;
        stim.speaker = 2;
        stim.maxVoltage = 4; 
    case 6
        stim = SquareWave;
        stim.speaker = 2;
        stim.maxVoltage = 4; 
    case num2cell(7:16)
        freqRange = 25.*sqrt(2).^((-1:8));
        stimNumStart = 7-1;
        freqNum = stimNum - stimNumStart;
        stim = SineWave;
        stim.carrierFreqHz = freqRange(freqNum);
        stim.maxVoltage = 4; 
    case num2cell(17:21)
        modFreqRange = 2.^(0:4);
        stimNumStart = 17-1;
        modFreqNum = stimNum - stimNumStart;
        stim = AmTone;
        stim.carrierFreqHz = 300;
        stim.modFreqHz = modFreqRange(modFreqNum);
        stim.maxVoltage = 4; 
end
end
