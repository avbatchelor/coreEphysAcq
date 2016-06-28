%%
%   [fullFileName, path] =  getDataFileName(prefixCode, expNum)
%
%   Returns the path and the path\fileName in which to store data. Format is:
%
%   path: \dataDirectory\prefixCode\expNum\YYMMDD\flyNum\flyExpNum\
%   filename: prefixCode_expNum_YYMMDD_flyNum_flyExpNum_nextSequentialNumber.mat
%       
%
%   JSB 3\22\2013
%%
function [fullFileName, path, trialNum, idString] = getDataFileName(exptInfo)

    prefixCode  = exptInfo.prefixCode;
    expNum      = exptInfo.expNum; 
    flyNum      = exptInfo.flyNum;
    cellNum     = exptInfo.cellNum;
    cellExpNum  = exptInfo.cellExpNum; 
    
    microCzarSettings;   % Loads settings
  
    % Make numbers strings
    eNum = num2str(expNum,'%03d');
    fNum = num2str(flyNum,'%03d');
    cNum = num2str(cellNum,'%03d');
    cENum = num2str(cellExpNum,'%03d');
    
    % Put together path name and fileNamePreamble  
    path = [dataDirectory,prefixCode,'\expNum',eNum,...
        '\flyNum',fNum,'\cellNum',cNum,'\','cellExpNum',cENum,'\'];
        
    fileNamePreamble = [prefixCode,'_expNum',eNum,...
        '_flyNum',fNum,'_cellNum',cNum,'_cellExpNum',cENum,'_trial'];
    
    idString = [prefixCode,'_expNum',eNum,...
        '_flyNum',fNum,'_cellNum',cNum,'_cellExpNum',cENum,'_'];
    
    % Determine trial number 
    trialNum = 1;
    while( size(dir([path,fileNamePreamble,num2str(trialNum,'%03d'),'.mat']),1) > 0)
        trialNum = trialNum + 1;
    end
    
    % Put together full file name 
    fullFileName = [path,fileNamePreamble,num2str(trialNum,'%03d'),'.mat'];