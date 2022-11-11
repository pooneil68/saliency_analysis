function Cliff_d = computeCliff_delta(sal_sz, sal_hc, stats)
% Yoshida 20220429
  
    W = stats.ranksum;
    U = W - length(sal_sz)*(length(sal_sz)+1)/2;
    Cliff_d = 2 * U / (length(sal_sz) * length(sal_hc)) - 1;

end