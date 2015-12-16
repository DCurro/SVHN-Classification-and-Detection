%% returns a matrix in the shape:
%       /x1 y1 class1\
%       | .  .   .   |
%       | .  .   .   |
%       \xN yN classN/
function predictionCentersAndClass = findPredictionCentersForPreditionMatrix( predictionMatrix )
    collectionOfResults = [];

    classes = [0,1,2,3,4,5,6,7,8,9];
    for i=classes
        display(['class', int2str(i)]);
        classPredictionMatrix = (predictionMatrix==i);

        for y=1:size(classPredictionMatrix,1)
            for x=1:size(classPredictionMatrix,2)
                if classPredictionMatrix(y,x)==1
                    radius = maxCircleOfSameClassInClassPredictionMatrixAtCoord(classPredictionMatrix, x,y);
                    collectionOfResults = [collectionOfResults; [x y radius i]];
                end
            end
        end
    end
    
    display('maximizing prediction');
    positionsAndClasses = filterCollectionOfResultsForProperMaxes( collectionOfResults );
    offset = 16;
    fixedPositionsAndClasses = positionsAndClasses+repmat([offset offset 0],[size(positionsAndClasses,1) 1]);
    predictionCentersAndClass = fixedPositionsAndClasses;
end

function filteredResults = filterCollectionOfResultsForProperMaxes( collectionOfResults )
    sortedResultsByMaxRadius = flip(sortrows(collectionOfResults,3) ,1);
    
    modelRadius = max(sortedResultsByMaxRadius(:,3));
    acceptableRadii = modelRadius - modelRadius*0.15; %radii of 15% smaller are acceptable
    
    acceptableResults = sortedResultsByMaxRadius(sortedResultsByMaxRadius(:,3)>acceptableRadii,:);
   
    removedRadiusComponent = acceptableResults(:,[1 2 4]);
    
    filteredResults = unclusterResults(removedRadiusComponent);
end

function unclusteredCollection = unclusterResults( results )
    unclusteredCollection = [];
%     unclusteredCollection = results(1,:);

    radius = 16;
    CLASS_COLUMN = 3;

    classes = [0,1,2,3,4,5,6,7,8,9];
    for i=classes
        classResults = results(results(:,CLASS_COLUMN)==i,:);
        
        if size(classResults,1)==0
            continue;
        end
        
        bestResultsInClass = classResults(1,:);
        
        bestX = bestResultsInClass(1);
        bestY = bestResultsInClass(2);
        bestClass = bestResultsInClass(3);

        unclusteredCollection = [unclusteredCollection; bestResultsInClass];
        
        for i=2:size(results,1)
            x = results(i,1);
            y = results(i,2);
            class = results(i,2);

            if bestClass~=class
               continue; 
            end

            distance = sqrt((bestX-x)^2+(bestY-y)^2);
            if distance >= radius
                unclusteredCollection = [unclusteredCollection; results(i,:)];
            end
        end
    end
end

function radius = maxCircleOfSameClassInClassPredictionMatrixAtCoord( classPredictionMatrix, x,y )
    shouldContinue = 1;
    attemptingRadius = 1;
    
    while(shouldContinue)
        radius = attemptingRadius;
        attemptingRadius = radius+2;
        
        leftX = x - floor(attemptingRadius/2);
        rightX = x + floor(attemptingRadius/2);
        topY = y - floor(attemptingRadius/2);
        bottomY = y + floor(attemptingRadius/2);
        
        circleIsInMatrixBounds = isInMatrixBounds(classPredictionMatrix, leftX,topY) & isInMatrixBounds(classPredictionMatrix, rightX,bottomY);
        if ~circleIsInMatrixBounds
            shouldContinue = 0;
            break;
        end
        
        circleDoesContainAllSameValues = doesCircleContainAllOnes(classPredictionMatrix, leftX,rightX,topY,bottomY);
        if ~circleDoesContainAllSameValues
            shouldContinue = 0;
            break;
        end
    end
end

function isInBounds = isInMatrixBounds(matrix, x,y)
    if x<1 || y<1
       isInBounds = 0;
       return
    end
    
    if x>size(matrix,2) || y>size(matrix,1)
        isInBounds = 0;
        return
    end
    
    isInBounds = 1;
end

function doesCircleContainAllOnes = doesCircleContainAllOnes(matrix, leftX,rightX,topY,bottomY)
    radius = floor((rightX-leftX)/2);
    centerX = leftX+floor((rightX-leftX)/2);
    centerY = topY+floor((bottomY-topY)/2);

    for y=topY:bottomY
        for x=leftX:rightX
            distance = sqrt((x-centerX)^2+(y-centerY)^2);
            if distance < radius
                if matrix(y,x)~=1
                    doesCircleContainAllOnes = 0;
                    return
                end
            end
        end
    end
    
    doesCircleContainAllOnes = 1;
end