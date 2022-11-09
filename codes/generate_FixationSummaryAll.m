clearvars;
% for replication
rng('default')
savefile = 'FixationSummaryAll1231.mat';

tt2 = 1301:9000;

FixationSummaryAll = [];
for kk = 1:334
    for stims = 1:56
        % generate random data (20 saccades for each image)
        FixationSummary = NaN(20,6);

        % col1: time of saccade onset (1-9300 in ms)
        tt = randperm(7000);
        tts = sort(tt(1:20))';
        FixationSummary(:,1) = tt2(tts)';
        % col2: time of saccade offset (1-9300 in ms)
        FixationSummary(:,2) = FixationSummary(:,1) + 100;
        % col3: saccade types (not used)
        FixationSummary(:,3) = zeros(20,1);
        % col4: saccade amplitudes
        FixationSummary(:,4) = 2 * ones(20,1);
        % col5: horizontal coordinate of saccade endpoint (1-1280 pixels)
        FixationSummary(:,5) = randi([1 1280],20,1);
        % col6: vertical coordinate of saccade endpoint (1-1024 pixels)
        FixationSummary(:,6) = randi([1 1028],20,1);

        fixdata.FixationSummary = FixationSummary;
        fixdata.valOffset = [0 0 0 0];
        FixationSummaryAll{kk, stims} = fixdata;
    end
end
save(savefile, 'FixationSummaryAll')


