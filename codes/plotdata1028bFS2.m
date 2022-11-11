% plots for first saccade
clearvars;
load saliencydata1028b_16
plotdatafile = 'plotdata1028bFS2';

load subject_label12
hcsz = sc.demographics(:,1); % 1:SZ, 0:HC

% age-matched control
load idxM0419
hcidx = idxM(:,1); % use #1 throughout analysis
hcsz2 = hcsz;
hcsz2(hcsz2 == 0) = 3;
hcsz2(hcidx) = 0;


%% statistics age-matched
saliency = data.saliency.orientation;
sal_sz = saliency(hcsz2 == 1);
sal_hc = saliency(hcsz2 == 0);
% ttest2
[~,p1,~,stats1] = ttest2(sal_sz, sal_hc);
Cohen_d = computeCohen_d(sal_sz, sal_hc, 'independent');
% Wilcoxon
[p2,~,stats2] = ranksum(sal_sz, sal_hc);
Cliff_d = computeCliff_delta(sal_sz, sal_hc, stats2);

d2 = [p1 stats1.tstat p2 stats2.zval Cohen_d Cliff_d];
writematrix(d2, [plotdatafile '_d2.csv']);


%% violin plot age-matched
fig3b = figure();
fig3b.PaperOrientation = 'landscape';
fig3b.PaperPosition = [0.8500 3.5000 28 7];

sp = 4;
yy = data.saliency.orientation;
saliency = yy(:,1);
    subp = subplot(1,4,sp);
    hold on
    sal_sz = saliency(hcsz2 == 1,:);
    sal_hc = saliency(hcsz2 == 0,:);

    pl0 = violinplot2([sal_hc sal_sz]);
    pl0 = modify_violin(pl0);
    pl1 = plot([1 2], [median(sal_hc) median(sal_sz)], 'k-');
    pl1.LineWidth = 2;

    subp.XTick = [1 2];
    subp.XTickLabel = {'HC', 'SZ'};
    subp.Box =  'off';
    subp.TickDir = 'out';
    subp.XLim = [0 3];

print(fig3b, '-painters', plotdatafile, '-dpdf')

%%
function pl = modify_violin(pl)

for ii=1:2
    pl(ii).ViolinColor = [1 1 1]*0.9;
    pl(ii).MedianColor = [1 1 1]*0;
    pl(ii).ViolinAlpha = 1;
    pl(ii).ScatterPlot.MarkerFaceColor = [1 1 1]*0.7;
    pl(ii).ScatterPlot.SizeData = 6;
    
    pl(ii).MedianPlot.SizeData = 64;
    pl(ii).MedianPlot.MarkerEdgeColor = 'none';
    
    pl(ii).BoxPlot.FaceColor = [0 0 0];
    pl(ii).WhiskerPlot.LineStyle = 'none';
end

end
