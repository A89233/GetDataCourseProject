---
title: "README.md"
author: "Venkat Gullapalli"
date: "January 22, 2015"
output: html_document
---
# Getting and Cleaning Data Course Project

## Overview

- This project downloads, merges and creates a tidy data set for further usage.
- This Readme file has details about the project.
- run_analysis.R has the R code required for anybody to run.
- codebook file has the description of the data used in this project.

## Links

[Download data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

[Description of data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[run_analysis.R](run_analysis.R)

[codebook.md](codebook.md)


## How to create the tidy data set

- Clone this repository
- source run_analysis.R in your working directory
- UCI_HAR_tidydata.txt is created in your working directory

## run_analysis steps
- load required libraries - dplyr
- Create working directory if doesn't exist
- Download the data package and unzip into working directory
- read the activity and features files downloaded and store in data frames
- read the train data and test data and merge them for x, y and subject
-      x has the measurements
-      y has the activity measured
-      subject has the device id
- assign column names for dataframes created
- modify y_data with activity labels 
- select columns wth "mean" or "std"
- combine all data column binding subject, activity and measurements
- group all data by subject and activity
- create tidy data frame bby calculating average of measurements by activity by subject
- write tidy data created to a file for future usage
- set working directory back to previous

