function [flyNum, cellNum, cellExpNum] = getFlyNum(prefixCode, expNum, newFly, newCell)

    % Make numbers strings
    eNum = num2str(expNum,'%03d');
    ephysSettings;   % Loads settings
    
    path = [dataDirectory,prefixCode,'\expNum',eNum,'\flyNum'];
    % Determine fly number 
    flyNum = 1;
    while( isdir([path,num2str(flyNum,'%03d')]) )
        flyNum = flyNum + 1;
    end
    
    cellNum = 1;
    cellExpNum = 1;
    if ~strcmp(newFly,'y')
        if flyNum ~= 1 
            flyNum = flyNum - 1;
        end
        cellNum = 1; 
        while( isdir([path,num2str(flyNum,'%03d'),'\cellNum',num2str(cellNum,'%03d')]) )
            cellNum = cellNum + 1;
        end
        if ~strcmp(newCell,'y')
            if cellNum ~= 1
                cellNum = cellNum - 1;
            end
            cellExpNum = 1; 
            while( isdir([path,num2str(flyNum,'%03d'),'\cellNum',num2str(cellNum,'%03d'),'\cellExpNum',num2str(cellExpNum,'%03d')]) )
                cellExpNum = cellExpNum + 1;
            end
        end
    end