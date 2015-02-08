% EXPERIMENT PARAMETERS ---------------------------------------------------
% Total number of trials
NUM_TRIALS = 576;
% Object sets in the experiment
OBJECT_SETS = 24;
% Objects per set
PER_SET = 4;
% Objects to be displayed on the left
% Not applicable if images are interchangable (ie. INTERCHANGABLE = true)
LEFT_IMG = [1, 2];
% Objects to be displayed on the right\
% Not applicable if images are interchangable (ie. INTERCHANGABLE = true)
RIGHT_IMG = [3, 4];
% Number of repetitions of each object
IMG_REPEAT = 12;
% Set to true if objects in each set are interchangable in their position
INTERCHANGABLE = true;


% SAVING PARAMETERS -------------------------------------------------------
% Save trial data to .mat format
SAVE_TO_MAT = true;
% Create reference matrix
ADD2MATRIX = false;

% INPUT DIRECTORIES:
% Directory for input colormap images
IMAGE_DIRECTORY = './images/';
% Directory for input curvemap images
CURVE_DIRECTORY = 'curvemaps/';
% Directory for input normalmap images
NORMAL_DIRECTORY = 'normalmaps/';

% Directory for outputting heatmaps
HEATMAP_DIRECTORY = './heatmap/';
% Directory for outputting trial heatmaps
TRIAL_DIRECTORY = 'trial/';
% Directory for outputting pair heatmaps
PAIR_DIRECTORY = 'pair/';
% Directory for outputting object heatmaps
OBJECT_DIRECTORY = 'object/';


% IMAGE PARAMETERS --------------------------------------------------------
% Size of output image, when two objects are displayed in pairs
MAP_SIZE = [1536, 2048, 3];
% Size of individual object images
IMAGE_SIZE = 840;
% Factor to break down the image by
DIV = 1000;
% Color of background
BG_COLOR = [64, 64, 64];

% Coordinates of left image    
LEFT_POS = [348, 122];
% Coordinates of right image
RIGHT_POS = [348, 1086];
% Conversion from left image to right image along the x-axis
LEFT2RIGHT = 964;


% HEATMAP PARAMETERS ------------------------------------------------------
% Gaussian width to use for TRIAL renders
TRIAL_GAUSSIAN = 0.1;
% Gaussian width to use for PAIR renders
PAIR_GAUSSIAN = 0.07;
% Gaussian width to use for OBJECT renders
OBJECT_GAUSSIAN = 0.04;
% Gaussian width to use for MATRIX renders
MATRIX_GAUSSIAN = 0.3;


% RENDER PARAMETERS -------------------------------------------------------
% Render for:
TRIAL = 0;
PAIR = 1;
OBJECT = 2;
% Choose rendering method:
% TRIAL - renders per trial
% PAIR - renders per pair
% OBJECT - renders per object
RENDER = OBJECT;

% Choose a method to distinguish objects:
% '' - do not distinguish (Applicable to all rendering methods)
% 'correct' - separate by correct trials (Applicable to PAIR and OBJECT renders)
% 'incorrect' - separate by incorrect trials (Applicable to PAIR renders)
% 'same' - separate by same object trials (Applicable to PAIR and OBJECT renders)
DISTINGUISH = '';

% Display on a map:
COLOR_MAP = 0;
CURVE_MAP = 1;
NORMAL_MAP = 2;
% Choose map to use:
% COLOR_MAP - uses the actual object image
% CURVE_MAP - uses the curve map for the object
% NORMAL_MAP - uses the normal map for the object
USE_MAP = COLOR_MAP;

% Prefix for filenames of curvemaps and normalmaps
CURVE_MAP_FILENAME = 'wv3_curverender_';
NORMAL_MAP_FILENAME = 'wv3_normalrender_';


% VALIDATION PARAMETERS ---------------------------------------------------
INCORRECT = 0;
PARTIAL = 1;
CORRECT = 2;


% REGEXES -----------------------------------------------------------------
IMG_REGEX = 'wv3_obj(\d+)_(\d{1}).png';
TXT_REGEX = '(\w+)\.txt';
MAP_REGEX = '(\d+)_(\d{1})_(\w+).png';
