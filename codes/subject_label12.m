clearvars;
data = readtable('subject_label12.csv', 'FileType','text',...
                         'ReadVariableNames', 0, 'Delimiter', ',');
sc = [];
% diag	age
sc.demographics = [data.Var1 data.Var2];

save('subject_label12.mat', 'sc');
