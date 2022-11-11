clearvars;
load saliencydata1028b_16
plotdatafile = 'Fig2';

load subject_label12
hcsz = sc.demographics(:,1); % 1 for SZ, 0 for HC

% age-matched control: hcsz2
load idxM0419
hcidx = idxM(:,1); % use 1 throughout analysis
hcsz2 = hcsz;
hcsz2(hcsz2 == 0) = 3;
hcsz2(hcidx) = 0;

%% plot across saccades / All subjects
fig2 = figure();
fig2.PaperOrientation = 'landscape';
fig2.PaperPosition = [0.8500 3.5000 28 14];
    
% saccades; all subjects; Full 
subp = plot_saliency0507b(data.xx, data.saliency.full, hcsz, 1);
subp.YLim = [-Inf Inf];
title('Full model');

% saccades (log); all subjects; Full 
subp = plot_saliency0628(data.saliency.full, hcsz, 2);
subp.YLim = [-Inf Inf];
title('Full model');

% saccades (log); Age matched; Full
subp = plot_saliency0628(data.saliency.full, hcsz2, 3);
subp.YLim = [-Inf Inf];
title('Full model, age-matched');

% color age-matched
subp = plot_saliency0628(data.saliency.color, hcsz2, 4);
subp.YLim = [-Inf Inf];
title('Color, age-matched');

% Lum age-matched
subp = plot_saliency0628(data.saliency.luminance, hcsz2, 5);
subp.YLim = [-Inf Inf];
title('Lum, age-matched');

% Ori age-matched
subp = plot_saliency0628(data.saliency.orientation, hcsz2, 6);
subp.YLim = [-Inf Inf];
title('Ori, age-matched');

print(fig2, plotdatafile, '-dpdf');

%%
function subp = plot_saliency0507b(xx, saliency, hcsz, sp)
    xx_sz = nanmean(xx(hcsz == 1, :),1);
    xx_hc = nanmean(xx(hcsz == 0, :),1);

    sal_sz = saliency(hcsz == 1,:);
    sal_hc = saliency(hcsz == 0,:);
    yy_sz = nanmean(sal_sz);
    yy_hc = nanmean(sal_hc);
    se_sz = nanstd(sal_sz)./sqrt(size(sal_sz,1));
    se_hc = nanstd(sal_hc)./sqrt(size(sal_hc,1));

    subp = subplot(2,3,sp);
    hold on
    h1 = errorbar(xx_hc, yy_hc, se_hc, 'mo-');
    h2 = errorbar(xx_sz, yy_sz, se_sz, 'bo-');

    h1.MarkerEdgeColor = 'none';
    h1.MarkerFaceColor =[1 0 1];
    h1.Color = [1 0 1];
    h2.MarkerEdgeColor = 'none';
    h2.MarkerFaceColor =[0 0 1];
    h2.Color = [0 0 1];

    subp.XTick = 0:4000:8000;
    subp.XTickLabel = [0 4 8];
    subp.Box =  'off';
    subp.TickDir = 'out';
    subp.XLim = [0 8000];
end

function subp = plot_saliency0628(saliency, hcsz, sp)

    xx_sz = log10(1:size(saliency,2));
    xx_hc = log10(1:size(saliency,2));

    sal_sz = saliency(hcsz == 1,:);
    sal_hc = saliency(hcsz == 0,:);
    yy_sz = nanmean(sal_sz);
    yy_hc = nanmean(sal_hc);
    se_sz = nanstd(sal_sz)./sqrt(size(sal_sz,1));
    se_hc = nanstd(sal_hc)./sqrt(size(sal_hc,1));

    subp = subplot(2,3,sp);
    hold on
    h1 = errorbar(xx_hc, yy_hc, se_hc, 'mo-');
    h2 = errorbar(xx_sz, yy_sz, se_sz, 'bo-');

    h1.MarkerEdgeColor = 'none';
    h1.MarkerFaceColor =[1 0 1];
    h1.Color = [1 0 1];
    h2.MarkerEdgeColor = 'none';
    h2.MarkerFaceColor =[0 0 1];
    h2.Color = [0 0 1];
    
    XTickLabel = [1 2 4 8 16];

    subp.XTick = log10(XTickLabel);
    subp.XTickLabel = XTickLabel;
    subp.Box =  'off';
    subp.TickDir = 'out';
    subp.XLim = log10([1 20]);
end
