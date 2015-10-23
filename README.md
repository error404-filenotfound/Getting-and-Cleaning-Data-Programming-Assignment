# Getting-and-Cleaning-Data-Programming-Assignment

##run_analysis.R 
###Working
The file run_analysis.R is developed to perform the following tasks:
  1. Checks if the file exists in the working directory and downloads and unzips if it doesn't exist.
  2. The raw data is read.
  3. y variables are transformed to include activity labels along with the activity IDs.
  4. The datasets are named and binded together to form 2 datasets, test and train.
  5. The test and train datasets are merged together to form 1 dataset.
  6. The variables with only mean or std in the names are extracted.
  7. tidy dataset is formed with the average of each variable for each activity and each subject using melt and dcast functions.
  
