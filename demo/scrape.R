library(rvest)

url <- "https://kof.ethz.ch/en/news-and-events/media/media-agenda.html"

table_list <- url %>%
  read_html() %>%
  html_nodes(xpath = '//*[@id="contentMain"]/div[2]/div/div[2]/div/div/div/div/div/div/table') %>%
  html_table()

agenda_table <- table_list[[1]]

# extract KOF barometer lines
pub_date <- agenda_table[grep("KOF Economic Barometer",agenda_table$X3),]


# Extract single elements of a date to
# create proper POSIX dates.
d <- gsub("([0-9]{2})(.+)","\\1",pub_date$X1)
m <- gsub("([0-9]{2} )(.+)","\\2",pub_date$X1)
m <- match(m, month.name)

posix_dates <- as.POSIXct(
  paste(
    paste("2021",m,d,sep="-"),
    pub_date$X2
    )
  )


# automate updating a barometer graph.
library(kofdata)
library(rmarkdown)

# do I need to download the barometer ?

last_update <- as.POSIXct(readLines("examples/status"))

# position of the first publication date that is
# greater than the current last update
dp <- which(cumsum(last_update < posix_dates) == 1)

# run
if(posix_dates[dp] < Sys.time()){
  baro <- get_time_series("ch.kof.barometer")[[1]]
  render("demo/README.Rmd",
         md_document(variant = "gfm"))
  writeLines(as.character(Sys.time()),"status")
  message("KOF Barometer updated.")
} else {

  message("Nil novi sub sole.")

}





