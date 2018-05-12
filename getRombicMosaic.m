
function [ resImage ] = getRombicMosaic(img, allTiles, tileAvgs)

    tileSize = size(allTiles, 1);    
    nSubBlocks = size(tileAvgs, 1);
    [imgHeight, imgWidth, colors] = size(img); 
   
   
    
    orig_img=img;
    img = imresize(orig_img,[imgHeight+tileSize imgWidth+tileSize]);
    img(tileSize/2+1:end-tileSize/2,tileSize/2+1:end-tileSize/2,:)=orig_img;
    resImage = img; 
    [imgHeight, imgWidth, colors] = size(img);
    tileIndexes = floor(linspace(0, tileSize, nSubBlocks+1));
   
    for y = 1:tileSize:imgHeight-tileSize;
        for x = 1:tileSize:imgWidth-tileSize;
            
            vectY = y:y+tileSize-1;
            vectY = vectY+tileSize/2;            
            vectX = x:x+tileSize-1;
            vectX = vectX+tileSize/2;
           
            block = img(vectY, vectX, :);

            dist = zeros(1,1,size(tileAvgs,3));	

            mid=round(nSubBlocks/2);
            i1=mid;
            i2=mid;
            for j = 1:length(tileIndexes)-1
                for i=i1:i2
                sum = 0;
                
                for m=1:colors
                        blockAvg(m) = mean2(block(tileIndexes(i)+1:tileIndexes(i+1), tileIndexes(j)+1:tileIndexes(j+1), m));
                        sum = sum + (tileAvgs(i,j, :, m) - blockAvg(m)).^2;                   
                end	
                

                    dist = dist + sqrt(  sum );
                end
                
                if j<=mid
                    i1=i1-1;
                    i2=i2+1;
                else
                    i1=i1+1;
                    i2=i2-1;
                end
                if j==mid
                    i1=2;
                    i2=nSubBlocks-1;
                end
            end			

            [mdist index] = min(dist);  

            resImage(vectY, vectX, :) = transfering(allTiles(:,:,:,index),resImage(vectY, vectX, :));
        end
    end

    for y = 1:tileSize:imgHeight
        for x = 1:tileSize:imgWidth
            vectY = y:y+tileSize-1;
            vectX = x:x+tileSize-1;

            block = img(vectY, vectX, :);

            dist = zeros(1,1,size(tileAvgs,3));	
            mid=round(nSubBlocks/2);
            i1=mid;
            i2=mid;
            for j = 1:length(tileIndexes)-1
                for i=i1:i2
                    sum = 0;
                    for m=1:colors
                        blockAvg(m) = mean2(block(tileIndexes(i)+1:tileIndexes(i+1), tileIndexes(j)+1:tileIndexes(j+1), m));
                        sum = sum + (tileAvgs(i,j, :, m) - blockAvg(m)).^2;                   
                    end	                

                    dist = dist + sqrt(sum);
               
                end			
            end			

            [mdist index] = min(dist);   

            resImage(vectY, vectX, :) = transfering(allTiles(:,:,:,index),resImage(vectY, vectX, :));
        end        
    end
    
    resImage = resImage(tileSize/2+1:end-tileSize/2,tileSize/2+1:end-tileSize/2,:);
    
end
