function out = filter_(cut_off, image)
[width, height] = size(image);
x = linspace(-pi,pi,width);
y = linspace(-pi, pi, height);
boolian = zeros(size(image));
for i = 1:width
    for j = 1:height
        boolian(i,j) = ((x(i)^2 + y(j)^2) < cut_off^2);
    end
end
out = image .* boolian;
end