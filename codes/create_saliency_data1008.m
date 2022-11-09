clearvars;
% サリエンシーマップの計算
addpath(genpath('GBVS_saliency/gbvs'))
load saliency_data0901
savename = 'out_itti1008';

tic;
out_itti = [];
for ii = 1:length(saliency_data)
   img = saliency_data{ii}.image;
   out_itti{ii} = ittikochmap3b(img);
end
toc;

%%
tic;
save([savename '.mat'], 'out_itti')
toc;

return
