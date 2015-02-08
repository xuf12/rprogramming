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

# the data is ready. Now's let's make plot 1
plot1 <- with(days2, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red"))
dev.copy(png, file = "plot1.png")
dev.off()