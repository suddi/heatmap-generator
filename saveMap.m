function saveMap(subject, trial, heatmap, img, type)
%SAVEMAP Save the heat map to the appropriate directory

    settings;
    
    addDir = '';
    suffix = '.png';
    if ~strcmp(DISTINGUISH, '')
        if RENDER == OBJECT
            if strcmp(DISTINGUISH, 'correct')
                word = 'correct_incorrect';
            elseif strcmp(DISTINGUISH, 'same')
                word = 'same_different';
            end
        else
            word = DISTINGUISH;
        end
        addDir = [word, '/'];
        suffix = ['_', word, '.png'];
    end
    clear word;
    
    subjectDir = [subject, '/'];
    switch RENDER
        case TRIAL
            dir = [HEATMAP_DIRECTORY, subjectDir, TRIAL_DIRECTORY, ...
                   int2str(trial.objectSet), '_', ...
                   int2str(trial.leftObject), '_', ...
                   int2str(trial.rightObject), '/'];
            createDir(dir);
            filename = [dir, 'trial_', int2str(trial.trialNum), suffix];
            imwrite(heatmap, filename);
        case PAIR
            dir = [HEATMAP_DIRECTORY, subjectDir, PAIR_DIRECTORY, addDir];
            createDir(dir);
            filename = [dir, int2str(trial.objectSet), '_', ...
                        int2str(trial.leftObject), '_', ...
                        int2str(trial.rightObject), suffix];
            imwrite(heatmap, filename);
        case OBJECT           
            if USE_MAP == COLOR_MAP
                dir = [HEATMAP_DIRECTORY, subjectDir, OBJECT_DIRECTORY, addDir];
                createDir(dir);
                
                if strcmp(type, 'LEFT')
                    filename = [dir, int2str(trial.objectSet), '_', ...
                                int2str(trial.leftObject), suffix];
                elseif strcmp(type, 'RIGHT')
                    filename = [dir, int2str(trial.objectSet), '_', ...
                                int2str(trial.rightObject), suffix];
                elseif strcmp(type, 'EITHER')
                    filename = [dir, int2str(trial.objectSet), '_', ...
                                int2str(trial.leftObject), suffix];
                end
                imwrite(heatmap, filename);
            elseif USE_MAP == CURVE_MAP
                dir = [HEATMAP_DIRECTORY, subjectDir, OBJECT_DIRECTORY, CURVE_DIRECTORY];
                createDir(dir);
                filename = [dir, 'curvemap_', int2str(trial.objectSet), '_', ...
                            int2str(trial.leftObject), suffix];
                imwrite(img, filename, 'Alpha', heatmap);
            elseif USE_MAP == NORMAL_MAP
                dir = [HEATMAP_DIRECTORY, subjectDir, OBJECT_DIRECTORY, NORMAL_DIRECTORY];
                createDir(dir);
                filename = [dir, 'normalmap_', int2str(trial.objectSet), '_', ...
                            int2str(trial.leftObject), suffix];
                imwrite(img, filename, 'Alpha', heatmap);
            end
    end
    clear trial heatmap type addDir suffix dir filename;
end

