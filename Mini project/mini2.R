#install.packages(c("tidyverse","xml2","readr","ggplot2"))
#install.packages('tidyverse')
library(tidyr)
#library('tidyverse')
#install.packages('xml2')
library('xml2')
library(dplyr)
library(stringr)
#install.packages("readr")
library("readr")
library(ggplot2)

##############################
#Rscript mini2.R "$select_file" "$value" "$tf_index" "$file" "$genotype"
#argument

#input folder 
#genotype
#value(Caf, Capf, CaF, CaFFGF)
#TF(as.numeric)

#passed arguments
args <- commandArgs(trailingOnly=T)
file=args[1]
value=args[2]
tf_index=as.numeric(args[3])
file_name=args[4]
gtype=args[5]
###############################

#call the split file
geno<-read_xml(file)

att_path<-xml_find_all(geno, xpath="//BindingSite")
index<-xml_attr(att_path,"index")
value_attr<-xml_attr(att_path,value)

#x-axis
nuclear_num<-c(8227:8284)
num<-strsplit(value_attr,',')
test_df<-data.frame(nuclear_num)

#character > num
num_index=as.numeric(index)

#number of total columns
final=length(num_index)

#set index
ind=num_index[1]

#test_df(nuclear_num, range of index > to calculate total sum)
for(i in num){
  test<-data.frame("nuclear_num"=nuclear_num,as.numeric(i))
  test_df <- inner_join(test_df,test,by="nuclear_num")
  ind=ind+1
  rm(test)
}

#specific column number of TF_index
col_num<-tf_index-(num_index[1])+1+1

#final_df(only for graph)-3 columns
final_col<-test_df[,col_num]
total_col<-rowSums(test_df[,2:final+1])
final_df<-data.frame(nuclear_num, final_col, total_col)

#for svg file name
tf=as.character(tf_index)

#set svg file name
final_name<- paste0(file_name, "_", gtype, "_", tf, ".svg")
svg(final_name)

#drawing graphs
ggplot(data=final_df)+ 
  geom_area(aes(nuclear_num,total_col))+ 
  geom_area(aes(nuclear_num,final_col,color='red',fill="red")) #total graph

#save svg
dev.off() 

