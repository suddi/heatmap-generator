function [trials stat] = loadData(filename)
%LOADDATA Load the data from TSV into memory
    
    settings;

    fid = fopen(filename);
    content = textscan(fid, '%d %s %s %d %s %c %f %d %d %d %f %f %f', 'HeaderLines', 1);
    fclose(fid);
    clear filename fid;
    
    trials(NUM_TRIALS) = struct( ...
        'trialNum', 0, ...
        'leftImage', '', ...
        'rightImage', '', ...
        'objectSet', 0, ...
        'leftObject', 0, ...
        'rightObject', 0, ...
        'isSame', -1, ...
        'eye', '', ...
        'key', '', ...
        'isCorrect', false, ...
        'rt', 0.0, ...
        'totalFix', 0, ...
        'fixData', [] ...
    );    
    
    count = 1;
    for i = 1:size(content{1}, 1);
        newIndex = content{9}(i);
        if newIndex == 1
            trials(count).trialNum = content{1}(i);
            var = content{2}(i);
            trials(count).leftImage = var{1};
            var = content{3}(i);
            trials(count).rightImage = var{1};
            li = regexp(trials(count).leftImage, IMG_REGEX, 'tokens');
            li = li{1};
            ri = regexp(trials(count).rightImage, IMG_REGEX, 'tokens');
            ri = ri{1};
            trials(count).objectSet = str2double(li{1});
            trials(count).leftObject = str2double(li{2});
            trials(count).rightObject = str2double(ri{2});
            
            if (trials(count).rightObject - trials(count).leftObject) == 2 || ...
               (trials(count).rightObject - trials(count).leftObject) == -2
                objSame = true;
            else
                objSame = false;
            end
            if objSame == content{4}(i)
                trials(count).isSame = objSame;
            end
            var = content{5}(i);
            trials(count).eye = var{1};
            trials(count).key = content{6}(i);
            trials(count).isCorrect = checkAnswer(trials(count).isSame, trials(count).key);
            trials(count).rt = content{7}(i);
            trials(count).totalFix = content{8}(i);
            upperIndex = i + trials(count).totalFix - 1;
            fixation = repmat(0.0, trials(count).totalFix, 5);
            fixation(:, 1) = content{9}(i:upperIndex);
            fixation(:, 2) = content{10}(i:upperIndex);
            fixation(:, 3) = content{11}(i:upperIndex);
            fixation(:, 4) = content{12}(i:upperIndex);
            fixation(:, 5) = content{13}(i:upperIndex);
            trials(count).fixData = fixation;
            clear newIndex var li ri upperIndex fixation objSame;
            count = count + 1;
        end
    end
    
    
    stat.hit_rate = find([trials.key] == 'z' & [trials.isSame] == 1);
    stat.hit_rate = size(stat.hit_rate, 2) / 288;
    stat.fa_rate = find([trials.key] == 'z' & [trials.isSame] == 0);
    stat.fa_rate = size(stat.fa_rate, 2) / 288;
    stat.d_prime = norminv(stat.hit_rate) - norminv(stat.fa_rate);    
    clear content count;
end

