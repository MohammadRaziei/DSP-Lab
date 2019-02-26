function out=singen(w,n)
    b = [sin(w) 0];
    a = [1 -2*cos(w) 1];
    x = [ 1 zeros(1,n- 1)];
    out = filter(b,a,x);
end