load extra_32x32.mat

fileID = fopen('filelist_temp.txt','w');

for i=1:size(X,4)
   image = X(:,:,:,i);
   class = mod(y(i),10);
   
   name = ['svhnImages/train_',int2str(i),'.jpg'];
   imwrite(image, name);
   
   nameAndClasses = [name,' ',int2str(class)];
   
   fprintf(fileID,'%s\n',nameAndClasses);
end

fclose(fileID);