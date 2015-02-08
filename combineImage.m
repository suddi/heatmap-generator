function [merge] = combineImage(img, heatmap, threshold)
%COMBINEIMAGE Combine the image and heat map into one image
 
    settings;
    
    if USE_MAP ~= COLOR_MAP
        merge = zeros(IMAGE_SIZE, IMAGE_SIZE);
    elseif strcmp(DISTINGUISH, '') && RENDER == OBJECT
        merge = zeros(IMAGE_SIZE, IMAGE_SIZE, 3);
    else
        merge = zeros(MAP_SIZE);
    end
    if USE_MAP == COLOR_MAP
        heatmap = im2double(heatmap);
        for i = 1:3
            merge(:, :, i) = img(:, :, i).*(1 - threshold) + heatmap(:, :, i).*threshold;
        end
    elseif USE_MAP == CURVE_MAP || USE_MAP == NORMAL_MAP
        maxValue = max(max(threshold));
        merge(:, :) = 0.3 + threshold(:, :) / maxValue;
    end
    clear img heatmap threshold;
end

