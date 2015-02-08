function [img, alpha] = createImage(filename, img)
%CREATEIMAGE Renders the screen image upon which we should add the heat map
    
    settings;
    
    if strcmp(DISTINGUISH, '') && RENDER == OBJECT
        if USE_MAP == COLOR_MAP
            [singleImage, ~, alpha] = imread([IMAGE_DIRECTORY, filename(1, :)]);
        elseif USE_MAP == CURVE_MAP
            ii = regexp(filename(1, :), IMG_REGEX, 'tokens');
            ii = ii{1};
            io = str2double(ii{2});
            if io > 2
                io = io - 2;
            end
            [singleImage, ~, alpha] = imread([IMAGE_DIRECTORY, CURVE_DIRECTORY, ...
                                              CURVE_MAP_FILENAME, ii{1}, '_', ...
                                              num2str(io), '.png']);
        elseif USE_MAP == NORMAL_MAP
            ii = regexp(filename(1, :), IMG_REGEX, 'tokens');
            ii = ii{1};
            io = str2double(ii{2});
            if io > 2
                io = io - 2;
            end
            [singleImage, ~, alpha] = imread([IMAGE_DIRECTORY, NORMAL_DIRECTORY, ...
                                              NORMAL_MAP_FILENAME, ii{1}, '_' ...
                                              num2str(io), '.png']);
        end
        
        if size(singleImage, 3) == 3
            img((1:IMAGE_SIZE), (1:IMAGE_SIZE), :) = singleImage;
        else
            img((1:IMAGE_SIZE), (1:IMAGE_SIZE), 1) = singleImage;
            img((1:IMAGE_SIZE), (1:IMAGE_SIZE), 2) = singleImage;
            img((1:IMAGE_SIZE), (1:IMAGE_SIZE), 3) = singleImage;
        end
        
        clear filename singleImage;
    else
        leftImage = imread([IMAGE_DIRECTORY, filename(1, :)]);
        rightImage = imread([IMAGE_DIRECTORY, filename(2, :)]);
        
        if size(leftImage, 3) == 3 && size(rightImage, 3) == 3
            img(LEFT_POS(1) + (1:IMAGE_SIZE), ...
                LEFT_POS(2)  + (1:IMAGE_SIZE), :) = leftImage;
            img(RIGHT_POS(1) + (1:IMAGE_SIZE), ...
                RIGHT_POS(2)  + (1:IMAGE_SIZE), :) = rightImage;
        else
            img(LEFT_POS(1) + (1:IMAGE_SIZE), ...
                LEFT_POS(2)  + (1:IMAGE_SIZE), 1) = leftImage;
            img(LEFT_POS(1) + (1:IMAGE_SIZE), ...
                LEFT_POS(2)  + (1:IMAGE_SIZE), 2) = leftImage;
            img(LEFT_POS(1) + (1:IMAGE_SIZE), ...
                LEFT_POS(2)  + (1:IMAGE_SIZE), 3) = leftImage;
            img(RIGHT_POS(1) + (1:IMAGE_SIZE), ...
                RIGHT_POS(2)  + (1:IMAGE_SIZE), 1) = rightImage;
            img(RIGHT_POS(1) + (1:IMAGE_SIZE), ...
                RIGHT_POS(2)  + (1:IMAGE_SIZE), 2) = rightImage;
            img(RIGHT_POS(1) + (1:IMAGE_SIZE), ...
                RIGHT_POS(2)  + (1:IMAGE_SIZE), 3) = rightImage;
        end
        
        clear filename leftImage rightImage;
    end
    
    img = img./256;
    % figure(1);
    % image(img);
end

