
function [tileSet] =  reading_images(path,patch_size)
    imagefiles = dir(sprintf('%s/*.JPG',path));      
    nfiles = length(imagefiles);    
    tileSet=zeros(patch_size,patch_size,3,nfiles,'uint8');
    for i=1:nfiles
       currentfile = imagefiles(i).name;
       currentimage = imresize(imread(currentfile), [patch_size patch_size]);
       tileSet(1:patch_size,1:patch_size,:,i) = currentimage(:,:,:);
    end
end
