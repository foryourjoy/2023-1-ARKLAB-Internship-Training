View(iris)
mt5<-iris %>% filter(Sepal.Length<=5) %>% 
  filter(Species=="setosa")
sort(mt5[,1],decreasing=TRUE)
View(mt5)

library(ggplot2)
View(mpg)
class_num<-mpg %>% group_by(class) %>% summarise(n=n())
class_df=data.frame(class_num)
drv<-mpg%>%group_by(class)%>%summarise(n=n(drv))
cbind(class_df,)
View(class_df)

ggplot(class_df,aes(class,n))+geom_col()+coord_flip()
ggplot(data=mpg)+
  geom_bar(mapping=aes(x=class, fill=drv))+coord_flip()

states<-read.table("states.txt",sep='/',header=T)
View(states)
new_state<-rbind(states,c("Korea","Seoul","9.9","6052"))
write.csv(new_state,"~/R/R_practice/new_state.csv", row.names = FALSE)
