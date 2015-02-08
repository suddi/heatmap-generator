function [heatmap, Z] = createMap(mapSet, type)
%CREATEMAP Renders the heat map to be placed over the image previously
%rendered
    
    settings;
    
    if strcmp(DISTINGUISH, '') || RENDER == TRIAL
        [fixCoord, fixDur] = getCoord({mapSet}, type);
    elseif ~strcmp(DISTINGUISH, '')
        if RENDER == OBJECT
            option = [true, false];
            for i = 1:size(option, 2)
                if strcmp(DISTINGUISH, 'correct')
                    index = find([mapSet.isCorrect] == option(i));
                elseif strcmp(DISTINGUISH, 'same')
                    index = find([mapSet.isSame] == option(i));
                end
                subset{i} = mapSet(index);
            end
            [fixCoord, fixDur] = getCoord(subset, type);
        elseif RENDER == PAIR
            if strcmp(DISTINGUISH, 'correct')
                index = find([mapSet.isCorrect] == true);
            elseif strcmp(DISTINGUISH, 'incorrect')
                index = find([mapSet.isCorrect] == false);
            end
            [fixCoord, fixDur] = getCoord({mapSet(index)}, type);
        end
    end
    
    fixCoord = fixCoord./DIV;
    fixDur = fixDur./max(fixDur);

    step = 1.0 / DIV;
    if strcmp(DISTINGUISH, '') && RENDER == OBJECT
        mesh = [IMAGE_SIZE, IMAGE_SIZE]./DIV;
    else
        mesh = [MAP_SIZE(2), MAP_SIZE(1)]./DIV;
    end
    [X, Y] = meshgrid(step:step:mesh(1), step:step:mesh(2));
    clear option index mapSet subset step mesh;
    Z = zeros(size(X));
    
    switch RENDER
        case TRIAL
            gaussianWidth = TRIAL_GAUSSIAN;
        case PAIR
            gaussianWidth = PAIR_GAUSSIAN;
        case OBJECT
            gaussianWidth = OBJECT_GAUSSIAN;
    end
    if ADD2MATRIX
        gaussianWidth = MATRIX_GAUSSIAN;
    end
    
    for i = 1:size(fixDur, 1)
        Z = Z + fixDur(i) * exp(-((X - fixCoord(i, 1)).^2 + ...
           (Y - fixCoord(i, 2)).^2) / (gaussianWidth^2));
    end
    
    % figure(2);
    % surf(X, Y, Z);
    % shading interp;
    % imagesc(Z);
    
    heatmap = jet(Z);
    if ADD2MATRIX
        div = 1.0/84.0;
        heatmap = imresize(heatmap, div);
        Z = imresize(Z, div);
    end
    clear fixCoord fixDur X Y gaussianWidth;
end

