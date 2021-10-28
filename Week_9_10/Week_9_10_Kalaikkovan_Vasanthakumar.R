#Author: Kalaikkovan Vasanthakumar
#Date:   10-27-2021
#Exercise 5.2

library(ggplot2)
library(dplyr)
library(gapminder)
library(readxl)
library(tidyverse)
library(reshape2)
library(data.table)
library(plotly)
library(treemap)
library(plyr)
library(reshape2)
library(leaflet)
library(htmlwidgets)
library(akima)
library(ggplot2)
library(tibble)

#read csv input
setwd("C:/Users/vasan/DataVisualization/Week_9_10")
nba_df<-read.csv("ppg2008.csv")
costco_df<-read.csv("costcos-geocoded.csv")

nba_df$Name<-with(nba_df,reorder(Name,PTS))

#Heat Maps
library(scales)
nba_df.m<-melt(nba_df)
nba_df.m<-ddply(nba_df.m, .(variable),transform,rescale=rescale(value))
base_size<-9
(p<-ggplot(nba_df.m,aes(variable,Name))+geom_tile(aes(fill=rescale),color='white')+scale_fill_gradient(low="white",high = "steelblue"))
p + theme_grey(base_size = base_size) + labs(x = "", y = "") + scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) + 
  theme(axis.text.x=element_text(angle=90, hjust=0, vjust= 0.1)) +
  theme(axis.text.y=element_text(hjust=0, vjust= 0.1)) +
  ggtitle("2008 Basketball Player Statistics") +
  xlab("Statistic") + 
  ylab("Basketball Player")
dev.copy(png,"./Heatmap Plot R.png")
dev.off()

# Spatial Charts
costco_df$faddr<-paste(costco_df$Address,costco_df$City,costco_df$State,costco_df$Zip.Code)
m<-leaflet()
m<-addTiles(m)
m<-addMarkers(m,lng=costco_df$Longitude,lat=costco_df$Latitude,popup = costco_df$faddr)
m
saveWidget(m,file="C:/Users/vasan/DataVisualization/Week_9_10/Spatial_Map.html")

# Contour
interp_df<-interp2xyz(interp(x=nba_df$FGA,y=nba_df$PTS,z=nba_df$FGP,duplicate = "mean"),data.frame = TRUE)
print(interp_df)
interp_df  %>%
  filter(!is.na(z)) %>%
  tbl_df() %>%
  ggplot(aes(x = x, y = y, z = z, fill = z)) + 
  geom_tile() + 
  geom_contour(color = "white", alpha = 0.05) + 
  scale_fill_distiller(palette="Blues", na.value="white") + 
  theme_bw() +
  xlab("PTS") +
  ylab("FGA") +
  ggtitle("Basketball FGP Based on FGA and PTS Contour Plot") +
  guides(fill=guide_legend(title="FGP"))
dev.copy(png,"./Contour Plot.png")
dev.off()