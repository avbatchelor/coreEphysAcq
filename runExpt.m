function runExpt(prefixCode,expNum,stimSetNum)

%% Get fly and experiment details from experimenter
newFly = input('New fly? ','s');
newCell = input('New cell? ','s');
[flyNum, cellNum, cellExpNum] = getFlyNum(prefixCode,expNum,newFly,newCell);
fprintf(['Fly Number = ',num2str(flyNum),'\n'])
fprintf(['Cell Number = ',num2str(cellNum),'\n'])
fprintf(['Cell Experiment Number = ',num2str(cellExpNum),'\n'])

%% Set meta data
exptInfo.prefixCode     = prefixCode;
exptInfo.expNum         = expNum;
exptInfo.flyNum         = flyNum;
exptInfo.cellNum        = cellNum;
exptInfo.cellExpNum     = cellExpNum;
exptInfo.dNum           = datestr(now,'YYmmDD');
exptInfo.exptStartTime  = datestr(now,'HH:MM:SS'); 
exptInfo.stimSetNum     = stimSetNum; 

%% Get fly details 
if strcmp(newFly,'y')
    getFlyDetails(exptInfo)
end

%% Setup camera 
[~, path, ~, ~] = getDataFileName(exptInfo);
videoPath = [path,'rawVideo\'];
if ~isdir(videoPath)
    mkdir(videoPath);
end
disp(videoPath)
input('Recording started? ','s');

%% Run pre-expt routines (measure pipette resistance etc.)
contAns = input('Run preExptRoutine? ','s');
if strcmp(contAns,'y')
    [~, path, ~, ~] = getDataFileName(exptInfo);
    path = [path,'\preExptTrials'];
    if ~isdir(path)
        mkdir(path);
    end
    preExptData = preExptRoutine(exptInfo);
else
    preExptData = [];
end

%% Run experiment with stimulus
contAns = input('Would you like to start the experiment? ','s');
if strcmp(contAns,'y')
    fprintf('**** Running Experiment ****\n')
    eval(['stimSet_',num2str(stimSetNum,'%03d'),...
        '(','exptInfo,','preExptData',')'])
end

%% Merge trials 
mergeTrials(exptInfo)

%% Backup data
% makeBackup
