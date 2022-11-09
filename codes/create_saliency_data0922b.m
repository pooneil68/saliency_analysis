clearvars;
% computation of saliency maps
addpath(genpath('GBVS_saliency/gbvs'))
load saliency_data0901
savename = 'out_itti0922';

%%
tic;
out_itti = [];
for ii = 1:length(saliency_data)
   img = saliency_data{ii}.image;
   
   out0 = ittikochmap3CIO(img); % RGB model
   map = out0.master_map_blur; 
   out_itti{ii}.CIO_Full = map / sum(map(:));
   map = out0.top_level_feat_maps_blur{1}; 
   out_itti{ii}.CIO_Col = map / sum(map(:));
   map = out0.top_level_feat_maps_blur{2}; 
   out_itti{ii}.CIO_Lum = map / sum(map(:));
   map = out0.top_level_feat_maps_blur{3}; 
   out_itti{ii}.CIO_Ori = map / sum(map(:));
   
   out0 = ittikochmap3(img); % DKL model
   map = out0.master_map_blur; 
   out_itti{ii}.DIO_Full = map / sum(map(:));
   map = out0.top_level_feat_maps_blur{1}; 
   out_itti{ii}.DIO_Col = map / sum(map(:));
   map = out0.top_level_feat_maps_blur{2}; 
   out_itti{ii}.DIO_Lum = map / sum(map(:));
   map = out0.top_level_feat_maps_blur{3}; 
   out_itti{ii}.DIO_Ori = map / sum(map(:));

   % convert to dkl space
   dkl = rgb2dkl(img);
   
   img1 = dkl(:,:,1);
   img1r = (img1+1)/2;
   out1 = ittikochmap3e(img1r); %IO
   
   img2 = dkl(:,:,2);
   img2r = (img2+1)/2;
   out2 = ittikochmap3e(img2r);

   img3 = dkl(:,:,3);
   img3r = (img3+1)/2;
   out3 = ittikochmap3e(img3r);
   
   % area normalize
   map = out1.top_level_feat_maps_blur{1};
   out_itti{ii}.LumD = map / sum(map(:)); 
   map = out2.top_level_feat_maps_blur{1}; 
   out_itti{ii}.LumK = map / sum(map(:)); 
   map = out3.top_level_feat_maps_blur{1}; 
   out_itti{ii}.LumL = map / sum(map(:)); 
   
   map = out1.top_level_feat_maps_blur{2}; 
   out_itti{ii}.OriD = map / sum(map(:));
   map = out2.top_level_feat_maps_blur{2}; 
   out_itti{ii}.OriK = map / sum(map(:)); 
   map = out3.top_level_feat_maps_blur{2}; 
   out_itti{ii}.OriL = map / sum(map(:)); 
   
end
toc;

%%
tic;
save([savename '.mat'], 'out_itti')
toc;

disp('done!')
return
