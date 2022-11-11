clearvars;
load subject_label12
plotdatafile = 'plotdata1028b';
load(plotdatafile)

savedatafile = 'saliencydata1028b_16.mat';

% baseline引いた結果をデータとして保存しておく
data = [];

ec = 16; % これより後ろの時点のデータはcut
idx1 = 2;
xx = squeeze(plotdata2(1:ec,idx1,:))';

% 12-15: DIO blur
idx1 = 12;
saliency_full = squeeze(plotdata2(1:ec,idx1,:))';
idx1 = 13;
saliency_color = squeeze(plotdata2(1:ec,idx1,:))';
idx1 = 14;
saliency_luminance = squeeze(plotdata2(1:ec,idx1,:))';
idx1 = 15;
saliency_orientation = squeeze(plotdata2(1:ec,idx1,:))';

data.xx = xx;
data.saliency.full = saliency_full;
data.saliency.color = saliency_color;
data.saliency.luminance = saliency_luminance;
data.saliency.orientation = saliency_orientation;

data.meansaliency.full = nanmean(saliency_full, 2);
data.meansaliency.color = nanmean(saliency_color, 2);
data.meansaliency.luminance = nanmean(saliency_luminance, 2);
data.meansaliency.orientation = nanmean(saliency_orientation, 2);

save(savedatafile, 'data');

