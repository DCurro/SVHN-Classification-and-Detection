predictionFileId = fopen('detect_predictions', 'r');

flatPredictions = ones([259*95,1])*(-1);

index = 1;
textLine = fgetl(predictionFileId);
while ischar(textLine)
  flatPredictions(index) = str2double(textLine);
  
  index=index+1;
  textLine = fgetl(predictionFileId);
end

matrix = reshape(flatPredictions,[95,259]);