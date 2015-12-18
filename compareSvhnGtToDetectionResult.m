function [ undetectedCount, extraDetectedCount, distances ] = compareSvhnGtToDetectionResult( svhnGt, detectionResults )
    undetectedCount = 0;
    extraDetectedCount = 0;

    svhnPredictionCount = size(svhnGt.bbox,2);
    ourPredictionCount = size(detectionResults,1);
    distances = zeros([min(svhnPredictionCount,ourPredictionCount),1]);

    classes = [0,1,2,3,4,5,6,7,8,9]
    
    %create correspondence map between ours and svhn
    %[1 1;2 3;3 2] <-example
    
    %go through our first one
        %go through theirs
            
    

end

