# Cluster Quantitation Script
# Jason M. Grayson and Nuri Park
# Started Dec 4,2019

rm(list=ls())

# We need something that is Tidy! Hence Tidyverse
library(tidyverse)
library(splitstackshape)
# Set working directory
setwd("Your working directory")
load("Your phenograph data")
MR_Demo <- read_csv("~/Desktop/AD Machine Learning/MR_Demo.csv")


# Now need percentage of each phenograph cluster for each patient
df_cluster<-df[,c(15,20)]


# Need to know  cluster number for phenograph
table(df_cluster$phenograph_cluster)
# Okay here k=37, change for your analysis
k=30
##create a function to calculate percentage of cells in each cluster
r=0
cluster_ratio<-function(x){
  for (i in 1:k){
    count<-length(x[x==i])
    ratio<-round(count/length(x),4)*100
    r[i]=ratio
  }
  return(r)
}

#apply the cluster_ratio function to calculate the percentage of cell in each cluster
result_of_all<-as.matrix(aggregate(df_cluster$phenograph_cluster, by=list(df_cluster$Patient), FUN=cluster_ratio))


print(result_of_all)
cluster_info<-result_of_all[,-c(1)]
class(cluster_info)<-"numeric"
#Generate a vector containing Cluster labels, depending on the the number of clusters
#used in the analysis, e.g. “Cluster 1, Cluster 2, Cluster 3...”
ClustNum<-c(1:k)
ClustLabels<-NULL
for(i in 1:k){
  ClustLabels<-c(ClustLabels, paste("Cluster",as.character(ClustNum[i])))
}
cluster_info<-as.data.frame(cluster_info)
colnames(cluster_info)<-ClustLabels
Label<-result_of_all[,c(1)]
##create infection label
Label<-as.data.frame(Label)

colnames(Label)<-c("Patient")
df_percentages<-cbind(Label,cluster_info)
df_percentages$Patient<-as.factor(df_percentages$Patient)
save(df_percentages,file="data.Rda")

rm(list=ls())
load(file="data.RDa")
df_all_cs<-df_all[,c(1:30,46)]


ALL_gather <- gather(df_all_cs,"Cluster","percentage_of_cluster",-c(Patient,Disease_Classifier))
Summarized_Data <- as.data.frame(group_by(ALL_gather,Cluster,Disease_Classifier)%>% summarise(mean=mean(percentage_of_cluster),standard_deviation=sd(percentage_of_cluster)))
Summarized_restricted<-Summarized_Data[Summarized_Data$Disease_Classifier!="NA",]
Summarized_restricted<-Summarized_Data[Summarized_Data$Disease_Classifier!="ANMCI",]
