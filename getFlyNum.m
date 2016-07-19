function [flyNum, cellNum, cellExpNum] = getFlyNum(prefixCode, expNum, newFly, newCell)
%{
GETFLYNUM Figures out which fly, cell and cell experiemental number is being aquired by looking at the data directory to see what data already exists there 
flyNum, cellNum, cellExpNum = getFlyNum(prefixCode, expNum, newFly, newCell)

 INPUTS
prefixCode- string from user input
expNum - number from user input
newFly- y or n (from user response to commandline prompt)
newCell - y or n  (from user response to commandline prompt)

 OUTPUTS
flyNum- current fly number being recorded
cellNum - current cell number (for this date) being recorded
cellExpNum - current experimental number for this current cell (for when
more than on experiment is done on one cell).

%}

% Make numbers strings
eNum = num2str(expNum,'%03d');
ephysSettings;   % Loads settings, including personal dataDirectory

path = [dataDirectory,prefixCode,'\expNum',eNum,'\flyNum'];

% Determine fly number
flyNum = 1;
while( isdir([path,num2str(flyNum,'%03d')]) )
    flyNum = flyNum + 1; %Set flyNum to one larger than the currently existing flyNum directory
end

cellNum = 1;
cellExpNum = 1;
if ~strcmp(newFly,'y') %if not starting a new fly, figure out what cellNum should be.
    if flyNum ~= 1
        flyNum = flyNum - 1; %Since not new fly, subtract one from fly number
    end
    cellNum = 1;
    while( isdir([path,num2str(flyNum,'%03d'),'\cellNum',num2str(cellNum,'%03d')]) )
        cellNum = cellNum + 1; %Set cellNum to one larger than the currently existing cellNum directory
    end
    if ~strcmp(newCell,'y')
        if cellNum ~= 1
            cellNum = cellNum - 1; %if not starting a new cell, subtract one from cellNum
        end
        cellExpNum = 1;
        while( isdir([path,num2str(flyNum,'%03d'),'\cellNum',num2str(cellNum,'%03d'),'\cellExpNum',num2str(cellExpNum,'%03d')]) )
            cellExpNum = cellExpNum + 1;  %Set cellExpNum to one larger than the currently existing cellExpNum directory
        end
    end
end