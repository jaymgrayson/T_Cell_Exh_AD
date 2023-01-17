#Surface Import Script
#Designed to take FCS files, append key information and make a data frame
#Developed in Grayson Laboratory 2017-2023 using FOSS packages

#Bring in libraries needed
library(flowCore)
library(tidyverse)
#Clear workspace
rm(list=ls())
#Set working directory
setwd("your working directory")
# list all files from the current directory.Use the pattern argument to define a common pattern  for import files with regex. Here: .fcs
list.files(pattern=".fcs$")
##Read label csv file into R (Note should have key patient info here)
Label<-read.csv(file="Label.csv")
## create a list of fcs files
## The number of objects printed from list.files should equal the number of obs. in your Label dataframe 
list.filenames <- list.files(pattern=".fcs$")
print(list.filenames)

## create an empty list that will serve as a container to receive the incoming files
list.data<-list()

# create a loop to read in your data
for (i in 1:length(list.filenames))
{
  list.data[[i]]<-read.FCS(list.filenames[[i]],transformation = FALSE)
  
  list.data[[i]]<-as.data.frame(exprs(list.data[[i]]))
  
  ## take out variables that could be similar 
  list.data[[i]] <- list.data[[i]][,-c(1:7,10,12,20,24,25)]
  
  
  ## remove saturated values (defined manually as >2 x10 +5 on Fortessa)
  RM <- 
    
    (list.data[[i]][,1] > 200000)|
    
    (list.data[[i]][,2]> 200000)|
    
    (list.data[[i]][,3]> 200000)|
    
    (list.data[[i]][,4]> 200000)|
    
    (list.data[[i]][,5]> 200000)|
    
    (list.data[[i]][,6]> 200000)|
    
    (list.data[[i]][,7]> 200000)|
    
    (list.data[[i]][,8]> 200000)|
    
    (list.data[[i]][,9]> 200000)|
    
    (list.data[[i]][,10]> 200000)|
    
    (list.data[[i]][,11]> 200000)|
  
    (list.data[[i]][,12]> 200000)|
  
    (list.data[[i]][,13]> 200000)
  list.data[[i]]<-list.data[[i]][!RM,]
  
  ##add labels to dataset (Yours may vary)
  list.data[[i]] <- cbind(list.data[[i]], Patient = rep(Label$Pt[i],nrow(list.data[[i]])))
}  

##convert the list to a dataframe
Cell_Surface_with_label <- NULL
for (i in 1:length(list.filenames))
{
  Cell_Surface_with_label<- rbind(Cell_Surface_with_label,list.data[[i]])
}

##name the variables ##Change to respective Surface or ICS antibodies
colnames(Cell_Surface_with_label ) <- c("Your antigen names", "Your demogrpahic names") 
AD_PBMC<-Cell_Surface_with_label
##save the data
AD_PBMC<-AD_PBMC
save(AD_PBMC ,file="AD_PBMC.Rda")
#This dataframe can now go into FlowTrans script
