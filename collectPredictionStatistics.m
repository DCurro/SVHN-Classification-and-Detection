averageDistanceTotal = 0;
undetectedCountTotal = 0;
extraDetectedCountTotal = 0;
greaterThan32x32CountTotal = 0;
gtPredictionsCountTotal = 0;

preditictionsCount = size(predictionsStructs,2);

for i=1:preditictionsCount
    display(['collecting detection results: ',num2str(100*(i/(preditictionsCount)))]);
    
    detectionResults = predictionsStructs(i);
    gt = digitStruct(i);
    
    [undetectedCount,extraDetectedCount,gtPredictionsCount,greaterThan32x32Count,averageDistance] = compareSvhnGtToDetectionResult(gt,detectionResults); 

    gtPredictionsCountTotal = gtPredictionsCountTotal + gtPredictionsCount;
    averageDistanceTotal = averageDistanceTotal + averageDistance/preditictionsCount;
    undetectedCountTotal = undetectedCountTotal+undetectedCount;
    extraDetectedCountTotal = extraDetectedCountTotal+extraDetectedCount;
    greaterThan32x32CountTotal = greaterThan32x32CountTotal+greaterThan32x32Count;
end

display(['Successfully detected: ',num2str((gtPredictionsCountTotal-undetectedCountTotal)/gtPredictionsCountTotal*100),'%']);
display(['Average distance between predictions and gt: ', num2str(averageDistanceTotal), ' pixels']);
display(['Misclassified or extra detections found: ', num2str(extraDetectedCountTotal)]);
display(['GT with bounding box larger than 32x32: ', num2str(greaterThan32x32CountTotal)]);
display(['Successfully detected (<32x32): ',num2str((gtPredictionsCountTotal-undetectedCountTotal+greaterThan32x32CountTotal)/gtPredictionsCountTotal*100),'%']);
