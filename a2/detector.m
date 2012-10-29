function [bin,lik_skin,lik_non] = detector( path,theta,skinmodel,nonskinmodel )
%detector
im=imread(path);
im_norm=double(im)/255.0;
%orig


si=size(im);



im_norm=reshape(im_norm,[],3);

lik_skin=loglikgauss(im_norm,skinmodel.mu',skinmodel.sigma);
lik_non=loglikgauss(im_norm,nonskinmodel.mu',nonskinmodel.sigma);
        
bin=bin_threshold(lik_skin,lik_non,log(theta));

bin=reshape(bin,[],si(2));



end

