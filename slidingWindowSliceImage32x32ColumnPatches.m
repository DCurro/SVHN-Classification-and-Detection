function numberOfFilesGenerated = slidingWindowSliceImage32x32ColumnPatches( image, outputPath, outputFilelistName )
    numberOfFilesGenerated = 0;

    height = size(image,1);
    width = size(image,2);

    fileListId = fopen(outputFilelistName, 'w+');

    for x=1:width-31
        display(['slicing complete: ',num2str(100*(x/(width-31)))])
        for y=1:height-31
            numberOfFilesGenerated = numberOfFilesGenerated+1;
            
            slicedImageName = sprintf('%simage_%06d_%06d.png',outputPath,x,y);
            imwrite(imcrop(image,[x y 31 31]),slicedImageName);

            fprintf(fileListId,'%s %d\n',slicedImageName,0);
        end
    end

    fclose(fileListId);
end

