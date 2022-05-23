library(tidyverse)
library(openxlsx)
library(meta)
library(metafor)

setwd("C:/UW/RR/RRcourse2022/RR_May_19_25")
data <- read.xlsx("data/metaanalysis_data.xlsx")

data %>% 
  select(matches("Mean")) %>% 
  summarise(across(everything(), ~ mean(.)))

summary(data)

m.raw <- metacont(n.e=N_boys,
                  mean.e=Mean_boys_play_female,
                  sd.e=SD_boys_play_female,
                  n.c=N_girls,
                  mean.c=Mean_girls_play_male,
                  sd.c=SD_girls_play_male,
                  data=data,
                  studlab=paste(Study),
                  fixed = TRUE,
                  random = TRUE,
)

m.raw

m.raw %>% forest(sortvar=TE)

m.raw %>% metareg(`Country` + `Setting` + `Parent.present`)

m %>% funnel()

m %>% funnel(contour = c(.95,.975,.99),
             col.contour=c("darkblue","blue","lightblue")) +
  legend(1.4, 0, c("p < 0.05", "p<0.025", "< 0.01"),bty = "n",
         fill=c("darkblue","blue","lightblue"))
