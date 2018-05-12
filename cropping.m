function[res] = cropping(myImage)
    len=size(myImage,1);
    res=255*ones(len,len,3,'uint8');
    for i = 1:len-1
        y1=abs(len/2-i)+1;
        y2=len-y1;                         
        res(y1:y2,i:i+1,:)=myImage(y1:y2,i:i+1,:);
    end
end