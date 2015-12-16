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

% 
% imageScaleHalf = imresize(image, 0.5);
% height = size(imageScaleHalf,1);
% width = size(imageScaleHalf,2);
% 
% for x=1:2:width-32
%     for y=1:height-32
%         imwrite(imcrop(image,[x y 31 31]),[outputPath,name,'_',int2str(x),'_',int2str(y),'_0.5',ext]);
%     end
% end
% 
% imageScaleQuarter = imresize(image, 0.25);
% height = size(imageScaleQuarter,1);
% width = size(imageScaleQuarter,2);
% 
% for x=1:1:width-32
%     for y=1:height-32
%         imwrite(imcrop(image,[x y 31 31]),[outputPath,name,'_',int2str(x),'_',int2str(y),'_0.25',ext]);
%     end
% end