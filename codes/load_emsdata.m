clearvars;

load subject_label12
hcsz = sc.demographics(:,1); % 1がpatient, 0がcontrol

% age-matched control用hcsz2
load idxM0419
hcidx = idxM(:,1); % とりあえず1をつかってやってみる
hcsz2 = hcsz;
hcsz2(hcsz2 == 0) = 3;
hcsz2(hcidx) = 0;

load emsdata0427d

%% Table2 (with ttest2, ranksum, Cohen's d, and Cliff's delta)
dx = [];
for ii = 1:size(emsdata,2)
    em1 = emsdata(hcsz2==1, ii);
    em0r = emsdata(hcsz2==0, ii); % age matched resamples
    em0 = emsdata(hcsz==0, ii); % all healthy control
    dd = [mean(em1,'omitnan') std(em1,'omitnan') ...
          mean(em0r,'omitnan') std(em0r,'omitnan') ...
          mean(em0,'omitnan') std(em0,'omitnan')];
    if any(isnan(dd))
        p1 = NaN; p2 = NaN; Cohen_d = NaN; Cliff_d = NaN;
        p1r = NaN; p2r = NaN; Cohen_dr = NaN; Cliff_dr = NaN;
    else
        [~,p1,~,~] = ttest2(em0,em1);
        Cohen_d = computeCohen_d(em0, em1, 'independent');
        [p2,~,stats] = ranksum(em1,em0);
        Cliff_d = computeCliff_delta(em1, em0, stats);
        Cliff_d = -Cliff_d; % effectの向きを反転させておく

        [~,p1r,~,~] = ttest2(em0r,em1);
        Cohen_dr = computeCohen_d(em0r, em1, 'independent');
        [p2r,~,statsr] = ranksum(em1,em0r);
        Cliff_dr = computeCliff_delta(em1, em0r, statsr);
        Cliff_dr = -Cliff_dr; % effectの向きを反転させておく
    end
    dx = [dx; dd p1 p2 Cohen_d Cliff_d p1r p2r Cohen_dr Cliff_dr];
end

% bonferroni
BFp1 = dx(:,[7 8 11 12]) * 22;
q = 0.05;
FDR07 = fdr_bh(dx(:, 7),q,'pdep','yes');
FDR08 = fdr_bh(dx(:, 8),q,'pdep','yes');
FDR11 = fdr_bh(dx(:,11),q,'pdep','yes');
FDR12 = fdr_bh(dx(:,12),q,'pdep','yes');

dx = [dx BFp1 FDR07 FDR08 FDR11 FDR12];
writematrix(dx, 'dx0429.csv');

%% Test for ratio in Sex/Gender
% All subjects
[tbl,chi2,p3,labels] = crosstab([hcsz],[emsdata(:,1)]);
tbl
% effect size
efs = sqrt(chi2 / sum(tbl(:))); % 0.05132
disp([chi2 p3 efs]) % 0.87967      0.34829      0.05132

% Age-matched
[tbl,chi2,p3,labels] = crosstab([hcsz2(hcsz2 < 2)],[emsdata(hcsz2 < 2,1)]);
tbl
% effect size 
% Phi https://www.real-statistics.com/chi-square-and-f-distributions/effect-size-chi-square/
efs = sqrt(chi2 / sum(tbl(:))); % 0.085525
disp([chi2 p3 efs]) % 1.1996      0.27341     0.085525
