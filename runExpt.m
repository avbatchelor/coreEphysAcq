function runExpt(prefixCode,expNum,stimSetNum)
%RUNEXPT master function that runs the Ephy acquisition
%
% RUNEXPT('ExperimentName',expNUM,stimSetNum) runs an experiment with prefix
% code 'ExperimentName' and experiment number expNUM that uses the stimlulus
% specified by stimSetNum
%
% INPUTS
% prefixCode
% expNum
% stimsetNum - number of the stimSet function you want to be run during this
% experiment
%
% OUTPUTS ----
% 
% Example
% runExpt('test',1,18)
% This would runs an experiment with a prefix code 'test' 
% and experiment number 1 which means the data is saved in a 
% folder called ~\Data\ephysData\test\expNum001
% The third input argument specifies the stim set number which in this 
% case would be 18. 

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
    %get details about this fly and save then in the data directory
    getFlyDetails(exptInfo)
end

%% Setup camera 
[~, path, ~, ~] = getDataFileName(exptInfo);
videoPath = [path,'rawVideo\'];
if ~isdir(videoPath)
    mkdir(videoPath);
end
disp(videoPath)
input('Camera recording started? ','s');

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
    %calls stimSet function specified by the input stimSetNum
    eval(['stimSet_',num2str(stimSetNum,'%03d'),...
        '(','exptInfo,','preExptData',')'])
end

%% Merge trials 
mergeTrials(exptInfo)

%% Backup data
% makeBackup
