# Script to generate Boxplots for Figure 1B-L
# Jason M Grayson
# Started 04-04-22


rm(list=ls())
library(tidyverse)
#set your wd and load datafile
load("~/Desktop/Code copy/Figure 1/Panels_B_L/PBMC_Manual_Data.RDa")

# Adjust and plot for each population that was statistically significant
#For CSF (Figure 1L) Load CSF data
Pop_Of_Interest<-ggplot(df2, aes(x=df2$Disease_Classifier, y=df2$`Myeloid Dendritic Cells`)) +theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+ ggtitle("Pan Immune Analysis") + theme(plot.title = element_text(hjust = 0.5))+geom_boxplot()
Pop_Of_Interest
#Plot saved as a pdf and inputted to Canvas to make Figure
