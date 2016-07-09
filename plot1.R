create_plot1 <- function() {
  
  ##Download and unzip original data from the web, if it was not found in the working directory
  if (!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "dataset.zip")
    unzip(zipfile = "dataset.zip")
  }
  
  ##Read the file and subset
  library(data.table)
  dt <- fread("household_power_consumption.txt", na.strings="?")
  dt$Date <- as.Date(dt$Date, "%d/%m/%Y")
  dt <- dt[(dt$Date == "2007-02-01") | (dt$Date == "2007-02-02"), ]
  
  ##Create a DateTime columm
  dateTime <- paste(dt$Date, dt$Time)
  dt <- dt[ , (1:2):=NULL]
  dt <- cbind(as.POSIXct(dateTime), dt)
  colnames(dt)[1] <- "DateTime"
  
  ##Create and export the graph
  png(filename = "plot1.png", width = 480, height = 480)
  hist(dt$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
  dev.off()
}

