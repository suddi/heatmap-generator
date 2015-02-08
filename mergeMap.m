function mergeMap(leftDir, rightDir)
%COMBINEMAP Combine images from two different directories into one image

    settings;
    
    leftImages = dir([leftDir, '*.png']);
    rightImages = dir([rightDir, '*.png']);
    
    if size(leftImages, 1) == 0
        disp(['There are no PNG images in the directory: ', leftDir]);
    elseif size(rightImages, 1) == 0
        disp(['There are no PNG images in the directory: ', rightDir]);
    end
    
    bg = zeros(MAP_SIZE);
    bg(:, :, 1) = BG_COLOR(1);
    bg(:, :, 2) = BG_COLOR(2);
    bg(:, :, 3) = BG_COLOR(3);
    
    li = regexp(leftImages(1).name, MAP_REGEX, 'tokens');
    li = li{1};
    ri = regexp(rightImages(1).name, MAP_REGEX, 'tokens');
    ri = ri{1};
    directory = [OBJECT_DIRECTORY, li{3}, '_', ri{3}, '/'];
    createDir(directory);
    clear li ri directory;

    if size(leftImages, 1) == size(rightImages, 1)
        for i = 1:size(leftImages, 1)
            merge = bg;
            img = imread([leftDir, leftImages(i).name]);
            merge(LEFT_POS(1) + (1:IMAGE_SIZE), LEFT_POS(2) + (1:IMAGE_SIZE), :) = img;
            
            img = imread([rightDir, rightImages(i).name]);
            merge(RIGHT_POS(1) + (1:IMAGE_SIZE), RIGHT_POS(2) + (1:IMAGE_SIZE), :) = img;
            merge = merge./256;
            
            li = regexp(leftImages(i).name, MAP_REGEX, 'tokens');
            li = li{1};
            ri = regexp(rightImages(i).name, MAP_REGEX, 'tokens');
            ri = ri{1};
            imwrite(merge, [directory, li{1}, '_', li{2}, '_', li{3}, '_', ri{3}, '.png']);
            clear merge img li ri;
        end
    else
        disp('There were not equivalent number of images in both directories to perform merge operation');
    end
    clear leftDir rightDir leftImages rightImages bg;
end

