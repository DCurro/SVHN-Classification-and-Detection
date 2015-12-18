setenv('DYLD_LIBRARY_PATH', '/Developer/NVIDIA/CUDA-7.5/lib');

load('orig_format_1_test/digitStruct.mat')

% fileindex = 1:13068;
% predictionsStructs = [];

fileindex = 168:13068;

for i=fileindex
    display([num2str(100*i/size(fileindex,2)),'%']);
    filename = ['orig_format_1_test/',int2str(i),'.png'];
   
    % slice it
    image = imread(filename);
    paddedImage = padarray(image,[16,16]); %padded image
    outputPath = 'slicedImages/';
    mkdir(outputPath);
    outputFilelistName = 'filelist_sliced';
    display('slicing');
    numberOfFilesGenerated = slidingWindowSliceImage32x32ColumnPatches( paddedImage, outputPath, outputFilelistName );

    % make lmdb
    rmdir('~/repos/myCaffe/examples/mnistBig/autodetect_lmdb', 's');
    system(['~/repos/myCaffe/build/tools/convert_imageset ~/Dropbox/cs2151_Project/ ~/Dropbox/cs2151_Project/',outputFilelistName, ' ~/repos/myCaffe/examples/mnistBig/autodetect_lmdb']);

    % delete the original images
    rmdir(outputPath,'s');

    % run classification
    currentdir = pwd;
    cd('~/repos/myCaffe/');
    system(['~/repos/myCaffe/build/tools/caffe test --model ~/repos/myCaffe/examples/mnistBig/lenet_train_test.prototxt --weights ~/repos/myCaffe/examples/mnistBig/Network.caffemodel -iterations ',int2str(numberOfFilesGenerated),'  > caffe_output 2>&1']);
    system(['cat caffe_output | grep predict > ', currentdir,'/caffe_output']);
    cd(currentdir);
    
    % collect results
    display('collecting results');
    predictionMatrix = predictionFileToPredictionMatrix('caffe_output', size(paddedImage,1)-31, size(paddedImage,2)-31);
    predictionCentersAndClass = findPredictionCentersForPreditionMatrix(predictionMatrix);
    
    structsArray = [];
    for predictionIndex=1:size(predictionCentersAndClass,1)
        resultsStruct = struct;
        resultsStruct.centerX = predictionCentersAndClass(predictionIndex,1);
        resultsStruct.centerY = predictionCentersAndClass(predictionIndex,2);
        resultsStruct.class = predictionCentersAndClass(predictionIndex,3);
        
        structsArray = [structsArray resultsStruct];
    end
    
    predictionStruct = struct;
    predictionStruct.name = [int2str(i),'.png'];
    predictionStruct.results = structsArray;
    predictionsStructs = [predictionsStructs predictionStruct];
end