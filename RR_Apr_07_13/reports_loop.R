library(rmarkdown)
setwd("C:/UW/RR/RRcourse2022/RR_Apr_07_13")

for(season_number in 1:8){
  rmarkdown::render("Assignment 3.Rmd", 
                    output_file = sprintf("GOT_reports/GoT_season%s_report.pdf", season_number),
                    params = list(season = season_number),
                    output_format = "pdf_document")
}

tinytex::install_tinytex()
