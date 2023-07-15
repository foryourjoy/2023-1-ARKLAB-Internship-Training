library('ggsignif')
library(dplyr)
cancer <- read.csv(file="C:/Users/Yunyoung/Documents/R/R_practice/cancer.csv", header=T)
head(cancer)
View(cancer)

head(cancer_B)

#radius_mean
ggplot(cancer,aes(diagnosis, radius_mean,color=diagnosis))+geom_boxplot()+ 
geom_signif(comparisons = list(c("M","B")), map_signif_level = FALSE)

#texture_mean
ggplot(cancer,aes(diagnosis, texture_mean,color=diagnosis))+geom_boxplot()+ 
geom_signif(comparisons = list(c("M","B")), map_signif_level = FALSE)

wilcox.test(texture_mean ~ diagnosis, data = cancer)

#perimeter_mean
ggplot(cancer,aes(diagnosis, perimeter_mean,color=diagnosis))+geom_boxplot()+ 
geom_signif(comparisons = list(c("M","B")), map_signif_level = FALSE)

wilcox.test(perimeter_mean ~ diagnosis, data = cancer)

#area_mean
ggplot(cancer,aes(diagnosis, area_mean,color=diagnosis))+geom_boxplot()+ 
geom_signif(comparisons = list(c("M","B")), map_signif_level = FALSE)

wilcox.test(area_mean ~ diagnosis, data = cancer)

#smoothness_mean
ggplot(cancer,aes(diagnosis, smoothness_mean,color=diagnosis))+geom_boxplot()+ 
geom_signif(comparisons = list(c("M","B")), map_signif_level = FALSE)

wilcox.test(smoothness_mean ~ diagnosis, data = cancer)

#compactness_mean
ggplot(cancer,aes(diagnosis, compactness_mean,color=diagnosis))+geom_boxplot()+ 
geom_signif(comparisons = list(c("M","B")), map_signif_level = FALSE)

wilcox.test(compactness_mean ~ diagnosis, data = cancer)

#concavity_mean
ggplot(cancer,aes(diagnosis, concavity_mean,color=diagnosis))+geom_boxplot()+ 
geom_signif(comparisons = list(c("M","B")), map_signif_level = FALSE)

wilcox.test(concavity_mean ~ diagnosis, data = cancer)

#concave.points_mean
ggplot(cancer,aes(diagnosis, concave.points_mean,color=diagnosis))+geom_boxplot()+ 
  geom_signif(comparisons = list(c("M","B")), map_signif_level = FALSE)

wilcox.test(concave.points_mean ~ diagnosis, data = cancer)

#symmetry_mean
ggplot(cancer,aes(diagnosis, symmetry_mean,color=diagnosis))+geom_boxplot()+ 
  geom_signif(comparisons = list(c("M","B")), map_signif_level = FALSE)

wilcox.test(symmetry_mean ~ diagnosis, data = cancer)

#fractal_dimension_mean
ggplot(cancer,aes(diagnosis, fractal_dimension_mean,color=diagnosis))+geom_boxplot()+ 
  geom_signif(comparisons = list(c("M","B")), map_signif_level = FALSE)

wilcox.test(fractal_dimension_mean ~ diagnosis, data = cancer)

#평균 증가 비율
radius <- cancer %>%group_by(diagnosis) %>% summarise(mean=mean(radius_mean))
radius %>% summarise(dmean=diff(mean), mmedian=median(mean), ratio=dmean/mmedian)

texture <- cancer %>%group_by(diagnosis) %>% summarise(mean=mean(texture_mean))
texture %>% summarise(dmean=diff(mean), mmedian=median(mean), ratio=dmean/mmedian)

perimeter <- cancer %>%group_by(diagnosis) %>% summarise(mean=mean(perimeter_mean))
perimeter %>% summarise(dmean=diff(mean), mmedian=median(mean), ratio=dmean/mmedian)

area <- cancer %>%group_by(diagnosis) %>% summarise(mean=mean(area_mean))
area %>% summarise(dmean=diff(mean), mmedian=median(mean), ratio=dmean/mmedian)

smoothness <- cancer %>%group_by(diagnosis) %>% summarise(mean=mean(smoothness_mean))
smoothness %>% summarise(dmean=diff(mean), mmedian=median(mean), ratio=dmean/mmedian)

compactness <- cancer %>%group_by(diagnosis) %>% summarise(mean=mean(compactness_mean))
compactness %>% summarise(dmean=diff(mean), mmedian=median(mean), ratio=dmean/mmedian)

concavity <- cancer %>%group_by(diagnosis) %>% summarise(mean=mean(concavity_mean))
concavity %>% summarise(dmean=diff(mean), mmedian=median(mean), ratio=dmean/mmedian)

concave.points <- cancer %>%group_by(diagnosis) %>% summarise(mean=mean(concave.points_mean))
concave.points %>% summarise(dmean=diff(mean), mmedian=median(mean), ratio=dmean/mmedian)

symmetry <- cancer %>%group_by(diagnosis) %>% summarise(mean=mean(symmetry_mean))
symmetry %>% summarise(dmean=diff(mean), mmedian=median(mean), ratio=dmean/mmedian)
