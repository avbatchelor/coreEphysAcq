function FlyData = getFlyDetails(exptInfo,basename,varargin)
%{
GETFLYDETAILS Used in the case of a new fly to get information from the user about this
fly/experimental parameters/particulars

%}


%% Ask user for input
FlyData.line = input('Line: ','s');
FlyData.freenessLeft = input('Freeness of left antenna: ','s');
FlyData.freenessRight = input('Freeness of right antenna: ','s');
FlyData.notesOnDissection = input('Notes on dissection: ','s');
FlyData.prepType = input('Prep type: ','s');

% Get eclosion date
h = uicontrol('Style', 'pushbutton', 'Position', [20 150 100 70]);
uicalendar('DestinationUI', {h, 'String'});
waitfor(h,'String'); 
FlyData.eclosionDate = get(h,'String');
close all

%% Get filename
prefixCode  = exptInfo.prefixCode;
expNum      = exptInfo.expNum;
flyNum      = exptInfo.flyNum;

% Make numbers strings
eNum = num2str(expNum,'%03d');
fNum = num2str(flyNum,'%03d');

% calls ephysSettings to obtain the variable dataDirectory - yf
ephysSettings
path = [dataDirectory,prefixCode,'\expNum',eNum,...
        '\flyNum',fNum];

if ~isdir(path)
    mkdir(path)
end
if exist('basename','var')
    filename = [path,'\',basename,'flyData'];
else 
    filename = [path,'\flyData'];
end

%% Save
save(filename,'FlyData')
