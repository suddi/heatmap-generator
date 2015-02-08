function initMap(subject, mapSet, bg, type)
%INITMAP Initializes the map and runs through the functions to create a
%heatmap
    
    settings;
    
    if strcmp(type, 'BOTH')
        imageNames = [mapSet(1).leftImage; mapSet(1).rightImage];
    elseif strcmp(DISTINGUISH, '') && strcmp(type, 'LEFT')
        imageNames = [mapSet(1).leftImage];
    elseif strcmp(type, 'LEFT')
        imageNames = [mapSet(1).leftImage; mapSet(1).leftImage];
    elseif strcmp(DISTINGUISH, '') && strcmp(type, 'RIGHT')
        imageNames = [mapSet(1).rightImage];
    elseif strcmp(type, 'RIGHT')
        imageNames = [mapSet(1).rightImage; mapSet(1).rightImage];
    elseif strcmp(DISTINGUISH, '') && strcmp(type, 'EITHER')
        imageNames = [mapSet(1).leftImage];
    elseif strcmp(type, 'EITHER')
        imageNames = [mapSet(1).leftImage; mapSet(1).leftImage];
    end

    [img, alpha] = createImage(imageNames, bg);
    [heatmap, threshold] = createMap(mapSet, type);
    merge = combineImage(img, heatmap, threshold);
    if USE_MAP == COLOR_MAP
        merge = writeCaption(mapSet, merge, type);
    else 
        img = writeCaption(mapSet, img, type);
    end
    saveMap(subject, mapSet(1), merge, img, type);
    clear mapSet bg type imageNames img heatmap threshold;
end

