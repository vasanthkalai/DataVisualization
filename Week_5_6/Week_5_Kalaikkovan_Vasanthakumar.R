# Author: Kalaikkovan Vasanthakumar
# Date: 10-04-2021
# Exercise: 3.2

#importing libraries
library("ggplot2")
library("dplyr")
library("gapminder")
library("readxl")
library("tidyverse")
library("reshape2")
library("data.table")

install.packages("plotly")
library("plotly")

install.packages("treemap")
library("treemap")

#Reading csv file
setwd("C:/Users/vasan/DataVisualization/Week_5_6")
unemp_df<-read.csv("unemployement-rate-1948-2010.csv")
head(unemp_df)

#Reading txt file
exp_df<-read.table("expenditures.txt",sep='\t',header=TRUE)
head(exp_df)

#Tree Map
exp_agg_df<-aggregate(unemp_df$Value,by=list(Year=unemp_df$Year),FUN=sum)
group<-exp_agg_df$Year
value<-exp_agg_df$x
df<-data.frame(group,value)
treemap(df,index="group",vSize="value",type="index",title="Unemployment between 1984-2010",fontsize.title = 12)
dev.copy(png,"Tree_Map_R.png")
dev.off()

#Area Map
ggplot(df,aes(x=group,y=value))+geom_area(fill="green",alpha=0.4)+geom_line(color="red",size=2)+geom_point(size=3,color="green")+
  labs(x="Year",y="Dollars")+ggtitle("Expenditures by year")
dev.copy(png,"Area_Map_R.png")
dev.off()

#Stacked Area Chart
Values<-round(unemp_df$Value,0)
df1<-data.frame(Year=unemp_df$Year,Period=unemp_df$Period,Values=round(unemp_df$Value,0))
ggplot(df1,aes(x=Year,y=Values,fill=Period))+geom_area(colour="black",size=0.2,alpha=0.8)+ggtitle("Unemployment by Year")
dev.copy(png,"Stacked_Area_Map_R.png")
dev.off()
