# We need a script to generate cluster variable levels
# Jason M. Grayson
# Started 08/15/22

rm(list=ls())
library(tidyverse)
library(ggradar)
suppressPackageStartupMessages(library(dplyr))
library(scales)
library(splitstackshape)
# Set working directory
setwd("~/Desktop/Critical Docs/Manuscripts/AD_PAPER/Code/Figure 4/Panel_C")

load("~/Desktop/Critical Docs/Manuscripts/AD_PAPER/Code/Figure 4/Panel_C/CD4_Radar_Plot_Data.RDA")
antigens<-colnames(df[,c(1:11)])
df2<-df%>%group_by(Phenograph_Cluster)%>%summarise_at(vars(antigens),list(name=mean))
clusters<-df2$Phenograph_Cluster
row.names(df2)<-clusters
df2<-df2[,-1]
CD4_ICS_radar<- df2%>%add_rownames( var = "group" ) %>%
                mutate_each(funs(rescale), -group) %>%
                select(1:12)%>%slice(1,6,12,13,22)
CD4_col_names<-c("group","Tox","GzB","IFNg","IL_2","T_Bet","Ki67","PD_1","CD45RA","TCF_1","TNFa","LAG_3")
colnames(CD4_ICS_radar)<-CD4_col_names
ggradar(CD4_ICS_radar,values.radar = "",legend.title = "",legend.text.size =12,plot.title = "",axis.label.size = 4,base.size = 6)+theme(legend.title = element_text(size=6)) 

