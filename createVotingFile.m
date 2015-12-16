votes = zeros([26032,10]);

%% Collect the votes from the 20 network ensemble
for i=1:20
    predictionFileId = fopen(['test_prediction_',int2str(i)],'r');

    voteIndex = 0;
    
    textLine = fgetl(predictionFileId);
    while ischar(textLine)
        voteIndex = voteIndex+1
        
        prediction = str2double(textLine(end));
        if prediction==0
            votes(voteIndex,10) = votes(voteIndex,10)+1;
        else
            votes(voteIndex,prediction) = votes(voteIndex,prediction)+1;
        end
        
        textLine = fgetl(predictionFileId);
    end

    fopen(['test_prediction_',int2str(i)],'r');
end

NUMBER_OF_CLASSES = 10;

count = 0;

%% Produce a file with a column of voted predictions
votedPredictionFileId = fopen('voted_prediction','w+');
for voteIndex=1:size(votes,1)
    voteIndex
    
    maxVote = max(votes(voteIndex,:));
    
    for i=1:NUMBER_OF_CLASSES
        
        if votes(voteIndex,i) == maxVote
            fprintf(votedPredictionFileId,'%d\n', mod(i,NUMBER_OF_CLASSES)); 
            break;
        end
        
    end
end
fclose(votedPredictionFileId);