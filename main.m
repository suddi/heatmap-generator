function main(filename)
%MAIN Load a Tab Seperated Values file and create a heat map from it
   
    settings;

    [trials, stat] = loadData(filename);
    subject = regexp(filename, TXT_REGEX, 'tokens');
    
    if ADD2MATRIX
        matrix = [];
        for i = 1:OBJECT_SETS
            index = find([trials.objectSet] == i);
            objectSet = trials(index);
            
            for j = 1:PER_SET
                if INTERCHANGABLE
                    index1 = find([objectSet.leftObject] == j);
                    index2 = find([objectSet.rightObject] == j);
                    index = cat(2, index1, index2);
                    matrix = add2Matrix(matrix, objectSet(index), 'EITHER');
                else
                    isLeft = any(j == LEFT_IMG);
                    if isLeft
                        index = find([objectSet.leftObject] == j);
                        matrix = add2Matrix(matrix, objectSet(index), 'LEFT');
                    else
                        index = find([objectSet.rightObject] == j);
                        matrix = add2Matrix(matrix, objectSet(index), 'RIGHT');
                    end
                end
            end
        end
        matrix2 = pinv(matrix);
        filename = ['map_data_', subject{1}{1}, '.mat'];
        save(filename, 'matrix', 'matrix2');
        clear index objectSet isLeft matrix matrix2;
    else
        if strcmp(DISTINGUISH, '') && RENDER == OBJECT
            bg = zeros(IMAGE_SIZE);
        else
            bg = zeros(MAP_SIZE);
        end
        bg(:, :, 1) = BG_COLOR(1);
        bg(:, :, 2) = BG_COLOR(2);
        bg(:, :, 3) = BG_COLOR(3);

        if RENDER == TRIAL
            for i = 1:size(trials, 2)
                initMap(subject{1}{1}, [trials(i)], bg, 'BOTH');
            end
        else
            for i = 1:OBJECT_SETS
                index = find([trials.objectSet] == i);
                objectSet = trials(index);

                if RENDER == OBJECT
                    for j = 1:PER_SET
                        if INTERCHANGABLE
                            index1 = find([objectSet.leftObject] == j);
                            index2 = find([objectSet.rightObject] == j);
                            index = cat(2, index1, index2);
                            initMap(subject{1}{1}, objectSet(index), bg, 'EITHER');
                        else
                            isLeft = any(j == LEFT_IMG);
                            if isLeft
                                index = find([objectSet.leftObject] == j);
                                initMap(subject{1}{1}, objectSet(index), bg, 'LEFT');
                            else
                                index = find([objectSet.rightObject] == j);
                                initMap(subject{1}{1}, objectSet(index), bg, 'RIGHT');
                            end
                        end
                        
                        clear isLeft index index1 index2;
                    end
                    clear objectSet;
                elseif RENDER == PAIR
                    for j = 1:size(LEFT_IMG, 2)
                        for k = 1:size(RIGHT_IMG, 2)
                            index = find([objectSet.leftObject] == LEFT_IMG(j) & ...
                                         [objectSet.rightObject] == RIGHT_IMG(k));
                            initMap(subject{1}{1}, objectSet(index), bg, 'BOTH');
                            
                            if INTERCHANGABLE
                                index = find([objectSet.leftObject] == RIGHT_IMG(k) & ...
                                             [objectSet.rightObject] == LEFT_IMG(j));
                                initMap(subject{1}{1}, objectSet(index), bg, 'BOTH');
                            end
                        end
                    end
                    clear index;
                end
            end
        end
    end
    
    if SAVE_TO_MAT
        filename = ['subject_data_', subject{1}{1}, '.mat'];
        save(filename, 'trials', 'stat');
        clear subject filename;
    end
    clear trials stat bg;
end
