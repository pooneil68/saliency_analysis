clearvars;
load subject_label12

% for replication
rng('default')

hcsp = sc.demographics(:,1); % 1: patient, 0: control
age = sc.demographics(:,2);

age_sz = age(hcsp==1);
age_hc = age(hcsp==0);
binw = 4;
agebins =13.5:binw:69.5;

hist_sz = histcounts(age_sz, agebins);
hist_hc = histcounts(age_hc, agebins);

%%
num = min([hist_sz; hist_hc],[],1); % to match with subject_label12
idxM = [];
for jj=1:100
idx = [];
for ii=2:length(agebins)-1
    sel = find(hcsp==0 & age > agebins(ii) & age < agebins(ii+1));
    rpm = randperm(length(sel));
    sel2 = sel(rpm(1:num(ii)));
    idx = union(idx, sel2);
end
idxM = [idxM idx];
end

%%
save('idxM0419', 'idxM');
return

