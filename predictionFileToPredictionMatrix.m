function preditionMatrix = predictionFileToPredictionMatrix( predictionFilePath, matrixHeight, matrixWidth )
    predictionFileId = fopen(predictionFilePath, 'r');

    flatPredictions = ones([matrixWidth*matrixHeight,1])*(-1);

    index = 1;
    textLine = fgetl(predictionFileId);
    while ischar(textLine)
      flatPredictions(index) = str2double(textLine(end-1:end));

      index=index+1;
      textLine = fgetl(predictionFileId);
    end

    preditionMatrix = reshape(flatPredictions,[matrixHeight,matrixWidth]);
end

