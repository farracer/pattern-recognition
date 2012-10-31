clear all;
close all;

load 'data/skin.mat'

load 'data/nonskin.mat'

gmmskin = gmmEM(sdata,2,200,false);
gmmnskin = gmmEM(ndata,2,200,false);

im = imread('data/image.png');
im_norm=double(im)/255.0;

si=size(im);

im_norm=reshape(im_norm,[],3);

likSkin = gmmskin(1).p * mvnpdf(im_norm,gmmskin(1).mean',gmmskin(1).covm)+gmmskin(2).p*mvnpdf(im_norm,gmmskin(2).mean',gmmskin(2).covm);
likNskin = gmmnskin(1).p * mvnpdf(im_norm,gmmnskin(1).mean',gmmnskin(1).covm)+gmmnskin(2).p*mvnpdf(im_norm,gmmnskin(2).mean',gmmnskin(2).covm);

bin = bin(likSkin,likNskin);
mask = imread('data/mask.png');
mask_norm = double(mask)/255.0;
mask_norm = reshape(mask_norm,[],1);
mask_norm = mask_norm == 1;
truepos = nnz(mask_norm&bin);
falsepos = nnz(~mask_norm&bin);
trueneg = nnz(~mask_norm&~bin);
falseneg = nnz(mask_norm&~bin);

trueposrate = truepos/(truepos+falseneg)
falseposrate = falsepos/(falsepos+trueneg)
%truenegrate = trueneg/(trueneg+falsepos)
%falsenegrate = falseneg/(truepos+falseneg)

im=reshape(bin,[],si(2));

figure();
subplot(2,1,1);imshow(imread('data/image.png'))
subplot(2,1,2);imshow(im);

