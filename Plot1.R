# Course Project 1 "Exploratory Data Analysis"
# Create Plot 1 as described in Course Project

# set working directory
workDir <- "C:/Users/rohan/Documents/R/R Documents/Coursera/Exploratory Data Analysis"
setwd(workDir)

# use data.table package to read the large data

# if data.table package is not available install it
# install.packages("data.table")

library(data.table)

# download the data as per instructions in the course project page
urlData <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileData <- "HH_Pwr_Cnsmptn"
download.file(urlData, fileData)

# unzip the data to the working directory
unzip(fileData, exdir = workDir)

# Read the large dataset using fread
projectData <- fread("household_power_consumption.txt")

# next step is to Clean the data
## format date variables
## subset the data using the formatted date variable
## format other columns to numeric 

# change date and time variables from characters to date
# check class of projectData$Date and projectData$Time
# class(projectData$Date)
# class(projectData$Time)

# Change format of Date variable to Date
projectData$Date <- as.Date(projectData$Date, format="%d/%m/%Y")

# check class of projectData$Date
# class(projectData$Date)

# subset the data using the formatted date variable
# the course project only requires us to use
# data from the dates 2007-02-01 and 2007-02-02
projectDataSubset <- projectData[projectData$Date=="2007-02-01" | projectData$Date=="2007-02-02"]

# Convert data subset to a data frame

# check class of projectData
# class(projectDataSubset)
projectDataSubset <- data.frame(projectDataSubset)

# format other columns to numeric
for(i in c(3:9)) {projectDataSubset[,i] <- as.numeric(as.character(projectDataSubset[,i]))}

# Write clean data subset to csv
write.csv(projectDataSubset, file = "HH Pwr Cnsmptn SS.csv")

# Open and read clean subset Data File
finalData <- read.csv("HH Pwr Cnsmptn SS.csv")

# Combine Date and Time to create a new Date_Time variable
finalData$Date_Time <- paste(finalData$Date, finalData$Time)

# Convert Date_Time variable to proper format
finalData$Date_Time <- strptime(finalData$Date_Time, format="%Y-%m-%d %H:%M:%S")

# check class of finalData
# class(finalData)

# Create Plot 1 as described in Course Project

## Turn on png device
## Set parameters
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(finalData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)")

## Turn off device 
dev.off()
