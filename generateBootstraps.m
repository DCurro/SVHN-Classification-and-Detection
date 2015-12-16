%% Generate 10 bootstraps in a row (each 1/10th of the data)
trainFileId = fopen('filelist_train','r');

exampleCount = 0;

textLine = fgetl(trainFileId);
while ischar(textLine)
  textLine = fgetl(trainFileId);
  exampleCount = exampleCount+1;
end

fclose(trainFileId);


bootstrapExampleCount = floor(exampleCount/10);

linearBootstrapCount = 10;
% trainFileId = fopen('filelist_train','r');
% for i=1:10
%     bootstrapName = ['filelist_bootstrap_',int2str(i)];
%     
%     bootstrapFileId = fopen(bootstrapName,'w+');
%     
%     for exampleIndex=1:bootstrapExampleCount
%         textLine = fgetl(trainFileId);
%         fprintf(bootstrapFileId,'%s\n',textLine);
%     end
%     
%     fclose(bootstrapFileId);
% end
% fclose(trainFileId);

%% Generate two random boostraps (each 1/10th of the data)
bootstrapDataSetCount = 10;

for bootstrapIter=1:bootstrapDataSetCount
    exampleIndexesToUse = sort(randi([1 exampleCount], [1 bootstrapExampleCount]));

    trainFileId = fopen('filelist_train','r');

    bootstrapName = ['filelist_bootstrap_',int2str(linearBootstrapCount+bootstrapIter)];
    bootstrapFileId = fopen(bootstrapName,'w');
    for i=1:exampleCount
        textLine = fgetl(trainFileId);

        while size(exampleIndexesToUse,2)~=0 && i==exampleIndexesToUse(1)
            exampleIndexesToUse = exampleIndexesToUse(2:end);
            fprintf(bootstrapFileId,'%s\n',textLine);
        end
    end
    fclose(bootstrapFileId);

    fclose(trainFileId);    
end
