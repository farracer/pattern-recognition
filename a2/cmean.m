
function a=cmean(m)
%calculate mean of matrix or vector. Vector must be column vector,
%matrix mean is calculated column wise
    c=size(m);
    a=sum(m);
    a=a/c(1);
end
