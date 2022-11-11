clearvars;
% for replication
rng('default')

%% ボツ
sz_age = round(randn(1, 82)'*12.4 + 35.1);
hc_age = round(randn(1,252)'*11.5 + 28.8);

% mean(sz_age) =       37.159
% std(sz_age) =       14.493
% mean(hc_age) =       27.655
% std(hc_age) =       11.439

% diag	age
d2 = [ones(82,1) sz_age; zeros(252,1) hc_age;];
writematrix(d2, 'subject_label12.csv');

%% こっちを採用

sz_age  = randi([18 60],  82,1);
hc_age = [randi([18 60], 164,1); randi([18 30],  88,1)];

mean(sz_age)
std(sz_age)
mean(hc_age)
std(hc_age)

% diag	age
d2 = [ones(82,1) sz_age; zeros(252,1) hc_age;];
writematrix(d2, 'subject_label12.csv');
