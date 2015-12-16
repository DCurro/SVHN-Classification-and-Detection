% fileList = FileFinder.findAllFilePathsInDirectoryEndingWithSuffix('train_raw/','png');
outputPath = 'backgroundExamples/';
mkdir(outputPath);

for i=1:size(fileList,1)
    filePath = strtrim(fileList(i,:));
    
    fileId = fopen(filePath,'r');
    image = imread(filePath);
    
    height = size(image,1);
    width = size(image,2);
    
    if height<32 || width<32
       fclose(fileId);
       continue       
    end
    
    for sampleCount=1:4
        newFileName = [int2str(i),'_',int2str(sampleCount),'.png'];
        fileOutputName = sprintf('%s%s',outputPath,newFileName);
        
        imwrite(imcrop(image,[randi(width-31) randi(height-31) 31 31]),fileOutputName);
    end
    
    fclose(fileId);
end