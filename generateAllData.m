%% Generate train+extra data; hereby named train
trainFileID = fopen('filelist_train','w');

load train_32x32.mat
trainImageCount = size(X,4);

for i=1:trainImageCount
   ['processing train ', int2str(i), ' of ', int2str(trainImageCount)]
   
   image = X(:,:,:,i);
   class = mod(y(i),10);
   
   name = ['svhnImages/train_',int2str(i),'.jpg'];
   imwrite(image, name);
   nameAndClasses = [name,' ',int2str(class)];
   fprintf(trainFileID,'%s\n',nameAndClasses);
   
   for modificationIndex = 1:7
       angle = (1-rand*2)*15;
       modifiedImage = imrotate(image,angle,'bilinear','crop');
       modifiedImage = modifiedImage(4:28,4:28,:);
       modifiedImage = imresize(modifiedImage,[32 32]);
       
       name = ['svhnImages/train_',int2str(i),'_',int2str(modificationIndex),'.jpg'];
       imwrite(modifiedImage, name);
       nameAndClasses = [name,' ',int2str(class)];
       fprintf(trainFileID,'%s\n',nameAndClasses);
   end
end

trainImageCount = size(X,4)*8;

beep

load extra_32x32.mat
extraImageCount = size(X,4);

for i=1:extraImageCount
   ['processing extra ', int2str(i+trainImageCount), ' of ', int2str(extraImageCount+trainImageCount)]
   
   image = X(:,:,:,i);
   class = mod(y(i),10);
   
   name = ['svhnImages/train_',int2str(i+trainImageCount),'.jpg'];
   imwrite(image, name);
   nameAndClasses = [name,' ',int2str(class)];
   fprintf(trainFileID,'%s\n',nameAndClasses);
end

fclose(trainFileID);

%% Generate test data
trainFileID = fopen('filelist_test','w');

load test_32x32.mat
testImageCount = size(X,4);

for i=1:testImageCount
   ['processing test ', int2str(i), ' of ', int2str(testImageCount)]
   
   image = X(:,:,:,i);
   class = mod(y(i),10);
   
   name = ['svhnImages/test_',int2str(i),'.jpg'];
   imwrite(image, name);
   nameAndClasses = [name,' ',int2str(class)];
   fprintf(trainFileID,'%s\n',nameAndClasses);
end