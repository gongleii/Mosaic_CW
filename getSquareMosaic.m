

function [ resImage ] = getSquareMosaic(img, tileSet, tileAvgs)

    tileSize = size(tileSet, 1);
    nSubBlocks = size(tileAvgs, 1);
    [imgHeight, imgWidth, colors] = size(img);
    
    
    
    resImage = img; 
    
    tileIndexes= floor(linspace(0, tileSize, nSubBlocks+1));

    
    for y = 1:tileSize:imgHeight
        for x = 1:tileSize:imgWidth
            
            vectY = y:y+tileSize-1;
            vectX = x:x+tileSize-1;

            block = img(vectY, vectX, :);

            dist = zeros(1,1,size(tileAvgs,3));	
            
            for i = 1:length(tileIndexes)-1
                for j = 1:length(tileIndexes)-1
                    sum = 0;
                    for m=1:colors
                        blockAvg(m) = mean2(block(tileIndexes(i)+1:tileIndexes(i+1), tileIndexes(j)+1:tileIndexes(j+1), m));
                        sum = sum + (tileAvgs(i,j, :, m) - blockAvg(m)).^2;
                    end				
                    
                    dist = dist + sqrt(sum);

                end
            end			

            [mdist index] = min(dist);  
            resImage(vectY, vectX, :) = tileSet(:,:,:,index);
            
        end        
    end    
end
