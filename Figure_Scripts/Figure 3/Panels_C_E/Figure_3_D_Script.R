# Need a pretty figure for grant. Boxplot with outliers shown
# Jason Grayson
# 4-27-22

rm(list=ls())
library(tidyverse)
setwd("~/Desktop/Code copy/Figure 3/Panels_C_E")
load("~/Desktop/Code copy/Figure 3/Panels_C_E/CD4_PI_Stim.RDa")

g1<-ggplot(df, aes(x=df$Stimulation, y=df$`TNFa SP`)) +theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+ ggtitle("IFNg neg TNFa Producing CD4+ T Cells")+theme(plot.title = element_text(size=20)) + theme(plot.title = element_text(hjust = 0.5))+geom_boxplot()
g1<-g1+xlab("Stimulation")+ylab("% of CD45+ Cells")
g1<-g1+theme(axis.title.x=element_blank())+theme(axis.text.x = element_text(size = 10))+theme(axis.text.y = element_text(size = 10))+theme(axis.title.y = element_text(size = 15))+theme(axis.title.y = element_text(margin = margin(r = 25)))   
g1<-g1+facet_wrap(~df$Disease_Classifier)
g1

