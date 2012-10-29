function s = sumP(gmm)
[x,ncomps] = size(gmm);
s=0
for i=1:ncomps
    s = s + gmm(i).p;
end


