function createDir(directory)
%CREATEDIR Create a directory if it does not exist
    dirExists = exist(directory, 'dir');
    if dirExists == 0
        mkdir(directory);
    end
    clear directory dirExists;
end

