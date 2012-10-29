function [ bin ] = maxApostClassifier( img,para_class1,para_class2 )
%image file (normalized to 0 - 1)

%output: binary image, 0 where class1, 1 where class 2
si=size(img);
img=reshape(img,[],3);
post_class1 = loglikgauss(img,para_class1.mu',para_class1.sigma) + log(para_class1.prior);

post_class2 = loglikgauss(img,para_class2.mu',para_class2.sigma) + log(para_class2.prior);

bin = post_class1 <= post_class2;

bin=reshape(bin,[],si(2));



end

