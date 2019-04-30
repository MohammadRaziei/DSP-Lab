function out = median(im , Size)
out = zeros(size(im));
    x= (ceil(Size(1)/2)+1 ); y=(ceil(Size(2)/2)+1 );
    alo = (Size(1) - 1) / 2;
    for k = 1:size(im,3)
        for j = y:(size(im,2)-y)
            for i = x:(size(im,1)-x)
                temp = im(i-alo:i+alo , j - alo:j + alo,k);
                temp = sort(temp(:));
                out(i,j,k) =temp(ceil(Size(1)^2 /2));
            end
        end
    end




end
