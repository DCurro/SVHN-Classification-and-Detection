%% Regular scale slicing
imageName = '105.png';

[~, name, ext] = fileparts(imageName);

outputPath = [name,'_slices/'];
mkdir(outputPath);

image = imread(imageName);
height = size(image,1);
width = size(image,2);

fileListId = fopen(['filelist_detection_',name], 'w+');

for x=1:width-31
    for y=1:height-31
        fileOutputName = sprintf('%s%s_%06d_%06d%s',outputPath,name,x,y,ext);
        imwrite(imcrop(image,[x y 31 31]),fileOutputName);
        
        fprintf(fileListId,'%s %d\n',fileOutputName,0);
    end
end

fclose(fileListId);