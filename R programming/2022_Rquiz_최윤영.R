library(ggpubr)
library(ggplot2)
library(dplyr)
install.packages("vctrs")
library(tidyr)
library(magrittr)
library(gridExtra)
library(tidyverse)
library(broom)
library(AICcmodavg)

View(mpg)
hwy_mean<-mpg %>% filter(manufacturer=='chevrolet'|manufacturer=='ford'|manufacturer=='honda')
View(hwy_mean)
hwy_mean %>% group_by(manufacturer) %>% summarise(mean_hwy=mean(hwy))
mpg<-mpg%>%mutate(mean_ch=(cty+hwy)/2)
View(mpg)

View(midwest)
ggplot(data=midwest,aes(x=poptotal,y=popasian))+geom_point()

DF<-data.frame(fl=c('c','d','e','p','r'),
               fuel_kind=c('CNG','disel','ethanol E85','premiun','regular'),
               price_fl=c(2.35,2.38,2.11,2.76,2.22))
View(DF)
pmpg<-merge(mpg,DF,by='fl')
View(pmpg)
