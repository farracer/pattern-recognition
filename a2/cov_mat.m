function m=cov_mat(M)

   s=size(M);
   
   m=zeros(s(2));
   
   for r=1:s(2)
       
       for c=1:r
           %because of symmetry
           m(r,c)=ccov(M(:,r),M(:,c));
           m(c,r)=m(r,c);
       end
       
   end
    
    
end


