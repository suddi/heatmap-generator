function [ii, randomRGB, actualRGB] = initTest(mapSet, bg, type)
%INITTEST Initializes the test to see whether the fixations are random or
%inline with the curvemap and/or normalmap
    
    settings;
    
    if strcmp(type, 'RIGHT')
        imageNames = [mapSet(1).rightImage];
    else
        imageNames = [mapSet(1).leftImage];
    end
    
    ii = regexp(imageNames(1, :), IMG_REGEX, 'tokens');
    ii = ii{1};
    [img, alpha] = createImage(imageNames, bg);
    seed = RandStream.create('mt19937ar', 'seed', sum(100*clock));
    RandStream.setGlobalStream(seed);
    
    [fixCoord, fixDur] = getCoord({mapSet}, type);
    points = size(fixCoord, 1);
    fixCoord = round(fixCoord);
    
    randomPoints = round(rand(seed, points, 2).*840);
    
    randomRGB = [];
    actualRGB = [];
    for i = 1:points
        while randomPoints(i, 1) == 0 || randomPoints(i, 2) == 0 || ...
              img(randomPoints(i, 1), randomPoints(i, 2), 1) == 0
            randomPoints(i, :) = round(rand(seed, 1, 2).*840);
        end
        
        randomRGB = cat(1, randomRGB, [ ...
            img(randomPoints(i, 1), randomPoints(i, 2), 1), ...
            img(randomPoints(i, 1), randomPoints(i, 2), 2), ...
            img(randomPoints(i, 1), randomPoints(i, 2), 3)]);
        actualRGB = cat(1, actualRGB, [ ...
            img(fixCoord(i, 1), fixCoord(i, 2), 1), ...
            img(fixCoord(i, 1), fixCoord(i, 2), 2), ...
            img(fixCoord(i, 1), fixCoord(i, 2), 3)]);
    end
    
    randomRGB = [mean(randomRGB(:, 1)) * 256, ...
                 mean(randomRGB(:, 2)) * 256, ...
                 mean(randomRGB(:, 3)) * 256];
    actualRGB = [mean(actualRGB(:, 1)) * 256, ...
                 mean(actualRGB(:, 2)) * 256, ...
                 mean(actualRGB(:, 3)) * 256];
end

