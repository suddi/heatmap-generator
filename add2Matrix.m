function matrix = add2Matrix(matrix, mapSet, type)
%ADD2MATRIX Save the color matrix of all the images
    
    [heatmap, threshold] = createMap(mapSet, type); 
    matrix = cat(2, matrix, reshape(threshold', 100, 1));
    
    clear heatmap threshold;
end

