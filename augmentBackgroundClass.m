filePaths = FileFinder.findAllFilePathsInDirectoryEndingWithSuffix('backgroundClass/', '.png');

for i=1:size(filePaths,1)
   filePath = strtrim(filePaths(i,:))
   image = imread(filePath);
   
   [dir,name,ext] = fileparts(filePath);
   
   imwrite(flip(image,2), [dir,'/',name,'_f',ext]);
   
   imwrite(imrotate(image,90), [dir,'/',name,'_90',ext]);
   imwrite(imrotate(flip(image,2), 90),[dir,'/',name,'_90_f',ext]);
   
   imwrite(imrotate(image,180), [dir,'/',name,'_180',ext]);
   imwrite(imrotate(flip(image,2), 180),[dir,'/',name,'_180_f',ext]);
   
   imwrite(imrotate(image,270), [dir,'/',name,'_270',ext]);
   imwrite(imrotate(flip(image,2), 270),[dir,'/',name,'_270_f',ext]);
end
   