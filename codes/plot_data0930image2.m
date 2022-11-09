clearvars;
load subject_label12
load imageavrdata0923mean
savepdfname = 'plot_data0930image/';

hcsz = sc.demographics(:,1);

% age-matched control
load idxM0419
hcidx = idxM(:,1);
hcsz2 = hcsz;
hcsz2(hcsz2 == 0) = 3;
hcsz2(hcidx) = 0;

sbj_num = size(plotdata2,1);
img_num = size(plotdata2,2);
salmap_num = size(plotdata2,3);

%% pictureごとのzvalueの計算 (all subjects)
map = 12; % DIO_FUll
YTick = [(2:4:14)*10^(-4); (2:2:8)*10^(-4)];
YLim = [-Inf Inf];
fig2 = figure();
fig2.PaperOrientation = 'landscape';
fig2.PaperPosition = [0.6345 0.6345 20 19.7310];

counter = 0;
for idx = [8 38]
    counter = counter + 1;
    saliency = squeeze(plotdata2(:,idx,map));
    subp = plot_saliency0507c(saliency, hcsz, counter);

    subp.YTick = YTick(counter,:);
    subp.YLim = YLim;

    subp.XTick = [1 2];
    subp.XTickLabel = {'HC', 'SZ'};
    subp.Box =  'off';
    subp.TickDir = 'out';
    subp.XLim = [0 3];
    
end
print(fig2, 'plot_data0930image', '-dpdf');

%%
function subp = plot_saliency0507c(saliency, hcsz, sp)

    subp = subplot(3,4,sp);
    sal_sz = saliency(hcsz == 1);
    sal_hc = saliency(hcsz == 0);

    g1 = repmat({'SZ'},length(sal_sz),1);
    g2 = repmat({'HC'},length(sal_hc),1);
    pl0 = violinplot2([sal_sz; sal_hc], [g1;g2]);
    pl0 = modify_violin(pl0);
    pl1 = plot([1 2], [nanmedian(sal_hc) nanmedian(sal_sz)], 'k-');
    pl1.LineWidth = 2;
    
    % 独立2群のテスト
    [h,p1,ci,stats1] = ttest2(sal_sz, sal_hc);
    [p2,h,stats2] = ranksum(sal_sz, sal_hc);
    % 効果量
    Cohen_d = computeCohen_d(sal_sz, sal_hc, 'independent');
    W = stats2.ranksum;
    U = W - length(sal_sz)*(length(sal_sz)+1)/2;
    Cliff_d = 2 * U / (length(sal_sz) * length(sal_hc)) - 1; % subjectの数が違う
    title(sprintf('%1.2e / %2.2f', p2, Cliff_d));

end

%%
function pl = modify_violin(pl)

for ii=1:2
    pl(ii).ViolinColor = [1 1 1]*0.9;
    pl(ii).MedianColor = [1 1 1]*0;
    pl(ii).ViolinAlpha = 0.1;
    pl(ii).ScatterPlot.MarkerFaceColor = [1 1 1]*0;
    pl(ii).ScatterPlot.SizeData = 6;
    
    pl(ii).MedianPlot.SizeData = 64;
    pl(ii).MedianPlot.MarkerEdgeColor = 'none';
    
    pl(ii).BoxPlot.FaceColor = [0 0 0];
    pl(ii).WhiskerPlot.LineStyle = 'none';
end

end
