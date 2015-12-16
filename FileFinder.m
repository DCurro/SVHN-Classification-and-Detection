%FILEFINDER Finds all files of some type in directories (excludes filesnames containing #)
classdef FileFinder
    
    methods (Static)
        
        function pathsList = findAllFilePathsInDirectoryEndingWithSuffix(directory, suffix)
            filePathsList = FileFinder.getAllFiles(directory);
            paths = FileFinder.pathsForFilePathsList(filePathsList, suffix);
            
            pathsList = paths;
        end
        
        function fileList = getAllFiles(dirName)
            dirData = dir(dirName);      %# Get the data for the current directory
            dirIndex = [dirData.isdir];  %# Find the index for directories
            fileList = {dirData(~dirIndex).name}';  %'# Get a list of the files
            
            if ~isempty(fileList)
                fileList = cellfun(@(x) fullfile(dirName,x),...  %# Prepend path to files
                                   fileList,'UniformOutput',false);
            end
            
            subDirs = {dirData(dirIndex).name};  %# Get a list of the subdirectories
            validIndex = ~ismember(subDirs,{'.','..'});  %# Find index of subdirectories
                                                       %#   that are not '.' or '..'
            for iDir = find(validIndex)                  %# Loop over valid subdirectories
                nextDir = fullfile(dirName,subDirs{iDir});    %# Get the subdirectory path
                fileList = [fileList; FileFinder.getAllFiles(nextDir)];  %# Recursively call getAllFiles
            end
        end

        function paths = pathsForFilePathsList(filePathsList, suffix)
            resultPaths = [];

            for i=1:size(filePathsList,1)
                filePath = filePathsList(i,:);
                if ~isempty(findstr(filePath{1}, suffix))
                    resultPaths = strvcat(resultPaths, filePath{1});
                end
            end

            paths = resultPaths;
        end
    end
    
end

