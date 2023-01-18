#UMAP model runner
#This script takes the scaled and transformed data and performs UMAP and R #Phenograph
# Started June 14, 2020

rm(list=ls())
#set your working directory to data file
setwd("~your directory")
library(umap)
library(splitstackshape)
library(Rphenograph)
library(tidyverse)

#make a vector of 1 to 10 for each model run
model_runs<-seq(from=1, to=5, by=1)

#load data to be modeled
load("your data")

#Create lists to hold outputs
umap_result<-list()
primary_data<-list()
phenograph_data<-list()
labels_data<-list()
#set wd for model lists
setwd("Model_Lists Directory")
#set up a for loop to iterate over the model runs
for (i in model_runs)
{
 set.seed(i)
  dfs<-df
  #Need to stratify depending on computer and memory
  dfs<-stratified(dfs,c("Tissue","Data_Generated","Patient"),size=5000)
  labels_data[[i]]<-dfs[,c(15:17)]
  dfs<-dfs[,-c(15:17)]
  umap_output<-umap(dfs)
  flow_pheno<-Rphenograph(dfs,k=35)
  phenograph_cluster<-membership(flow_pheno[[2]])
  umap_result[[i]]<-umap_output
  primary_data[[i]]<-dfs
  phenograph_data[[i]]<-phenograph_cluster
}
save(labels_data,file="labels_data.Rda")
save(umap_result,file="umap_data.Rda")
save(primary_data,file="primary_data.Rda")
save(phenograph_data,file="phenograph_data.Rda")

rm(list=ls())
setwd("Model_Lists Directory")
model_runs<-seq(from=1, to=2, by=1)
load("Model_Lists Directory/primary_data.Rda")
load("Model_Lists Directory/umap_data.Rda")
load("Model_Lists Directory/phenograph_data.Rda")
load("Model_Lists Directory/labels_data.Rda")
setwd("~Model_Data Directory")
for (i in model_runs)
  {
  a<-primary_data[[i]]
  b<-umap_result[[i]]
  b2<-b$layout
  c<-phenograph_data[[i]]
  c<-as.factor(c)
  model_version<-cbind(a,b2,c)
  colnames(model_version)[15]<-"V1"
  colnames(model_version)[16]<-"V2"
  colnames(model_version)[17]<-"Phenograph_Cluster"
  l<-labels_data[[i]]
  model_version<-cbind(model_version,l)
  save(model_version,file=paste("model_version",i,".Rda",sep = ""))
}

rm(list=ls())
setwd("~Model_Data Directory")
model_files<-list.files()
for (i in seq_along(model_files))
{
  setwd("Model_Data Directory")
  model_df<-model_files[i]
  title<-model_df
  load(file=model_df)
  df2<-model_version%>%sample_n(size=1000)
  setwd("~Graphs")
  g1<-ggplot(df2, aes(x=V1,y=V2,color=Phenograph_Cluster))+geom_point(size=0.1)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+ guides(color = guide_legend(override.aes = list(size=2)))
  g1<-g1+facet_grid(~Tissue)+ggtitle(title)
  ggsave(file=paste("Phenograph-",title,"png",sep = "."))
  
  }
