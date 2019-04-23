function out = median(im , Size)
out = zeros(size(im));
    x= (ceil(Size(1)/2)+1 ); y=(ceil(Size(2)/2)+1 );
    alo = (Size(1) - 1) / 2;
    for j = y:(size(im,1)-y)
        for i = x:(size(im,2)-x)
            temp = (im(i-alo:i+alo , j - alo:j + alo));
            temp = sort(temp(:));
            out =temp(ceil(size(1)^2 /2));
        end
    end




end
