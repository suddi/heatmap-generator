function [isCorrect] = checkAnswer(isSame, key)
%CHECKANSWER Check the answer based on key pressed and confirm if answer is
% correct
    switch key
        case 'z'
            if isSame == 1
                isCorrect = true;
            else
                isCorrect = false;
            end
        case 'm'
            if isSame == 0
                isCorrect = true;
            else
                isCorrect = false;
            end
    end
    clear isSame key;
end

