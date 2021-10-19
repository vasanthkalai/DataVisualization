#Author: Kalaikkovan Vasanthakumar
#Date:   10-18-2021
#Exercise 4.2

library("ggplot2")
library("dplyr")
library("gapminder")
library("readxl")
library("tidyverse")
library("reshape2")
library("data.table")
library("plotly")
library("treemap")

#import df
setwd("C:/Users/vasan/DataVisualization/Week_7_8")
df<-read.csv("crimerates-by-state-2005.csv")
head(df)

#Scatter Plot
ggplot(df,aes(x=state,y=motor_vehicle_theft))+geom_point()+
  ggtitle("Motor Vehicle Theft rate vs State")+
  theme(axis.text.x = element_text(angle=90))

#Buuble Plot
ggplot(df,aes(x=state,y=motor_vehicle_theft,size=motor_vehicle_theft))+geom_point()+
  ggtitle("Motor Vehicle Theft rate vs State")+
  theme(axis.text.x = element_text(angle=90))

#denisty plot
ggplot(df,aes(x=motor_vehicle_theft))+
  geom_histogram(aes(y=..density..),bins=30,color="black",fill="white")+geom_density()+ggtitle("Density Pot")
