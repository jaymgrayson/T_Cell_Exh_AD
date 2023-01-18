# Pan, 5K sampled, UMAP and Phenograph analyses
# Jason M. Grayson
# Started 04-04-22

rm(list=ls())
library(tidyverse)
library(splitstackshape)
# Set working directory
setwd("~/Desktop/Code copy/Figure 4/Panel_B")
load("~/Desktop/Code copy/Figure 4/Panel_B/CD8_PI_UMAP_data.RDa")
PI_data2<-ggplot(df2, aes(x=V1, y=V2, color=df2$Phenograph_Cluster))+ geom_point(size=0.1)+facet_wrap(~df2$Disease_Classifier)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+ ggtitle("CD8+ T Cell Function") + theme(plot.title = element_text(hjust = 0.5))+ labs(colour = "Phenograph Cluster")+guides(color = guide_legend(override.aes = list(size = 5)))

PI_data2
