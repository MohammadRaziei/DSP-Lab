function y = myconv(h,x)
    L = length(h); M = length(x);
    y = zeros(1, M+L-1);
    xn = [zeros(1,L), x,zeros(1,L)];
    for n = 1:length(y)
        hn = [zeros(1,n),h(end:-1:1),zeros(1,M+L-n)];
        y(n) = hn * xn';
    end
end