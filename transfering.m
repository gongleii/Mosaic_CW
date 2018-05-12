function[res] = transfering(source,dest)
    len=size(source,1);
    for i = 1:len
        y1=abs(len/2-i)+1;
        y2=len-y1;
        dest(y1:y2,i,:)=source(y1:y2,i,:);
    end
    res=dest;
end