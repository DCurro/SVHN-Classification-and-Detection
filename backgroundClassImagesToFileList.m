filePaths = FileFinder.findAllFilePathsInDirectoryEndingWithSuffix('backgroundClass/', '.png');

fileID = fopen('filelist_background.txt','w+');

for i=1:size(filePaths,1)
   filePath = strtrim(filePaths(i,:))
    
   name = filePath;
   class = 10;
   nameAndClasses = [name,' ',int2str(class)];
   
   fprintf(fileID,'%s\n',nameAndClasses);
end

fclose(fileID);