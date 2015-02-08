function [validation, percentCorrect, partialCorrect] = objectFromMap()
%OBJECTFROMMAP When fed in the fixation map from the trial number, this
%will figure out the object being shown
    settings;
    
    load('subject_data_SR.mat');
    load('map_data_SR.mat');
    
    validation(OBJECT_SETS * PER_SET) = struct( ...
        'calcSet', 0, ...
        'calcObject', 0, ...
        'actualSet', 0, ...
        'actualObject', 0, ...
        'isCorrect', -1 ...
    );
    
    for i = 1:OBJECT_SETS
        index = find([trials.objectSet] == i);
        objectSet = trials(index);
        for j = 1:PER_SET
            index1 = find([objectSet.leftObject] == j);
            index2 = find([objectSet.rightObject] == j);
            index = cat(2, index1, index2);
            mapSet = objectSet(index);
            map = add2Matrix([], mapSet, 'EITHER');
            t = matrix2 * map;
            index = find(t == max(t(:)));

            pos = ((i - 1) * 4) + j;
            validation(pos).calcSet = floor(index / 4) + 1;
            validation(pos).calcObject = mod(index, 4);
            validation(pos).actualSet = i;
            validation(pos).actualObject = j;
            if validation(pos).calcSet == i && validation(pos).calcObject == j
                validation(pos).isCorrect = CORRECT;
            elseif validation(pos).calcSet == i
                validation(pos).isCorrect = PARTIAL;
            else
                validation(pos).isCorrect = INCORRECT;
            end
        end
    end
    total = size(validation, 2);
    numCorrect = size(find([validation.isCorrect] == CORRECT), 2);
    numPartial = numCorrect + size(find([validation.isCorrect] == PARTIAL), 2);
    % numIncorrect = size(find([validation.isCorrect] == INCORRECT), 2);
    percentCorrect = (numCorrect / total) * 100;
    partialCorrect = (numPartial / total) * 100;
    
    clear INCORRECT PARTIAL CORRECT index objectSet index1 index2 mapSet map t pos;
end

