function im = loadAndNormalizeImage(path)

im = imread(path);
im = double(im)/255.0;
