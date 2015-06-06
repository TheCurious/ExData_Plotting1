plot3 <- function() {
# Read in the data from file
  
   fullPwrCnsmptnData <- read.delim("Project Data/household_power_consumption.txt", sep = ";")
   
# Pare down the data to two the to days of interest   

   dataForPeriodOfInterest <- fullPwrCnsmptnData[as.character(fullPwrCnsmptnData$Date) == "1/2/2007" |
                                                 as.character(fullPwrCnsmptnData$Date) == "2/2/2007", ]

# Convert the variable columns from Factor variable type to character & numeric types.  
# This also conversts the "?" into <NA>
  
   colNames <- names(fullPwrCnsmptnData)
   dtCols <- colNames[1:2]
   valCols <- colNames[3:9]
   dateTime <- dataForPeriodOfInterest[dtCols]
   values <- dataForPeriodOfInterest[valCols]
   dateTime[] <- lapply(dateTime, as.character)

   dateTime <- paste(dateTime$Date, dateTime$Time, sep = "")
   dateTime <- strptime(dateTime, "%d/%m/%Y %H:%M:%S")

   values[] <- lapply(values, as.character)
   values[] <- lapply(values, as.numeric)
   dataForPeriodOfInterest <- cbind(dateTime, values)
   
   dataForPeriodOfInterest <- dataForPeriodOfInterest[complete.cases(dataForPeriodOfInterest), ]
   
# Open a png file to plot the histogram.

   png("plot3.png", width = 480, height = 480, units = "px")
   plot(dateTime, dataForPeriodOfInterest$Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub meetering")
   lines(dateTime, dataForPeriodOfInterest$Sub_metering_2, col = "red", type = "l")
   lines(dateTime, dataForPeriodOfInterest$Sub_metering_3, col = "blue", type = "l")
   legend("topright", legend = colNames[7:9], col = c("black", "red", "blue"), lty = 1)
   dev.off()
}