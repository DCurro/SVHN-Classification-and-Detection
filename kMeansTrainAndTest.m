%% Prep the data %%
% load train_32x32
% 
% zeroImageHotIndex = (y==10);
% onesImageHotIndex = (y==1);
% twoImageHotIndex = (y==2);
% threeImageHotIndex = (y==3);
% fourImageHotIndex = (y==4);
% fiveImageHotIndex = (y==5);
% sixImageHotIndex = (y==6);
% sevenImageHotIndex = (y==7);
% eightImageHotIndex = (y==8);
% nineImageHotIndex = (y==9);
% 
% zerosData = zeros([sum(zeroImageHotIndex),32*32]);
% row = 1;
% for i=1:size(y,1)
%     if zeroImageHotIndex(i)
%        zerosData(row,:) = reshape(rgb2gray(X(:,:,:,i)), 1,[]); 
%        row = row+1;
%     end
% end
% 
% onesData = zeros([sum(onesImageHotIndex),32*32]);
% row = 1;
% for i=1:size(y,1)
%     if onesImageHotIndex(i)
%        onesData(row,:) = reshape(rgb2gray(X(:,:,:,i)), 1,[]); 
%        row = row+1;
%     end
% end
% 
% twosData = zeros([sum(twoImageHotIndex),32*32]);
% row = 1;
% for i=1:size(y,1)
%     if twoImageHotIndex(i)
%        twosData(row,:) = reshape(rgb2gray(X(:,:,:,i)), 1,[]); 
%        row = row+1;
%     end
% end
% 
% threesData = zeros([sum(threeImageHotIndex),32*32]);
% row = 1;
% for i=1:size(y,1)
%     if threeImageHotIndex(i)
%        threesData(row,:) = reshape(rgb2gray(X(:,:,:,i)), 1,[]); 
%        row = row+1;
%     end
% end
% 
% foursData = zeros([sum(fourImageHotIndex),32*32]);
% row = 1;
% for i=1:size(y,1)
%     if fourImageHotIndex(i)
%        foursData(row,:) = reshape(rgb2gray(X(:,:,:,i)), 1,[]); 
%        row = row+1;
%     end
% end
% 
% fivesData = zeros([sum(fiveImageHotIndex),32*32]);
% row = 1;
% for i=1:size(y,1)
%     if fiveImageHotIndex(i)
%        fivesData(row,:) = reshape(rgb2gray(X(:,:,:,i)), 1,[]); 
%        row = row+1;
%     end
% end
% 
% sixsData = zeros([sum(sixImageHotIndex),32*32]);
% row = 1;
% for i=1:size(y,1)
%     if sixImageHotIndex(i)
%        sixsData(row,:) = reshape(rgb2gray(X(:,:,:,i)), 1,[]); 
%        row = row+1;
%     end
% end
% 
% sevensData = zeros([sum(sevenImageHotIndex),32*32]);
% row = 1;
% for i=1:size(y,1)
%     if sevenImageHotIndex(i)
%        sevensData(row,:) = reshape(rgb2gray(X(:,:,:,i)), 1,[]); 
%        row = row+1;
%     end
% end
% 
% eightsData = zeros([sum(eightImageHotIndex),32*32]);
% row = 1;
% for i=1:size(y,1)
%     if eightImageHotIndex(i)
%        eightsData(row,:) = reshape(rgb2gray(X(:,:,:,i)), 1,[]); 
%        row = row+1;
%     end
% end
% 
% ninesData = zeros([sum(nineImageHotIndex),32*32]);
% row = 1;
% for i=1:size(y,1)
%     if nineImageHotIndex(i)
%        ninesData(row,:) = reshape(rgb2gray(X(:,:,:,i)), 1,[]); 
%        row = row+1;
%     end
% end
% 
%% Learn the best k's %%
% [idx0,C0] = kmeans(zerosData,32,'Distance','cityblock','Replicates',5);
% [idx1,C1] = kmeans(onesData,32,'Distance','cityblock','Replicates',5);
% [idx2,C2] = kmeans(twosData,32,'Distance','cityblock','Replicates',5);
% [idx3,C3] = kmeans(threesData,32,'Distance','cityblock','Replicates',5);
% [idx4,C4] = kmeans(foursData,32,'Distance','cityblock','Replicates',5);
% [idx5,C5] = kmeans(fivesData,32,'Distance','cityblock','Replicates',5);
% [idx6,C6] = kmeans(sixsData,32,'Distance','cityblock','Replicates',5);
% [idx7,C7] = kmeans(sevensData,32,'Distance','cityblock','Replicates',5);
% [idx8,C8] = kmeans(eightsData,32,'Distance','cityblock','Replicates',5);
% [idx9,C9] = kmeans(ninesData,32,'Distance','cityblock','Replicates',5);

%% Classification
load test_32x32

prediction = zeros(size(y));

for i=1:size(X,4)
    (i/size(y,1))*100;
    
    testImageVect = reshape(rgb2gray(X(:,:,:,i)), 1,[]);
    
    minDistance = realmax;
    class = -1;
    
    for classIndex=0:9
        C=-1;
        if classIndex==0
            C=C0;
        elseif classIndex==1
            C=C1;
        elseif classIndex==2
            C=C2;
        elseif classIndex==3
            C=C3;
        elseif classIndex==4
            C=C4;
        elseif classIndex==5
            C=C5;
        elseif classIndex==6
            C=C6;
        elseif classIndex==7
            C=C7;
        elseif classIndex==8
            C=C8;
        elseif classIndex==9
            C=C9;
        end

        for clusterCenterIndex=1:32
            distance  = sqrt(sum((single(testImageVect) - single(C(clusterCenterIndex,:))) .^ 2));
            
            if distance < minDistance
                minDistance = distance;
                class = classIndex+1;
            end
        end 
    end
    
    prediction(i) = class;
end

accuracy = sum(prediction==y)/size(y,1)