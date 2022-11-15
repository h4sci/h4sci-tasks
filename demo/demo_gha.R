#!/usr/bin/env Rscript
library(data.table)
library(tsbox)
library(zoo)
library(OECD)
small <- get_dataset("STLABOUR", filter = list("CHE","LRHUTTTT"))

dt_l <- data.table(small)
tsdt <- dt_l[
  SUBJECT == "LRHUTTTT" & FREQUENCY == "Q",
  list(id = tolower(paste(LOCATION,SUBJECT,MEASURE,sep=".")),
       time = as.Date(as.yearqtr(gsub("-"," ",Time))),
       value = ObsValue)
]


fwrite(tsdt, file="data/unemployment_rate_ch.csv")

