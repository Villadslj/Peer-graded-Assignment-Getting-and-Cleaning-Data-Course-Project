# Code Book

## Introduction
This code book describes the variables, data, and transformations performed to create the tidy dataset `tidy_data.txt`.

## Variables
- **subject**: Identifier of the subject who performed the activity (integer, 1–30).
- **activity**: Activity name (factor, e.g., "WALKING", "SITTING").
- **Measurements**: The rest of the variables are ether a "Time" or "Frequency" measuremnt of the subjects bodies using a gyroscope or accelerometer. 
The last part of the variable names is ether std for standard deviation or mean of the mean values.


## Transformations
1. The training and test datasets were merged.
2. Only mean and standard deviation measurements were extracted.
3. Activity IDs were replaced with descriptive activity names.
4. Descriptive variable names were applied.
5. The tidy dataset was created by averaging each variable for each subject and activity.

## Summaries
- Each variable in the tidy dataset represents the mean value of the corresponding measurement for each subject and activity combination.
