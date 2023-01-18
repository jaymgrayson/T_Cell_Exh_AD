# Pan, 5K sampled, UMAP and Phenograph analyses
# Jason M. Grayson
# Started 04-04-22

rm(list=ls())
library(tidyverse)
# Set working directory to where files are
load("~/Desktop/Code copy/Figure 1/Panel_A/UMAP_Annotated.RDa")

#Graph For Figure 1A
Pan_data4<-ggplot(UMAP_Annotated, aes(x=V1, y=V2, color=phenograph_cluster)) + geom_point(size=0.1)+facet_wrap(~UMAP_Annotated$Disease_Classifier)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+ ggtitle("Pan Immune Analysis") + theme(plot.title = element_text(hjust = 0.5))+ labs(colour = "Cell Type")

Pan_data4<-Pan_data4+xlab("UAMP 1")+ylab("UMAP 2")
Pan_data4
#Saved as a pdf and put into Canvas to make Figure
