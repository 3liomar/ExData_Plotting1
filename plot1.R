setwd("D:/Documentos/Coursera/Exploratory data análisis/course3 project W1")

set<-read.table("household_power_consumption.txt",na.strings = "?",sep = ";",header = T,stringsAsFactors =F)

library(dplyr)
library(lubridate)
library(tidyr)

set <- set %>% mutate(Date1=paste(Date,Time))

Date.Time <- strptime(set$Date1,"%d/%m/%Y %H:%M:%S")

set <- cbind(Date.Time,set) 
rm(Date.Time)
set2 <- filter(set, Date.Time > strptime("2007-02-01 00:00:00","%Y-%m-%d %H:%M:%S") & Date.Time < strptime("2007-02-02 23:59:59","%Y-%m-%d %H:%M:%S"))

set3 <- set2 %>% gather("N_sub_metering","Sub_metering",Sub_metering_1:Sub_metering_3,factor_key=T)

#plot 1

png("plot1.png")
hist(set2$Global_active_power,col = "red",main = "",xlab = "")
title(main = "Global active power",xlab = "Global active power (kilowatts)")
dev.off()

