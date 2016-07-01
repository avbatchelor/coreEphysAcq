%%
%   getCodeStamp(levelsDown (optional))
%
%       Returns a string with the name and short hash of the git
%       repository housing the calling function. It appends a * if there 
%       are uncommitted changes.
%
%%
function stampString = getCodeStamp(varargin)  

    if nargin > 0
        levelsDown = varargin{1};
    else
        levelsDown = 0;
    end

    % Get the hostname
    % [status, hostname] = system('hostname');
    % hostname = regexprep(hostname,'\n','');
    
    % Record the old current directory
    currentDir = pwd();
    
    % Change to the calling directory
    [ST,I] = dbstack();
    % If there's no calling file
    if (length(ST) < 2)
        callingDir = currentDir;
    elseif (length(ST) < (2 + levelsDown))
        disp('--- Invalid levelsDown, using current directory. ---');
        callingDir = currentDir;
    else
        callingDir = regexprep(which(ST(2 + levelsDown).name),['/|\\',ST(2 + levelsDown).file],'');
    end
    
    % Change to the calling directory
    cd(callingDir);
    
    % Figure out the top level directory we're in
    printPath = regexprep(callingDir,'.*/','');
    
    % Get the current hash
    [status, shortHash] = system('git rev-parse --short HEAD');
    shortHash = regexprep(shortHash,'\n','');
    
    % Find out if the repository is current
    [status, gitStatus] = system('git status');
    if isempty(regexp(gitStatus,'working directory clean'))
        % Working directory isn't clean, there are un-committed changes
        currentFlag = '*';
        if ~isempty(regexp(gitStatus,'Not a git repository'))
            shortHash = 'NotAGitRepo';
        end
    else
        currentFlag = '';
    end
    repDir = char(regexp(printPath,'.*GitHub\\.+(?=\\)','match'));
    stampString = [repDir,'-',shortHash,currentFlag];
    
    % Change back to the directory we started in
    cd(currentDir);
