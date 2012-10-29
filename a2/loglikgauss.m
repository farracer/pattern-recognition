function l=loglikgauss(x,m,c)
%x: ndimensional datapoint, m:means, c: covariance matrix
%     ndim=length(m);
%     prefactor=(-1*ndim/2)*log(2*pi)-1/2*log(det(c));
%     expon=-1/2*(x-m)'*c^(-1)*(x-m);
%     l=prefactor+expon;
l=log(mvnpdf(x,m,c));    
end