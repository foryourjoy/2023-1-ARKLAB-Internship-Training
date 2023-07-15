library(magrittr)
cancer1 <- read.csv(file="C:/Users/Yunyoung/Documents/R/R_practice/cancer.csv", header=T)%>% 
  filter(diagnosis=="M")
cancer2 <- cancer1[,c(3:12)]
head(cancer2)
View(cancer2)
cor(cancer2)
plot(cancer2)
