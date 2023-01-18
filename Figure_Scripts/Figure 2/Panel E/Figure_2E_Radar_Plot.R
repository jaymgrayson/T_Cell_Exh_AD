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
setwd("~/Desktop/Code copy/Figure 2/Panel E")
load("~/Desktop/Code copy/Figure 2/Panel E/CD8_T_Surf_Data.RDa")

antigens<-colnames(df[,c(1:11)])
df2<-df%>%group_by(phenograph_cluster)%>%summarise_at(vars(antigens),list(name=mean))
clusters<-df2$phenograph_cluster
row.names(df2)<-clusters
df2<-df2[,-1]
CD8_Sur_radar<- df2%>%add_rownames( var = "group" ) %>%
                mutate_each(funs(rescale), -group) %>%
                select(1:12)%>%slice(7,16)
CD8_col_names<-c("group","HLA_DR","CD28","CD62L","CD69","CD38","CCR7","CD45RA","CD95","CD27","CD122","CD45RO")
colnames(CD8_Sur_radar)<-CD8_col_names
ggradar(CD8_Sur_radar,values.radar = "",legend.title = "",legend.text.size =12,plot.title = "",axis.label.size = 4,base.size = 6)+theme(legend.title = element_text(size=6)) 
