% DKL 6-channel modelでのfixation mapとのcorrelation
clearvars;
pdfname = 'violinplot1223am';

load fixM0924b_am
load out_itti0922

%% 3つのmap (Ori only)でのcorrelation
cc_sz = []; cc_hc = []; cc_df = [];
for ii = 1:56
    sz = fixMnSZ56(:,:,ii);
    hc = fixMnHC56(:,:,ii);
    df = DF(:,:,ii);

    sal_LumD = out_itti{ii}.LumD;
    sal_LumK = out_itti{ii}.LumK;
    sal_LumL = out_itti{ii}.LumL;
    sal_OriD = out_itti{ii}.OriD;
    sal_OriK = out_itti{ii}.OriK;
    sal_OriL = out_itti{ii}.OriL;
    
    XX = [sal_OriD(:) sal_OriK(:) sal_OriL(:)];
    
    [r,p,rl,ru] = corrcoef([sz(:) XX]);
    cc_sz(:,:,ii) = r;
    [r,p,rl,ru] = corrcoef([hc(:) XX]);
    cc_hc(:,:,ii) = r;
    [r,p,rl,ru] = corrcoef([df(:) XX]);
    cc_df(:,:,ii) = r;

    [rho, pval] =  partialcorr([sz(:) XX]);
    pc_sz(:,:,ii) = rho; pcp_sz(:,:,ii) = pval; 
    [rho, pval] =  partialcorr([hc(:) XX]);
    pc_hc(:,:,ii) = rho; pcp_hc(:,:,ii) = pval; 
    [rho, pval] =  partialcorr([df(:) XX]);
    pc_df(:,:,ii) = rho; pcp_df(:,:,ii) = pval; 
end

cc_szM = squeeze(cc_sz(2:4,1,:));
cc_hcM = squeeze(cc_hc(2:4,1,:));
cc_dfM = squeeze(cc_df(2:4,1,:));

pc_szM = squeeze(pc_sz(2:4,1,:));
pc_hcM = squeeze(pc_hc(2:4,1,:));
pc_dfM = squeeze(pc_df(2:4,1,:));

pcp_szM = squeeze(pcp_sz(2:4,1,:));
pcp_hcM = squeeze(pcp_hc(2:4,1,:));
pcp_dfM = squeeze(pcp_df(2:4,1,:));

cc_P = [];
cc_P(1,1) = signrank(cc_szM(1,:));
cc_P(1,2) = signrank(cc_szM(2,:));
cc_P(1,3) = signrank(cc_szM(3,:));
cc_P(2,1) = signrank(cc_hcM(1,:));
cc_P(2,2) = signrank(cc_hcM(2,:));
cc_P(2,3) = signrank(cc_hcM(3,:));
cc_P(3,1) = signrank(cc_dfM(1,:));
cc_P(3,2) = signrank(cc_dfM(2,:));
cc_P(3,3) = signrank(cc_dfM(3,:));

pc_P = [];
pc_P(1,1) = signrank(pc_szM(1,:));
pc_P(1,2) = signrank(pc_szM(2,:));
pc_P(1,3) = signrank(pc_szM(3,:));
pc_P(2,1) = signrank(pc_hcM(1,:));
pc_P(2,2) = signrank(pc_hcM(2,:));
pc_P(2,3) = signrank(pc_hcM(3,:));
pc_P(3,1) = signrank(pc_dfM(1,:));
pc_P(3,2) = signrank(pc_dfM(2,:));
pc_P(3,3) = signrank(pc_dfM(3,:));

d2 = [pc_P*9; nanmedian(pc_szM,2) nanmedian(pc_hcM,2) nanmedian(pc_dfM,2)];
writematrix(d2, [pdfname '.csv']);

%% 画像間のcorrelation fixmapは除いて計算 (partial correlationは影響するから)
cc_salmap = []; pc_salmap = [];
for ii = 1:56

    sal_LumD = out_itti{ii}.LumD;
    sal_LumK = out_itti{ii}.LumK;
    sal_LumL = out_itti{ii}.LumL;
    sal_OriD = out_itti{ii}.OriD;
    sal_OriK = out_itti{ii}.OriK;
    sal_OriL = out_itti{ii}.OriL;
    
    cc_salmap(:,:,ii) = corrcoef([sal_OriD(:) sal_OriK(:) sal_OriL(:)]);
    pc_salmap(:,:,ii) = partialcorr([sal_OriD(:) sal_OriK(:) sal_OriL(:)]);
end

cc_SalM = median(cc_salmap,3,'omitnan')
pc_SalM = median(pc_salmap,3,'omitnan')

fig0 = figure();
fig0.PaperOrientation = 'landscape';
fig0.PaperPosition = [0.6345 0.6345 28.4310 19.7310];

subplot(1,2,1)
imagesc(cc_SalM,[0 1])
colorbar
axis square; axis tight
subplot(1,2,2)
imagesc(pc_SalM,[0 1])
colorbar
axis square; axis tight
print(fig0, 'cc_SalM_lmfit_map1223mod', '-dpdf')

%% violinplot
numpl = 3;

fig1 = figure();
fig1.PaperOrientation = 'landscape';
fig1.PaperPosition = [0.6345 0.6345 28.4310 19.7310];

sp = subplot(2,3,4);
hold on
plot([0 4], [0 0], 'k:')
pl = violinplot2(pc_szM');
pl = modify_violin(pl, numpl);
axis([0 4 -0.31 0.6])
sp.Box = 'off';
sp.TickDir = 'out';
sp.YTick = -0.2:0.2:0.6;

sp = subplot(2,3,5);
hold on
plot([0 4], [0 0], 'k:')
pl = violinplot2(pc_hcM');
pl = modify_violin(pl, numpl);
axis([0 4 -0.31 0.6])
sp.Box = 'off';
sp.TickDir = 'out';
sp.YTick = -0.2:0.2:0.6;

sp = subplot(2,3,6);
hold on
plot([0 4], [0 0], 'k:')
pl = violinplot2(pc_dfM');
pl = modify_violin(pl, numpl);
axis([0 4 -0.16 0.25])
sp.Box = 'off';
sp.TickDir = 'out';
sp.YTick = -0.2:0.1:0.3;

print(fig1, '-painters', [pdfname 'a'], '-dpdf')

%%
function pl = modify_violin(pl, numpl)

for ii=1:numpl
    pl(ii).ViolinColor = [1 1 1]*0.9;
    pl(ii).MedianColor = [1 1 1]*0;
    pl(ii).ViolinAlpha = 1;
    pl(ii).ScatterPlot.MarkerFaceColor = [1 1 1]*0.7;
    pl(ii).ScatterPlot.SizeData = 12;
    
    pl(ii).MedianPlot.SizeData = 64;
    pl(ii).MedianPlot.MarkerEdgeColor = 'none';
    
    pl(ii).BoxPlot.FaceColor = [0 0 0];
    pl(ii).WhiskerPlot.LineStyle = 'none';
end

end
