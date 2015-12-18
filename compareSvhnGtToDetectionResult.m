function [ undetectedCount, extraDetectedCount, gtPredictionsCount, greaterThan32x32Count, averageDistance ] = compareSvhnGtToDetectionResult( svhnGt, detectionResults )
    undetectedCount = size(svhnGt.bbox,2);
    extraDetectedCount = 0;
    gtPredictionsCount = 0;
    greaterThan32x32Count = 0;
    averageDistance = 0;

    svhnPredictionCount = size(svhnGt.bbox,2);
    gtPredictionsCount = svhnPredictionCount;
    
    distanceCollection = [];
    
    availableDetectionResults = detectionResults;
    
    for bboxIndex=1:svhnPredictionCount
        bbox = svhnGt.bbox(bboxIndex);
        gtClass = mod(bbox.label,10);
        gtCenterX = bbox.left+(bbox.width/2);
        gtCenterY = bbox.top+(bbox.height/2);
        
        bbox.width
        bbox.height
        
        if bbox.width>32 || bbox.height>32
           greaterThan32x32Count = greaterThan32x32Count+1; 
        end
        
        shortestDistance = realmax;
        
        for ourResultsIndex=1:size(availableDetectionResults,2)
            ourResult = availableDetectionResults.results(ourResultsIndex);
            ourClass = ourResult.class;
            ourCenterX = ourResult.centerX - 16; %forgot to readjust for padding
            ourCenterY = ourResult.centerY - 16; %forgot to reajust for the padding
            
            if ourClass~=gtClass
                continue;
            end
            
            distance = sqrt((ourCenterX-gtCenterX)^2+(ourCenterY-gtCenterY)^2);
            
            if distance<shortestDistance
                shortestDistance = distance;
            end
        end
        
        if shortestDistance~=realmax %we have picked a correspondence match
            distanceCollection = [distanceCollection shortestDistance];
            availableDetectionResults(:,ourResultsIndex) = []; %remove selected result from future use
            undetectedCount = undetectedCount-1;
        end
    end
        
    averageDistance = sqrt(sum(distanceCollection.^2));
    extraDetectedCount = size(availableDetectionResults,2);
end

