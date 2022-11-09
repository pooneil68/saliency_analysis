clearvars;
load timeavrdata1009mean
savefilename = 'plotdata1009a_am';

load subject_label12
hcsz = sc.demographics(:,1); % 1:SZ, 0:HC

% age-matched control
load idxM0419
hcidx = idxM(:,1); % use #1 throughout analysis
hcsz2 = hcsz;
hcsz2(hcsz2 == 0) = 3;
hcsz2(hcidx) = 0;

hcsz = hcsz2; % use age-matched

%% statistics 
meansaliency = meansaliency * 64; % convert 512*640 to 64*80
d1 = [];
for ii = 8:size(meansaliency,2)

    saliency = meansaliency(:,ii);
    sal_sz = saliency(hcsz == 1);
    sal_hc = saliency(hcsz == 0);
    % ttest2
    [~,p1,~,stats1] = ttest2(sal_sz, sal_hc);
    Cohen_d = computeCohen_d(sal_sz, sal_hc, 'independent');
    % Wilcoxon
    [p2,~,stats2] = ranksum(sal_sz, sal_hc);
    Cliff_d = computeCliff_delta(sal_sz, sal_hc, stats2);
    
    d1 = [d1; p1 stats1.tstat p2 stats2.zval Cohen_d Cliff_d];
end
writematrix(d1, [savefilename '.csv']);

%% plots
fig2 = figure();
fig2.PaperOrientation = 'landscape';
fig2.PaperPosition = [0.6345 0.6345 28 15];

% rawfeature Lum
d = [];
sp = 1;
for ii = 77:81
    saliency = meansaliency(:,ii);
    [subp, p, stats, Cliff_d] = plot_saliency0507b(saliency, hcsz, sp);
    d = [d; p stats.zval Cliff_d];
end
subp.XLim = [0 3];
subp.YLim = [0 6]*10^(-4);
subp.YTick = [1:1:6]*10^(-4);

sp2 = subplot(2,5,6);
pl2 = bar(d(:,3));
pl2.EdgeColor = 'none';
pl2.FaceColor = [1 1 1]*0.5;
sp2.YLim = [-0.13 0.65];
sp2.XLim = [0 6];
sp2.Box =  'off';
sp2.TickDir = 'out';
sp2.XTick = [];

% rawfeature ori
d = [];
sp = 2;
for ii = 12:31
    saliency = meansaliency(:,ii);
    [subp, p, stats, Cliff_d] = plot_saliency0507b(saliency, hcsz, sp);
    d = [d; p stats.zval Cliff_d];
end
subp.XLim = [0 3];
subp.YLim = [0 6]*10^(-4);
subp.YTick = [1:1:6]*10^(-4);

sp2 = subplot(2,5,7);
d2 = d(:,3);
pl4 = bar(1:5,[mean(d2(1:5:end)) mean(d2(2:5:end)) mean(d2(3:5:end)) mean(d2(4:5:end)) mean(d2(5:5:end))]);
pl4.EdgeColor = 'none';
pl4.FaceColor = [1 1 1]*0.5;
hold on
pl3a = plot(1:5, d2(1:5), 'ko');
pl3b = plot(1:5, d2(6:10), 'kx');
pl3c = plot(1:5, d2(11:15), 'k^');
pl3d = plot(1:5, d2(16:20), 'ks');
sp2.YLim = [-0.13 0.65];
sp2.XLim = [0 6];
sp2.Box =  'off';
sp2.TickDir = 'out';
sp2.XTick = [];

% featureActivationMaps
d = [];
sp = 3;
for ii = 37:52
    saliency = meansaliency(:,ii);
    [subp, p, stats, Cliff_d] = plot_saliency0507b(saliency, hcsz, sp);
    d = [d; p stats.zval Cliff_d];
end
subp.XLim = [0 3];
subp.YLim = [0 6]*10^(-4);
subp.YTick = [1:1:6]*10^(-4);

