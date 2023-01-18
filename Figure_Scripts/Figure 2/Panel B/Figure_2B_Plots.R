# CD4_T_Surface UMAP and Phenograph analyses
# Jason M. Grayson
# Started 04-04-22

rm(list=ls())
library(tidyverse)
library(splitstackshape)
# Set working directory
setwd("~/Desktop/Code copy/Figure 2/Panel B")
#Load Subsampled data
load("~/Desktop/Code copy/Figure 2/Panel B/CD4_T_Surf_Data.RDA")
df2<-df
df2
table(df2$Disease_Classifier)
df2<-stratified(df2,"Disease_Classifier",2500)
# Generate UMAP plot
TS_Sur_data2<-ggplot(df2, aes(x=V1, y=V2, color=phenograph_cluster)) + geom_point(size=0.1)+facet_wrap(~df2$Disease_Classifier)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+ ggtitle("CD4+ T Cell Phenotypic Analysis") + theme(plot.title = element_text(hjust = 0.5))+ labs(colour = "Phenograph Cluster")+guides(color = guide_legend(override.aes = list(size = 5)))
TS_Sur_data2
