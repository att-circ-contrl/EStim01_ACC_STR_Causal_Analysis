# EStim01_ACC_STR_Causal_Analysis
## Overview

Data and code for the behavioral analysis of stimulation effects

This repository contains the major MATLAB analysis scripts developed to support the analysis of the Causal Stimulation Effects of the Anterior Cingulate Cortex (ACC) and Striatum. These analyses are associated with the manuscript:

### Adaptive Reinforcement Learning is Causally Supported by Anterior Cingulate Cortex and Striatum 
Currently found: https://www.biorxiv.org/content/10.1101/2024.06.12.598723v2

## Data Files

### Two data files are included in this repository:

* TrialDATA: Contains trial-level behavioral data.

* BlockDATA: Contains block-level behavioral data.

## Behavioral Variables

The following variables are used in the data files:

* sessionNum - Session number

* BlockNum - Block number in the session

* datasetname - Overall experimental name

* trialInExperiment - Trial number in the session [1,2,3,...500, 501...]

* trialInBlock - Trial number relative to that block [1,2,3,...50, 1,2,3,...]

* StimArea - Region receiving stimulation (0=none, 1=ACC, 2=CD)

* monkey - Subject identity (1=monkey 1, 2=monkey 2)

* outcomes_isCorrect - Trial accuracy (0 = error, 1 = correct)

* reactionTime - Time taken to complete the trial

* cndStim - Stimulation during trial (1 = yes, 0 = no)

* cndLOAD - Attentional Load (1, 2, 3)

* GainCond - Gain condition (2, 3)

* LossCond - Loss condition (-1, -3)

* cndTOK - Token condition: 1 = G2L1, 2 = G2L3, 3 = G3L1, 4 = G3L3

* stimBlockCond - Indicates if this was a stimulation block (1, 0)

* stimsessionType - Type of stimulation (1 = SR+, 2 = SR-)

* TargetFeature - Target feature of the block (1 = shape, 2 = pattern, 3 = color, 4 = arm)

* outcome - Token outcome (-3, -2, 0, 1, 2, 3)

* currentNumTokensInTheBar - Number of tokens at the start of the trial

* tokenBarCompleted - Whether the token bar was completed (0, 1)

* allTokenBarsCompleted - Total completed token bars by this point

* ChosenObject - Object chosen in the trial (1, 2, 3)

* CorrectObject - Always Object 1 (1)

* Object1, Object2, Object3 - Relative feature cells

* GazeObjectsType - Types of objects fixated on in the trial

* GazeObjectsDuration - Duration of fixations on objects

* GazeObjects_selecttimestamp - Timestamp of final choice fixation

* durationFixationsPriorToChoice - Total duration of fixations before choice

* numFixationsPriorToChoice - Total number of fixations before choice

* trialsToCriterion - Learning point

* TrialsDL - Trials during learning (1 = yes, 0 = no)

* TrialRelativeLP - Trials relative to the learning point

* cndSTIM_Label - Stimulation labels (e.g., 'nostim', 'stimR+', 'stimR-', 'sham')

* stimulusType - Numeric encoding for stimulation labels

* cndLOAD_Labels - Attentional load labels

* cndTOK_Labels - Token condition labels

* Choice object location - Location of chosen object (1 = top right, 2 = top left, 3 = bottom left, 4 = bottom right)

## Analysis Scripts

This repository includes several analysis scripts for different aspects of the data:

* Blockwise_StimulationEffects.m - Analyzes the effects of stimulation on subject performance at the block level.

* Trialwise_StimulationEffects.m - Analyzes the effects of stimulation on subject performance at the trial level.

* LearningCurves_overall.m - Analyzes overall trial accuracy across different stimulation conditions, regions, and difficulty levels.

* Supplementary_figures.m - Generates supplementary figures, including learning curves in different motivational contexts.

* Exploratory_sampling.m - Analyzes exploratory sampling duration for different stimulation conditions and fixation counts before choice.

* EC_analysis.m - Analyzes trial accuracy following different Error (E) or Correct (C) outcomes.

## Usage

Ensure that the TrialDATA and BlockDATA files are available in your MATLAB workspace.
