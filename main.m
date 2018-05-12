function [] = main(path,patch_size,image) 
    close all;
    if patch_size<=200
        
        load tileSet200.mat
        
        if patch_size~=200
            tileSet=imresize(tileSet,[patch_size patch_size]);
        end
        
    else
        
        tileSet = reading_images(path,patch_size);
        
    end
    
    
    %Checking boundaries and division without remainder
    %In the case of unappropriate input
    %Image will be adjusted    
    [height,width,colors] = size(image);
    
    if (floor(mod(height, patch_size)) ~= 0)
        display('Height of the image should be equally divided into the size of Tiles');
        height = floor(size(image,1)/patch_size)*patch_size;
        fprintf('Height will be adjusted to %d\n',height);
    end
    if (floor(mod(width, patch_size)) ~= 0) 
        display('Width of the image should be equally divided into the size of Tiles');
        width = floor(size(image,2)/patch_size)*patch_size; 
        fprintf('Width will be adjusted to %d\n',width);
    end
    if (colors ~= 3)
        error('Image is not RGB image,dataset is RGB'); 
    end
    
    image=imresize(image,[height width]);
    
    %HERE WE CAN ADJUST NUMBER OF THE BLOCKS OF TILE
    %SECOND ARGUMENT IS THE NUMBER OF BLOCK PER ROW
    %Basically, if its 5, overall number of blocks will be 25
    avgs = getTileAvgs(tileSet,5);    
    
    %results
    squareMosaic = getSquareMosaic(image,tileSet,avgs);
    imshow(squareMosaic, 'InitialMagnification', 'fit');
    title('Square Mosaic');
    figure;
    
    %Getting rhombus tiles
    for i=1:length(tileSet)
        tileSet(:,:,:,i) = cropping(tileSet(:,:,:,i));
    end
    
    %results
    rombicMosaic = getRombicMosaic(image,tileSet,avgs);
    imshow(rombicMosaic, 'InitialMagnification', 'fit');
    
    title('Rombic Mosaic');
    imwrite(rombicMosaic,'rhombic.jpg');
    imwrite(squareMosaic,'squared.jpg');
    
end