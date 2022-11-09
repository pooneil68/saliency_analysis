clearvars;
% for replication
rng('default')

for ii=1:56
    e1 = randi([0 1],512,640);
    e2 = randi([0 1],512,640);
    e3 = randi([0 1],512,640);
    img = [];
    img(:,:,1) = e1;
    img(:,:,2) = e2;
    img(:,:,3) = e3;

    filename = sprintf('images/image%02d.jpg', ii);
    imwrite(img, filename);
end

