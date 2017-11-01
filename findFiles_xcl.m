% This function will find all subfolders of a directory
function files = findFiles_xcl(rootdir, extension, relative_path)
% Author: Xu Chenglin (NTU, Singapore)
% Date: 3 Dec 2016
% Format: 1 Nov 2017

if nargin<3
    relative_path = 0;
end
if nargin<2
    extension = '*';
end
[list ISDIR]= my_dir(rootdir);
files = {};

accept_all_extension = 0;
if extension == '*'
    accept_all_extension = 1;
end

for i=1:length(list)
    tmp = [rootdir '/' list{i}];
    if ISDIR(i)==1
        subfiles = findFiles_xcl(tmp, extension, 0);
        files = [files subfiles];
    else
        if relative_path==1
            currFile = list{i};
        else
            currFile = [rootdir '/' list{i}];
        end
        if accept_all_extension
            files{end+1} = currFile;
        else
            if strcmpi(list{i}(end-length(extension)+1:end), extension) == 0
                continue;
            else
                files{end+1} = currFile;
            end
        end
    end
end
