directory <- setwd("set dir")

# Generate the folder "data"
if(!file.exists("./data")){dir.create("./data")}

# Extraxt files (in the "exdir") from the zip compression (from "zipfile").
unzip(zipfile="Course_Project_1.zip",exdir="./data")

# Upload of wd
path_rf <- file.path(directory, "data")
list.files(path_rf, recursive=TRUE)

# Open Data
EPC <- read.table(file.path(path_rf, "household_power_consumption.txt"),
                  sep=";",
                  header = FALSE,
                  stringsAsFactors=FALSE,
                  dec=".",
                  skip=1)

# Change names of variables
names(EPC) <- c("Date", "Time", "GAP", "GRP", "Voltage", "GI", "SM1", "SM2", "SM3")

# Changes Date and subsetting
library(dplyr)
EPC <- mutate(EPC, Date = as.Date(Date, "%d/%m/%Y"))
Final_EPC <- filter(EPC, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Date and Time
datetime <- paste(as.Date(Final_EPC$Date), Final_EPC$Time)
Final_EPC$Datetime <- as.POSIXct(datetime)

# Set variables as numeric
Final_EPC$GAP <- as.numeric(Final_EPC$GAP, dec=".")
Final_EPC$SM1 <- as.numeric(Final_EPC$SM1)
Final_EPC$SM2 <- as.numeric(Final_EPC$SM2)
Final_EPC$SM3 <- as.numeric(Final_EPC$SM3)
Final_EPC$Voltage <- as.numeric(Final_EPC$Voltage)
Final_EPC$GRP <- as.numeric(Final_EPC$GRP)

#########
# Plot 1:

Global_Activity_Power <- as.numeric(Final_EPC$GAP, dec=".")

png("Project1_plot1.png", width=480, height=480, bg = "transparent")
hist(Global_Activity_Power, col="red",
     main = "Global Activity Power",
     xlab = "Global Activity Power (kilowatts)",
     br=)
dev.off()
