#Script to transform imported flow cytometry data
#Should follow Import script
#Be sure your RDa colnames are properly labeled

## Clean up workspace
rm(list = ls())

## Bring in some libraries 
library(flowCore)
library(flowTrans)
library(tidyverse)

#Set your working directory as needed!
setwd("your directory")

#List all files from the current directory to find RDa needed
list.files() 

#Bring in Rdas of interest
load("your data")

#Convert numeric flow data to matrix and then flowframe
df_surface_data<- as.matrix(df[,-c(12:17)])
df_surface_data<- flowFrame(df_surface_data)

#Transform flow data (can also try biexponential or linglog transformation)
df_surface_data_trans <- flowTrans(dat=df_surface_data,fun="mclMultivArcSinh",colnames(df_surface_data), n2f=FALSE,parameters.only = FALSE)

##extract the transformed data
df_surface_after_trans <- exprs(df_surface_data_trans$result)
df_surface_after_trans<-as.data.frame(df_surface_after_trans)
# Add demogrpahic labels back to transformed data
Labels<-df[,c(12:17)]
df_surface_after_trans<-cbind(df_surface_after_trans,Labels)
##Save the after trans Rda
save(df_surface_after_trans, file = "df_surface_after_trans.Rda")
## Scale transformed data
df_scaled<-scale(df_surface_after_trans[,c(1:11)])
df_scaled_with_label<-cbind(df_scaled,Labels)
save(df_scaled_with_label,file="df_scaled_with_label.Rda")
