## Heatmap Generator ##

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/33ba494f09e64e07871f31ff547ea36b)](https://www.codacy.com/app/Suddi/heatmap-generator?utm_source=github.com&utm_medium=referral&utm_content=suddi/heatmap-generator&utm_campaign=badger)
[![license](https://img.shields.io/github/license/suddi/heatmap-generator.svg?maxAge=2592000)](https://github.com/suddi/heatmap-generator/blob/master/LICENSE)

Generates heatmaps for eyetracking data fed in text format from EyeLink.

Required input in text file:

    TRIAL_INDEX
    LEFT_IMAGE
    RIGHT_IMAGE
    SAME
    EYE_USED
    KEY_PRESSED
    RESPONSE_TIME
    TRIAL_FIXATION_TOTAL
    CURRENT_FIX_INDEX
    CURRENT_FIX_DURATION
    CURRENT_FIX_X
    CURRENT_FIX_Y
    CURRENT_FIX_PUPIL

Data must be supplied as TSV (Tab Seperated Values) into `main.m`


### Usage ###

To use please add in the colormaps, curvemaps and normalmaps of the images used in the eyetracking experiment into `images/`, `images/curvemaps/` and `images/normalmaps` respectively.

Further settings can be found in `settings.m`.

To run:

    $ main(<filename>);

Example of heatmap created:

![Sample](sample.png)
