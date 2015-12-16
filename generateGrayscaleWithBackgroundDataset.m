filelist_wbackground_validFileId = fopen('filelist_wbackground_valid', 'r');
filelist_wbackground_testFileId = fopen('filelist_wbackground_test', 'r');
filelist_wbackground_trainFileId = fopen('filelist_wbackground_train', 'r');

grayscale_validOutputPath = 'grayscaleDsvhn_valid/';
mkdir(grayscale_validOutputPath);
grayscale_testOutputPath = 'grayscaleDsvhn_test/';
mkdir(grayscale_testOutputPath);
grayscale_trainOutputPath = 'grayscaleDsvhn_train/';
mkdir(grayscale_trainOutputPath);

% filelistGrayValidFileId = fopen('filelist_gray_valid', 'w+');
filelistGrayTestFileId = fopen('filelist_gray_test', 'w+');
filelistGrayTrainFileId = fopen('filelist_gray_train', 'w+');

% disp('creating gray valid');
% index = 1;
% textLine = fgetl(filelist_wbackground_validFileId);
% while ischar(textLine)
%   filePath = strtrim(textLine(1:end-2));
%   
%   class = strtrim(textLine(end-1:end));
%   
%   image = imread(filePath);
%     
%   [~,name,extension] = fileparts(filePath);
%   outputName = [grayscale_validOutputPath,name,extension];
%     
%   imwrite(rgb2gray(image), outputName);
%   
%   fprintf(filelistGrayValidFileId, '%s %s\n', outputName, class);
%   
%   index=index+1;
%   textLine = fgetl(filelist_wbackground_validFileId);
% end


disp('creating gray test');
index = 1;
textLine = fgetl(filelist_wbackground_testFileId);
while ischar(textLine)
  filePath = strtrim(textLine(1:end-2));
  
  class = strtrim(textLine(end-1:end));
  
  image = imread(filePath);
    
  [~,name,extension] = fileparts(filePath);
  outputName = [grayscale_testOutputPath,name,extension];
    
  imwrite(rgb2gray(image), outputName);
  
  fprintf(filelistGrayTestFileId, '%s %s\n', outputName, class);
  
  index=index+1;
  textLine = fgetl(filelist_wbackground_testFileId);
end

disp('creating gray train');
index = 1;
textLine = fgetl(filelist_wbackground_trainFileId);
while ischar(textLine)
  filePath = strtrim(textLine(1:end-2));
  
  class = strtrim(textLine(end-1:end));
  
  image = imread(filePath);
    
  [~,name,extension] = fileparts(filePath);
  outputName = [grayscale_trainOutputPath,name,extension];
    
  imwrite(rgb2gray(image), outputName);
  
  fprintf(filelistGrayTrainFileId, '%s %s\n', outputName, class);
  
  index=index+1;
  textLine = fgetl(filelist_wbackground_trainFileId);
end

% fclose(filelistGrayValidFileId);
fclose(filelistGrayTestFileId);
fclose(filelistGrayTrainFileId);

% fclose(filelist_wbackground_validFileId);
fclose(filelist_wbackground_testFileId);
fclose(filelist_wbackground_trainFileId);

disp('done making gray fileset and file lists');