hhold <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Formatting date type
hhold$Date <- as.Date(hhold$Date, "%d/%m/%Y")
  
## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
hhold <- subset(hhold,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
## Incomplete observation to be removed
hhold <- hhold[complete.cases(hhold),]

## Creating timestamp
dateTime <- paste(hhold$Date, hhold$Time)
  
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
  
## Removing Date and Time column
hhold <- hhold[ ,!(names(hhold) %in% c("Date","Time"))]
  
## Adding DateTime column
hhold <- cbind(dateTime, hhold)
  
## Formatting dateTime Column
hhold$dateTime <- as.POSIXct(dateTime)

##PLOT 3

 with(hhold, {
    plot(Sub_metering_1~dateTime, type="l",
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~dateTime,col='Red')
    lines(Sub_metering_3~dateTime,col='Blue')
  })
  legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## Creating file
  dev.copy(png,"plot3.png", width=480, height=480)
  dev.off()