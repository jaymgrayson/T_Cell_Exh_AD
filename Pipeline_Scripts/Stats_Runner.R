# Script to combine all manual data
# Jason M. Grayson
# Started 12-06-21
rm(list=ls())
library(tidyverse)
setwd("~your working directory")
load("your_Data.RDa")

#Here use manual gated or phenograph cluster percentages
df_for_stats<-df[,c(2:30)]
# Determine which variables are normally distributed use appropriate methods
normality_test<-lapply(df_for_stats,shapiro.test)
pvalues<-rep(0,29)
for (i in seq_along(normality_test)){
    pvalues[i]<-normality_test[[i]][[2]]
    
}
variables<-colnames(df_for_stats)
normality_test_results<-cbind(variables,pvalues)
normality_test_results<-as.data.frame(normality_test_results)
normality_test_results$pvalues<-as.numeric(normality_test_results$pvalues)
normally_distributed_variables<-filter(normality_test_results,pvalues>.05)
non_normally_distributed_variables<-filter(normality_test_results,pvalues<=.05)
# Grab labels
Labels<-df[,c(1,33,34)]
Normal_Pull<-normally_distributed_variables$variables
Abnormal_Pull<-non_normally_distributed_variables$variables
Normal_numbers<-df[,c(Normal_Pull)]
Abnormal_numbers<-df[,c(Abnormal_Pull)]
Normal_data<-cbind(Labels,Normal_numbers)
Abnormal_data<-cbind(Labels,Abnormal_numbers)
setwd("~Your directory")
save(Normal_data,file="Normal_data.RDa")
save(Abnormal_data,file="Abnormal_data.RDa")

rm(list=ls())

data_TBA<-Abnormal_data[,-c(1,3)]
data_TBA$Cognitive_Status<-as.factor(data_TBA$Cognitive_Status)
data_TBA<-filter(data_TBA,Cognitive_Status!="Other")
result_holder<-lapply(data_TBA[,c(2:28)],function(x)wilcox.test(x~data_TBA$Cognitive_Status))
pvalues<-rep(0,length(result_holder))
for (i in seq_along(result_holder)){
    pvalues[i]<-result_holder[[i]][[3]]
    
}
variables<-colnames(data_TBA)
variables<-variables[-1]
Abnormal_by_CS<-cbind(variables,pvalues)
Abnormal_by_CS<-as.data.frame(Abnormal_by_CS)
Abnormal_by_CS$pvalues<-as.numeric(Abnormal_by_CS$pvalues)
Abnormal_by_CS<-Abnormal_by_CS[order(pvalues),]
save(Abnormal_by_CS,file="Abnormal_by_CS.RDa")


data_TBA<-Abnormal_data[,-c(1,2)]
data_TBA$Disease_Classifier<-as.factor(data_TBA$Disease_Classifier)
result_holder<-lapply(data_TBA[,c(2:28)],function(x)kruskal.test(x~data_TBA$Disease_Classifier))
pvalues<-rep(0,length(result_holder))
for (i in seq_along(result_holder)){
    pvalues[i]<-result_holder[[i]][[3]]
    
}
variables<-colnames(data_TBA)
variables<-variables[-1]
Abnormal_by_DC<-cbind(variables,pvalues)
Abnormal_by_DC<-as.data.frame(Abnormal_by_DC)
Abnormal_by_DC$pvalues<-as.numeric(Abnormal_by_DC$pvalues)
Abnormal_by_DC<-Abnormal_by_DC[order(pvalues),]
save(Abnormal_by_DC,file="Abnormal_by_DC.RDa")
rm(list=ls())

load("~/Desktop/AD Machine Learning/Comprehensive_Analysis/Population_Quantitation/Pecentages/Automated_Guided/Pan/Normal_data.RDa")
data_TBA<-Normal_data[,-c(1,3)]
data_TBA$Cognitive_Status<-as.factor(data_TBA$Cognitive_Status)
data_TBA<-filter(data_TBA,Cognitive_Status!="Other")
result_holder<-lapply(data_TBA[,c(2:3)],function(x)wilcox.test(x~data_TBA$Cognitive_Status))
pvalues<-rep(0,length(result_holder))
for (i in seq_along(result_holder)){
    pvalues[i]<-result_holder[[i]][[3]]
    
}
variables<-colnames(data_TBA)
variables<-variables[-1]
Normal_by_CS<-cbind(variables,pvalues)
Normal_by_CS<-as.data.frame(Normal_by_CS)
Normal_by_CS$pvalues<-as.numeric(Normal_by_CS$pvalues)
Normal_by_CS<-Normal_by_CS[order(pvalues),]
save(Normal_by_CS,file="Normal_by_CS.RDa")


data_TBA<-Normal_data[,-c(1:2)]
data_TBA$Disease_Classifier<-as.factor(data_TBA$Disease_Classifier)
result_holder<-lapply(data_TBA[,c(2:3)],function(x)kruskal.test(x~data_TBA$Disease_Classifier))
pvalues<-rep(0,length(result_holder))
for (i in seq_along(result_holder)){
    pvalues[i]<-result_holder[[i]][[3]]
    
}
variables<-colnames(data_TBA)
variables<-variables[-1]
Normal_by_DC<-cbind(variables,pvalues)
Normal_by_DC<-as.data.frame(Normal_by_DC)
Normal_by_DC$pvalues<-as.numeric(Normal_by_DC$pvalues)
Normal_by_DC<-Normal_by_DC[order(pvalues),]
save(Normal_by_DC,file="Normal_by_DC.RDa")
rm(list=ls())

