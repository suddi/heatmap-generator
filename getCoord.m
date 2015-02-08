function [fixCoord, fixDur] = getCoord(subset, type)
%GETCOORD Get the fixation coordinates and fixation duration when a subset
%of maps is provided

    settings;
    
    fixCoord = [];
    fixDur = [];
    
    subsetSize = size(subset, 2);
    leftX = IMAGE_SIZE;
    leftY = IMAGE_SIZE;
    rightX = IMAGE_SIZE;
    rightY = IMAGE_SIZE;
    
    if subsetSize > 1
        leftX = leftX + LEFT_POS(2);
        leftY = leftY + LEFT_POS(1);
        rightX = rightX + RIGHT_POS(2);
        rightY = rightY + RIGHT_POS(1);
    end
    
    for i = 1:subsetSize
        if strcmp(type, 'EITHER')
            fixData = cat(1, [], subset{i}(1:size(subset{i}, 2)).fixData);
            if size(fixData, 1) ~= 0
                objectPos = cat(1, [], subset{i}(1:size(subset{i}, 2)).leftObject);
                indexLeft = find(objectPos == subset{i}(1).leftObject);
                indexRight = find(objectPos ~= subset{i}(1).leftObject);
            end
            if strcmp(DISTINGUISH, '')
                hf = IMG_REPEAT/2;
                hf1 = hf + 1;
                fixData = cat(1, [], subset{i}(1:hf).fixData);
                hf = length(fixData);
                fixData = cat(1, fixData, subset{i}(hf1:IMG_REPEAT).fixData);
                f = length(fixData);
            end
            fixData = cat(1, [], subset{i}(1:size(subset{i}, 2)).fixData);
        else
            fixData = cat(1, [], subset{i}(1:size(subset{i}, 2)).fixData);
        end
        
        if size(fixData, 1) == 0
            coord = [];
            dur = [];
        else
            coord = fixData(:, 3:4);
            coordSize = size(coord, 1);
            dur = fixData(:, 2);

            if strcmp(type, 'LEFT')
                if subsetSize == 1
                    coord = [coord(1:coordSize, 1) - LEFT_POS(2), ...
                             coord(1:coordSize, 2) - LEFT_POS(1)];
                end

                if i == 1
                    lowerBound = coord(:, 1) <=  leftX & coord(:, 2) <= leftY;
                    upperBound = coord(:, 1) >= (leftX - IMAGE_SIZE) & coord(:, 2) >= (leftY - IMAGE_SIZE);
                else
                    coord = [coord(1:coordSize, 1) + LEFT2RIGHT, coord(1:coordSize, 2)];
                    lowerBound = coord(:, 1) <=  rightX & coord(:, 2) <= rightY;
                    upperBound = coord(:, 1) >= (rightX - IMAGE_SIZE) & coord(:, 2) >= (rightY - IMAGE_SIZE);
                end
            elseif strcmp(type, 'RIGHT')
                if subsetSize == 1
                    coord = [coord(1:coordSize, 1) - RIGHT_POS(2), ...
                             coord(1:coordSize, 2) - RIGHT_POS(1)]; 
                end

                if i == 1
                    lowerBound = coord(:, 1) <=  rightX & coord(:, 2) <= rightY;
                    upperBound = coord(:, 1) > (rightX - IMAGE_SIZE) & coord(:, 2) > (rightY - IMAGE_SIZE);
                else
                    coord = [coord(1:coordSize, 1) - LEFT2RIGHT, coord(1:coordSize, 2)];
                    lowerBound = coord(:, 1) <=  leftX & coord(:, 2) <= leftY;
                    upperBound = coord(:, 1) > (leftX - IMAGE_SIZE) & coord(:, 2) > (leftY - IMAGE_SIZE);
                end
            elseif strcmp(type, 'EITHER')
                if subsetSize == 1
                    coord(1:hf, :) = [coord(1:hf, 1) - LEFT_POS(2), coord(1:hf, 2) - LEFT_POS(1)];
                    coord(hf+1:f, :) = [coord(hf+1:f, 1) - RIGHT_POS(2), ...
                                        coord(hf+1:f, 2) - RIGHT_POS(1)];
                    lowerBound = coord(:, 1) <=  leftX & coord(:, 2) <= leftY;
                    upperBound = coord(:, 1) >= (leftX - IMAGE_SIZE) & coord(:, 2) >= (leftY - IMAGE_SIZE);
                elseif i == 1
                    coord(indexRight(1:size(indexRight, 2)), :) = ...
                        [coord(indexRight(1:size(indexRight, 2)), 1) - LEFT2RIGHT, ...
                         coord(indexRight(1:size(indexRight, 2)), 2)];
                    lowerBound = coord(:, 1) <=  leftX & coord(:, 2) <= leftY;
                    upperBound = coord(:, 1) > (leftX - IMAGE_SIZE) & coord(:, 2) > (leftY - IMAGE_SIZE);
                else
                    coord(indexLeft(1:size(indexLeft, 2)), :) = ...
                        [coord(indexLeft(1:size(indexLeft, 2)), 1) + LEFT2RIGHT, ...
                         coord(indexLeft(1:size(indexLeft, 2)), 1)];
                    lowerBound = coord(:, 1) <=  rightX & coord(:, 2) <= rightY;
                    upperBound = coord(:, 1) >= (rightX - IMAGE_SIZE) & coord(:, 2) >= (rightY - IMAGE_SIZE);
                end 
            end
        end

        if size(fixData, 1) ~= 0
            indexLower = find(lowerBound == true);
            indexUpper = find(upperBound == true);        
            index = intersect(indexLower, indexUpper);

            fixCoord = cat(1, fixCoord, coord(index, :));
            fixDur = cat(1, fixDur, dur(index, :));
        else
            fixCoord = cat(1, fixCoord, coord);
            fixDur = cat(1, fixDur, dur);
        end
        
        clear fixData coord hf hf1 objectPos indexLeft indexRight f; 
        clear coordsize dur lowerBound upperBound indexUpper indexLower index;
    end
    clear subsetSize leftX leftY rightX rightY;
end

