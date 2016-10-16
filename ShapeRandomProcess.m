function Rp=ShapeRandomProcess(N)
if(size(N,1)<size(N,2))
    N=N';
end
Rp = N - 0.9*[0;N(1:end-1)];
end