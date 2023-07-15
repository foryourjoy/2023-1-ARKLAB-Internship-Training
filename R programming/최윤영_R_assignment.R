View(mpg)

#1-1
mpg_lt4<-mpg %>% filter(displ<=4)
mpg_mt5<-mpg %>% filter(displ>=5)
View(mpg_lt4)
View(mpg_mt5)
mpg_lt4 %>% summarise(mean_hwy_lt4=mean(hwy))
mpg_mt5 %>% summarise(mean_hwy_mt5=mean(hwy))

#1-2
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mean_hwy=mean(hwy)) %>%
  arrange(desc(mean_hwy)) %>%
  head(3)

#2
ggplot(data=mpg,aes(x=cty,y=hwy))+geom_point()

#3(a-e)
MPRA_data<-read.csv(file="C:/Users/Yunyoung/Documents/R/R_practice/GRCh37_ALL.csv", header=TRUE)
View(MPRA_data)
MPRA_data <- MPRA_data %>% mutate(Ref_type=
                                  ifelse(MPRA_data$Ref=='G'|MPRA_data$Ref=='A','purine','pyrimidine'))
MPRA_data <- MPRA_data %>% mutate(Alt_type=
                                  ifelse(MPRA_data$Alt=='G'|MPRA_data$Alt=='A','purine',
                                  ifelse(MPRA_data$Alt=='C'|MPRA_data$Alt=='T','pyrimidine','deletion')))
MPRA_data <- MPRA_data %>% mutate(mutation_type=
                                  ifelse(MPRA_data$Ref_type==MPRA_data$Alt_type,'transition',
                                  ifelse(MPRA_data$Alt_type=='deletion', 'deletion','transversion')))

MPRA_data <- MPRA_data %>% mutate(effect=ifelse(MPRA_data$Value>=0,'increase','decrease')) 

#3(f)
mu_val_mean<-MPRA_data%>% group_by(mutation_type) %>% summarise(mean_value=mean(Value))
ggplot(data=mu_val_mean,aes(x=mutation_type,y=mean_value))+geom_col()

#3(g)
ggplot(data=MPRA_data, aes(effect))+geom_bar()

#4
F9_medical_data<-read.csv(file="C:/Users/Yunyoung/Documents/R/R_practice/F8, F9 database - F9.csv", header=TRUE)
View(F9_medical_data)

F9_data<-merge(F9_medical_data,MPRA_data,by=c("Position","Ref","Alt"))
View(F9_data)

H_val_mean<-F9_data%>% group_by(Severity) %>% summarise(H_mean_value=mean(Value))
ggplot(data=H_val_mean,aes(x=Severity,y=H_mean_value))+geom_col()
