clearvars;
printname = 'glm_cognitive_score';

set(groot, 'defaulttextInterpreter','none');
format shortG

load subject_label12
hcsz = sc.demographics(:,1); % 1‚ªpatient, 0‚ªcontrol

% age-matched control—phcsz2
load idxM0419
hcidx = idxM(:,1); % ‚Æ‚è‚ ‚¦‚¸1‚ð‚Â‚©‚Á‚Ä‚â‚Á‚Ä‚Ý‚é
hcsz2 = hcsz;
hcsz2(hcsz2 == 0) = 3;
hcsz2(hcidx) = 0;

meansaliency_file = 'timeavrdata0922mean';
load(meansaliency_file) % load meansaliency

load emsdata0427d

%% Plots for Figure 6A (scattered for selected variables)
saliency_score = meansaliency(:,15); % DIO_Ori
cols = [2 16 23 size(emsdata,2)];
%   {'Age'          }
%   {'WAIS_PS'     }
%   {'SFS'          }
%   {'FV_SPL'       }

sel = (hcsz2 < 2);
hcsz3 = hcsz2(sel);

saliency_score1 = meansaliency(sel,13); % Col
saliency_score2 = meansaliency(sel,14); % Lum
saliency_score3 = meansaliency(sel,15); % Ori

fig6 = figure();
fig6.PaperOrientation = 'landscape';
fig6.PaperPosition = [0.6345 0.6345 28.4310 19.7310];
for ii = 1:length(cols)
    col = cols(ii);
    val = emsdata(sel, col);

    tbl = table(val, saliency_score1, saliency_score2, saliency_score3, hcsz3);
    mdl = fitlm(tbl,'val ~ hcsz3 + saliency_score3');
    ypred = predict(mdl,tbl);
    
    sc0 = saliency_score3(hcsz3==0);
    em0 = val(hcsz3==0);
    sc1 = saliency_score3(hcsz3==1);
    em1 = val(hcsz3==1);

    sel01 = (saliency_score3 == min(sc0));
    sel02 = (saliency_score3 == max(sc0));
    sel11 = (saliency_score3 == min(sc1));
    sel12 = (saliency_score3 == max(sc1));

    g1 = subplot(1,4,ii);
    hold on

    s1 = plot(sc0, em0, 'm.');
    s2 = plot(sc1, em1, 'b.');
    s1.MarkerSize = 12;
    s2.MarkerSize = 12;

    s1r = plot([saliency_score3(sel01) saliency_score3(sel02)], [ypred(sel01) ypred(sel02)],'m-');
    s2r = plot([saliency_score3(sel11) saliency_score3(sel12)], [ypred(sel11) ypred(sel12)],'b-');
    s1r.LineWidth = 1;
    s2r.LineWidth = 1;

    g1.Box = 'off';
    g1.TickDir = 'out';
    g1.Title.String = column_names{col};
    axis square
    axis([min([sc0;sc1]) max([sc0;sc1]) min([em0;em1]) max([em0;em1])])

end
print(fig6, printname, '-dpdf')

%% GLM for original model (DKL)
patient_only = [4:11];

outM1 = [];
sel = (hcsz2 < 2);
for col = 1:size(emsdata,2)
    val = emsdata(sel, col);
    hcsz_c = categorical(hcsz2(sel));
    saliency_score1 = meansaliency(sel,13); % Col
    saliency_score2 = meansaliency(sel,14); % Lum
    saliency_score3 = meansaliency(sel,15); % Ori

    tbl = table(val, saliency_score1, saliency_score2, saliency_score3, hcsz_c);
    if ismember(col, patient_only)
        mdl = fitlm(tbl,'val ~ saliency_score1 + saliency_score2 + saliency_score3');
    else
        mdl = fitlm(tbl,'val ~ hcsz_c + saliency_score1 + saliency_score2 + saliency_score3');
    end

    out = [mdl.Coefficients.tStat(2:4); mdl.Coefficients.pValue(2:4)];
    outM1 = [outM1; out'];
end

% FDR
q = 0.05;
hfdrM0 = [];
cols = 4:6;
for ii = cols
    pvals = outM1(:, ii);
    [hfdr, crit_p, adj_ci_cvrg, adj_p]=fdr_bh(pvals, q, 'pdep','yes');
    hfdrM0 = [hfdrM0 hfdr];
end
outM1 = [outM1 hfdrM0];
writematrix(outM1, [printname '1.csv']);

%% GLM for extended six-chennel model
outM3 = [];
sel = (hcsz2 < 2);
hcsz3 = hcsz2(sel);
saliency_score1 = meansaliency(sel,16); % LumM
saliency_score2 = meansaliency(sel,17); % LumP
saliency_score3 = meansaliency(sel,18); % LumK
saliency_score4 = meansaliency(sel,19); % OriM
saliency_score5 = meansaliency(sel,20); % OriP
saliency_score6 = meansaliency(sel,21); % OriK

for col = 1:size(emsdata,2)
    val = emsdata(sel, col);

    tbl = table(val, saliency_score1, saliency_score2, saliency_score3, saliency_score4, saliency_score5, saliency_score6, hcsz3);
    if ismember(col, patient_only)
        mdl = fitlm(tbl,'val ~ saliency_score1 + saliency_score2 + saliency_score3 + saliency_score4 + saliency_score5 + saliency_score6');
    else
        mdl = fitlm(tbl,'val ~ hcsz3 + saliency_score1 + saliency_score2 + saliency_score3 + saliency_score4 + saliency_score5 + saliency_score6');
    end

    out = [mdl.Coefficients.tStat(2:7); mdl.Coefficients.pValue(2:7)];
    outM3 = [outM3; out'];
end

% FDR
hfdrM1 = [];
cols2 = [7:12];
for ii = cols2
    pvals = outM3(:, ii);
    [hfdr, crit_p, adj_ci_cvrg, adj_p]=fdr_bh(pvals, q, 'pdep','yes');
    hfdrM1 = [hfdrM1 hfdr];
end
outM3 = [outM3 hfdrM1];
writematrix(outM3, [printname '2.csv']);

%% t-value‚Ìbar plot
fig6 = figure();
fig6.PaperOrientation = 'portrait';
fig6.PaperPosition = [0.63452 1.0655 18 28];
for ii = 1:3
    sp = subplot(9,1,6+ii);
    pl = bar(abs(outM1(:,4-ii)));

    pl.FaceColor = [1 1 1];
    pl.EdgeColor = [0 0 0];
    pl.LineWidth = 1;

    sp.Box = 'off';
    sp.XTick = [];
    sp.YTick = 0:5:10;
    axis([0 size(emsdata,2)+1 0 11])
end

for ii = 1:6
    sp = subplot(9,1,ii);
    pl = bar(abs(outM3(:,7-ii)));

    pl.FaceColor = [1 1 1];
    pl.EdgeColor = [0 0 0];
    pl.LineWidth = 1;

    sp.Box = 'off';
    sp.XTick = [];
    sp.YTick = 0:5:10;
    axis([0 size(emsdata,2)+1 0 11])
end

print(fig6, [printname '2c'], '-dpdf')


return
