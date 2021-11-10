#Author: Kalaikkovan Vasanthakumar
#Date:   11-09-2021
#Exercise 6.2

library("ggplot2")
library("dplyr")
library("gapminder")
library("readxl")
library("tidyverse")
library("reshape2")
library("data.table")
library("plotly")
library("treemap")
install.packages("wrapr")
library("wrapr")

setwd("C:/Users/vasan/DataVisualization/Week_11_12")

crime_df<-read_csv("crimeratesbystate-formatted.csv")
head(crime_df)

edu_df<-read_csv("education.csv")
head(edu_df)

#1. Histogram
hist(crime_df$motor_vehicle_theft,main="Motor Vehicle Thefts Counts by Amount",xlab="Thefts Amounts",
      ylab="Counts",
      col="darkmagenta",
      freq=TRUE)
dev.copy(png,"Histogram R.png")
dev.off()

#2. Box Plots
options(warn=-1)
crime <- subset(crime_df, select = -c(state))
boxplot(x=crime$burglary,data=crime,xlab="Frequency",ylab="Burglary",main="Box Plot")
dev.copy(png,"Box Plot R.png")
dev.off()


#3. Bullet Charts

eddf <- edu_df[,c("state","math")]
eddf <- eddf[!(eddf$state=='United States'),]
eddf$mean <- 400
eddf$target <- 800

install.packages("ggplot2")
library("ggplot2")

p <- ggplot(eddf, aes(math, state))
p <- ggplot(eddf, aes(state, math) )
p <- p + geom_col(fill="grey", width=0.5)
p <- p + geom_col(aes(state, mean), width=0.2)
p <- p + geom_point(aes(state, target), colour="red")
p <- p + geom_errorbar(aes(y = target,x = state, ymin = target,ymax
                           = target), width = .45)
p <- p + coord_flip()+ 
  theme(axis.text.x=element_text(angle=0, hjust=0, vjust= 0.1)) +
  theme(axis.text.y=element_text(hjust=0, vjust= 0.1)) +
  ggtitle("PSAT Math Scores By State") +
  xlab("Math Scores") + 
  ylab("States")
p
dev.copy(png,"Bullet Chart R.png")
dev.off()

#4. Line Chart
crime <- crime_df[,c("state","murder")]
crime <- crime[!(crime$state=='United States'),]
p<-ggplot(crime,aes(x=state,y=murder,group=1))+geom_line()+ggtitle("Line Chart") +
  xlab("Murder") + 
  ylab("State")+theme(axis.text.x = element_text(angle = 90))
p
dev.copy(png,"Line Chart R.png")
dev.off()

