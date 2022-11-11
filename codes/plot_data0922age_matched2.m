clearvars;
savefilename2 = 'plot_data0922am_d2';
savefilename3 = 'plot_data0922am_d3';

meansaliency_file = 'timeavrdata0922mean';
load(meansaliency_file)

load subject_label12
hcsz = sc.demographics(:,1); % 1:SZ, 0:HC

% age-matched control
load idxM0419
hcidx = idxM(:,1); % use #1 throughout analysis
hcsz2 = hcsz;
hcsz2(hcsz2 == 0) = 3;
hcsz2(hcidx) = 0;

%% Original model (DKL) (for Figure 3)
idx = 12:15; % DIO
spx = 1:4;

% statistics 
d2 = [];
for ii = 1:length(idx)
    id = idx(ii);
    saliency = meansaliency(:,id);

    sal_sz = saliency(hcsz2 == 1);
    sal_hc = saliency(hcsz2 == 0);
    % ttest2
    [~,p1,~,stats1] = ttest2(sal_sz, sal_hc);
    Cohen_d = computeCohen_d(sal_sz, sal_hc, 'independent');
    % Wilcoxon
    [p2,~,stats2] = ranksum(sal_sz, sal_hc);
    Cliff_d = computeCliff_delta(sal_sz, sal_hc, stats2);
    
    d2 = [d2; p1 stats1.tstat p2 stats2.zval Cohen_d Cliff_d];
end
writematrix(d2, [savefilename2 '.csv']);

% plots
fig2 = figure();
fig2.PaperOrientation = 'landscape';
fig2.PaperPosition = [0.6345 0.6345 20 19.7310];

YLim = [-Inf Inf];
YTick = [0:1.0:10.0]* 10^(-4);

for ii = 1:length(idx)
    id = idx(ii);
    sp = spx(ii);
    saliency = meansaliency(:,id);
    subp = subplot(3,4,sp);

    sal_sz = saliency(hcsz2 == 1,:);
    sal_hc = saliency(hcsz2 == 0,:);
    pl0 = violinplot2([sal_hc sal_sz]);
    pl0 = modify_violin(pl0);
    pl1 = plot([1 2], [median(sal_hc) median(sal_sz)], 'k-');
    pl1.LineWidth = 2;

    subp.YLim = YLim;
    subp.YTick = YTick;

    subp.XTick = [1 2];
    subp.XTickLabel = {'HC', 'SZ'};
    subp.Box =  'off';
    subp.TickDir = 'out';
    subp.XLim = [0 3];

end
print(fig2, savefilename2, '-dpdf')

%% Extended, six-channel model (for Figure 5)
idx = 16:21; % extebded six channel model
spx = [1:3 5:7];

% statistics 
d3 = [];
for ii = 1:length(idx)
    id = idx(ii);
    saliency = meansaliency(:,id);

    sal_sz = saliency(hcsz2 == 1);
    sal_hc = saliency(hcsz2 == 0);
    % ttest2
    [~,p1,~,stats1] = ttest2(sal_sz, sal_hc);
    Cohen_d = computeCohen_d(sal_sz, sal_hc, 'independent');
    % Wilcoxon
    [p2,~,stats2] = ranksum(sal_sz, sal_hc);
    Cliff_d = computeCliff_delta(sal_sz, sal_hc, stats2);
    
    d3 = [d3; p1 stats1.tstat p2 stats2.zval Cohen_d Cliff_d];
end
writematrix(d3, [savefilename3 '.csv']);

% plots
fig3 = figure();
fig3.PaperOrientation = 'landscape';
fig3.PaperPosition = [0.6345 0.6345 20 19.7310];

YLim = [-Inf Inf];
YTick = [0:1.0:10.0]* 10^(-4);

for ii = 1:length(idx)
    id = idx(ii);
    sp = spx(ii);
    saliency = meansaliency(:,id);
    subp = subplot(3,4,sp);

    sal_sz = saliency(hcsz2 == 1,:);
    sal_hc = saliency(hcsz2 == 0,:);
    pl0 = violinplot2([sal_hc sal_sz]);
    pl0 = modify_violin(pl0);
    pl1 = plot([1 2], [median(sal_hc) median(sal_sz)], 'k-');
    pl1.LineWidth = 2;

    subp.YLim = YLim;
    subp.YTick = YTick;
    
    subp.XTick = [1 2];
    subp.XTickLabel = {'HC', 'SZ'};
    subp.Box =  'off';
    subp.TickDir = 'out';
    subp.XLim = [0 3];

end
print(fig3, savefilename3, '-dpdf')


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