sp2 = subplot(2,5,8);
d2 = d(:,3);
pl4 = bar(1:4,[mean(d2(1:4:end)) mean(d2(2:4:end)) mean(d2(3:4:end)) mean(d2(4:4:end))]);
pl4.EdgeColor = 'none';
pl4.FaceColor = [1 1 1]*0.5;
hold on
pl3a = plot(1:4, d2(1:4), 'ko');
pl3b = plot(1:4, d2(5:8), 'kx');
pl3c = plot(1:4, d2(9:12), 'k^');
pl3d = plot(1:4, d2(13:16), 'ks');
sp2.YLim = [-0.13 0.65];
sp2.XLim = [0 5];
sp2.Box =  'off';
sp2.TickDir = 'out';
sp2.XTick = [];

% normalizedActivationMaps
d = [];
sp = 4;
for ii = 57:72
    saliency = meansaliency(:,ii);
    [subp, p, stats, Cliff_d] = plot_saliency0507b(saliency, hcsz, sp);
    d = [d; p stats.zval Cliff_d];
end
subp.XLim = [0 3];
subp.YLim = [0 6]*10^(-4);
subp.YTick = [1:1:6]*10^(-4);

sp2 = subplot(2,5,9);
d2 = d(:,3);
pl4 = bar(1:4,[mean(d2(1:4:end)) mean(d2(2:4:end)) mean(d2(3:4:end)) mean(d2(4:4:end))]);
pl4.EdgeColor = 'none';
pl4.FaceColor = [1 1 1]*0.5;
hold on
pl3a = plot(1:4, d2(1:4), 'ko');
pl3b = plot(1:4, d2(5:8), 'kx');
pl3c = plot(1:4, d2(9:12), 'k^');
pl3d = plot(1:4, d2(13:16), 'ks');
sp2.YLim = [-0.13 0.65];
sp2.XLim = [0 5];
sp2.Box =  'off';
sp2.TickDir = 'out';
sp2.XTick = [];

% normalizedActivationMaps
d = [];
sp = 5;
for ii = 11
    saliency = meansaliency(:,ii);
    [subp, p, stats, Cliff_d] = plot_saliency0507b(saliency, hcsz, sp);
    d = [d; p stats.zval Cliff_d];
end
subp.XLim = [0 3];
subp.YLim = [0 6]*10^(-4);
subp.YTick = [1:1:6]*10^(-4);

sp2 = subplot(2,5,10);
hold on
plot([0 2], [0.10 0.10], 'k:')
plot([0 2], [0.33 0.33], 'k:')
plot([0 2], [0.474 0.474], 'k:')
pl2 = bar(d(:,3));
pl2.EdgeColor = 'none';
pl2.FaceColor = [1 1 1]*0.5;
sp2.YLim = [-0.13 0.65];
sp2.XLim = [0 2];
sp2.Box =  'off';
sp2.TickDir = 'out';
sp2.XTick = [];

print(fig2, savefilename, '-dpdf')

%%
function [subp, p, stats, Cliff_d] = plot_saliency0507b(saliency, hcsz, sp)

    subp = subplot(2,5,sp);
    hold on
    sal_sz = saliency(hcsz == 1);
    sal_hc = saliency(hcsz == 0);
    yy_sz = mean(sal_sz);
    yy_hc = mean(sal_hc);
    se_sz = std(sal_sz)./sqrt(size(sal_sz,1));
    se_hc = std(sal_hc)./sqrt(size(sal_hc,1));
    h1 = errorbar([1 2], [yy_hc yy_sz], [se_hc se_sz], 'ko-');

    h1.MarkerEdgeColor = 'none';
    h1.MarkerFaceColor =[0 0 0];
    h1.MarkerSize = 6;
    h1.Color = [0 0 0];
    h1.LineWidth = 2;

    subp.XTick = [1 2];
    subp.XTickLabel = {'HC', 'SZ'};
    subp.Box =  'off';
    subp.TickDir = 'out';
    subp.XLim = [0 3];
    
    [p,~,stats] = ranksum(sal_sz, sal_hc);
    Cliff_d = computeCliff_delta(sal_sz, sal_hc, stats);
   
end
