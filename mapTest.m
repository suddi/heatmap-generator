function [data, performance] = mapTest(filename)
%MAPTEST Checks whether fixations are random or whether they are inline
%with the curvemaps and/or normalmaps
    
    settings;
    [trials, stat] = loadData(filename);
    subject = regexp(filename, TXT_REGEX, 'tokens');
    
    bg = zeros(IMAGE_SIZE);
    bg(:, :, 1) = BG_COLOR(1);
    bg(:, :, 2) = BG_COLOR(2);
    bg(:, :, 3) = BG_COLOR(3);
    
    totalObj = OBJECT_SETS * PER_SET;
    data(totalObj) = struct( ...
        'objectSet', 0, ...
        'object', 0, ...
        'randomFixation', [-1, -1, -1], ...
        'actualFixation', [-1, -1, -1], ...
        'redBetter', false, ...
        'greenBetter', false, ...
        'blueBetter', false ...
    );
    
    for i = 1:OBJECT_SETS
        index = find([trials.objectSet] == i);
        objectSet = trials(index);
        
        for j = 1:PER_SET
            if INTERCHANGABLE
                index1 = find([objectSet.leftObject] == j);
                index2 = find([objectSet.rightObject] == j);
                index = cat(2, index1, index2);
                [ii, random, actual] = initTest(objectSet(index), bg, 'EITHER');
            else
                isLeft = any(j == LEFT_IMG);
                if isLeft
                    index = find([objectSet.leftObject] == j);
                    [ii, random, actual] = initTest(objectSet(index), bg, 'LEFT');
                else
                    index = find([objectSet.rightObject] == j);
                    [ii, random, actual] = initTest(objectSet(index), bg, 'RIGHT');
                end
            end
            
            pos = ((i - 1) * 4) + j;
            data(pos).objectSet = str2double(ii{1});
            data(pos).object = str2double(ii{2});
            data(pos).randomFixation = random;
            data(pos).actualFixation = actual;
            
            if actual(1) > random(1)
                data(pos).redBetter = true;
            else
                data(pos).redBetter = false;
            end
            
            if actual(2) > random(2)
                data(pos).greenBetter = true;
            else
                data(pos).greenBetter = false;
            end
            
            if actual(3) > random(3)
                data(pos).blueBetter = true;
            else
                data(pos).blueBetter = false;
            end
            
            clear index1 index2 index isLeft;
        end        
        clear objectSet;
    end
    
    % disp(find([data.redBetter] == true))
    performance = [];
    performance(1) = (size(find([data.redBetter] == true), 2) / totalObj) * 100;
    performance(2) = (size(find([data.greenBetter] == true), 2) / totalObj) * 100;
    performance(3) = (size(find([data.blueBetter] == true), 2) / totalObj) * 100;
end

