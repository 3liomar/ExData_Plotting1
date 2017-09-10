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

#plot 4

png("plot4.png")

par(mfrow=c(2,2),cex=0.8)

#4.1

plot(set2$Date.Time,set2$Global_active_power,type = "l", main = "", xlab = "",ylab = "")
title(ylab = "Global active power")  

#4.2

plot(set2$Date.Time,set2$Voltage,type = "l", main = "", xlab = "datetime",ylab = "")
title(ylab = "Voltage")

#4.3

with(set3,plot(Date.Time,Sub_metering,type = "n",ylab = "Energy sub metering",xlab = ""))

with(subset(set3,N_sub_metering=="Sub_metering_1"),lines(Date.Time,Sub_metering,col=1))

with(subset(set3,N_sub_metering=="Sub_metering_2"),lines(Date.Time,Sub_metering,col=2))

with(subset(set3,N_sub_metering=="Sub_metering_3"),lines(Date.Time,Sub_metering,col=4))

legend("topright",pch = "__",col = c("1","2","4"),legend = levels(set3$N_sub_metering))

#4.4

plot(set2$Date.Time,set2$Global_reactive_power,type = "l", main = "", xlab = "datetime",ylab = "Global reactive power")

dev.off()