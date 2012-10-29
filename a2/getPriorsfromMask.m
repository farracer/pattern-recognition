function [ p_skin,p_nonskin ] = getPriorsfromMask( bin )
%# of skin pixels

total=numel(bin);
n_skin=nnz(bin);
p_skin=n_skin/total;
p_nonskin=(total-n_skin)/total;

end

