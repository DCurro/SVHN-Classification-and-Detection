load test_32x32.mat

votedPredictionFileId = fopen('voted_prediction','r');

count = 0;
successfulPrediction = 0;
numberOfPredictions = 0;

textLine = fgetl(votedPredictionFileId);
while ischar(textLine)
    count = count+1

    prediction = str2double(textLine(end));
    if prediction==0
        prediction = 10;
    end
    
    groundTruth = y(count);
    if prediction == groundTruth
        successfulPrediction = successfulPrediction+1;
    end

    textLine = fgetl(votedPredictionFileId);
end

accuracy = successfulPrediction/count
