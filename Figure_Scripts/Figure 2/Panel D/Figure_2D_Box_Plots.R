# Boxplot with outliers shown
# Jason Grayson
# 4-27-22

rm(list=ls())
library(tidyverse)
setwd("~/Desktop/Code copy/Figure 2/Panel D")
load("~/Desktop/Code copy/Figure 2/Panel D/Box_plot_Data_CD4.RDa")
#Plot cluster of interest
g1<-ggplot(df, aes(x=df$Disease_Classifier, y=df$`Cluster 3`)) +theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+ ggtitle("Cluster 3")+theme(plot.title = element_text(size=20)) + theme(plot.title = element_text(hjust = 0.5))+geom_boxplot()
g1<-g1+xlab("Disease Classifier")+ylab("% of CD45+ Cells")
g1<-g1+theme(axis.title.x=element_blank())+theme(axis.text.x = element_text(size = 15))+theme(axis.text.y = element_text(size = 15))+theme(axis.title.y = element_text(size = 15))+theme(axis.title.y = element_text(margin = margin(r = 25)))   
g1

