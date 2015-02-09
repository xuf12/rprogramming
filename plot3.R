#read power using this one will avoid converting all variables to factor
power <-read.table(file = "household_power_consumption.txt", nrows= 2075259, sep = ";", header = TRUE, na.strings = c("?", "NA"))

#testpower <-read.table(file = "household_power_consumption.txt", nrows= 2075, sep = ";", header = TRUE, na.strings = c("?", "NA"))
#testpower2 <-read.table(file = "household_power_consumption.txt", nrows= 2075, sep = ";", header = TRUE, na.strings = "")
#remove NAs
power.nona <- power[complete.cases(power),]
#see only NAs, where can I find NAs?
power.na <- power[!complete.cases(power),]

#subset using the 2 dates 2007-02-01 and 02-02
days2 <- subset(power.nona, Date %in% c("1/2/2007", "2/2/2007"))
rm(power)
rm(power.nona)
#rm(days2)
#now look at the power dataframe
#str(days2)
#combining the Date and Time factor into one vector
Date_Time <- paste(as.Date(days2$Date, format = "%d/%m/%Y"), days2$Time)
#str(Date_Time)
#convert the class of Date_Time to POSIXlt
new <- strptime(Date_Time, format = "%Y-%m-%d %H:%M:%S")
#str(new) #Structure looks right!
#adding new as a new column Date_Time to power
days2$Date_Time <- new #adding the new variable to days2
days2 <- days2[,c(-1,-2)] # remove the original Date and Time variables


# 
# #the following script installs the package "lubricate" if it is not already installed in the system
# list.of.packages <- c('lubridate')
# new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
# new.packages
# if(length(new.packages)) install.packages(new.packages)
# library(lubridate)
# weekday <- wday(days2$Date_Time, label = TRUE)
# days2$Day <- weekday
# str(days2)
# #subset days2 with only values from Thurs Fri and Sat
# plot2days2 <- subset(days2, Day %in% c("Thurs", "Fri","Sat"))
# table(plot2days2$Day) #this shows the empty levels are still there
# plot2days2 <- droplevels(plot2days2) # drop the empty levels

plot2 <- plot(data = days2, Global_active_power ~ as.POSIXct(Date_Time), xlab = "", ylab = "Global Active Power (kilowatts)", pch = "l", lwd = 0.1)

dev.copy(png, file = "plot2.png")
dev.off()

