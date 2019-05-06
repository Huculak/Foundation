#Assignment 2, Exploratory Data Analysis
library(tidyverse)
data(package = "dplyr")
library(readxl)
breweries <- read_excel(Brewery.xls)
getwd()

install.packages("readxl")
library("readxl")

brewery <- read.csv("BreweryData.csv", sep=",")

View(breweries)
library(dplyr)
library(ggplot2)
library(reshape2)



brewery <-as_tibble(brewery)
View(brewery)

brewery[brewery=="*"]<- 0
breweries[brewery==""] <- 0
breweries[brewery=="NA"] <- 0

colnames(brewery)[1] <- "location"

dev.off()

brewery <- melt(brewery, id.vars="X2017")

X2016plot <- ggplot(data = brewery) +
  geom_point(mapping = aes(x = location, y = X2016))

X2016plot + ylim(0,1000)

install.packages("hexbin")
ggplot(data = brewery) +
  geom_point(mapping = aes(x = location, y = X2016))

plot.ts(brewyear)

brewyear=subset(brewery,select=-c(X1985,X1990,X1995,X1984,X1996,X1997,X1998,X1991,X1992,X1993,X1994,X1989,X1986,X1987,X1988,X1999,X2001,X2002,X2003,X2004,X2006,X2007,X2008,X2009,X2011,X2012,X2013,X2014,X2015,X2016))

View(brewyear)


brewbar <- ggplot(brewyear) + 
  geom_bar(mapping = aes(x = X1985:X2017))

brewbar + ylim(0,10)

ggplot(data = brewyear, mapping = aes(x = location, y = X2017)) +
  geom_boxplot()

brewyear %>% 
  count(location, X2017) %>%  
  ggplot(mapping = aes(x = location, y = X2017)) +
  geom_tile(mapping = aes(fill = n))

View(brewyear)

brewyear <- brewyear[-c(52), ]
View(brewyear)

state.name[grep("NY", state.abb)]

X2017plot <- ggplot(data = brewyear) +
  geom_point(mapping = aes(x = location, y = X2017))
X2017plot

#Exploratory Data
summary(brewyear$X2017)
fivenum(brewyear)
boxplot(brewyear)

str(brewyear) 

#Find States with most breweries
topstate <- brewyear[order(as.integer(brewery$X2017),decreasing = TRUE),]
View(topstate)

topstate <- topstate[-c(1), ]
View(topstate)

library(dplyr)
#Filter for the top states by number of breweries

filter(brewyear, X2017 > 420)

topfive <- topstate[1:5,]
View(topfive)

topfive$location[topfive$location == "Ca"] <- "california"

#changed location column from function to character
topfive$location <- as.character(topfive$location)
            
View(topfive)
summary(topfive)

#Changing State characters to name for mapping plot

topfive$location = toupper(topfive$location)
View(topfive)

state.name[match(topfive$location,state.abb)]
abbr2state(topfive$location)

windows(width = 8, height = 8)

ggplot(data = topfive) +
  geom_point(mapping = aes(x = location, y = X2017))

topfive[1, "location"] <- "california"
topfive[2, "location"] <- "washington"
topfive[3, "location"] <- "new york"
topfive[4, "location"] <- "michigan"
topfive[5, "location"] <- "colorado"


#Map

library(ggplot2)
library(maps)

states <- map_data("state")
View(states)
map.df <- merge(states,topfive2, by="region", all.x=T)

library(dplyr)
topfive2$region <- topfive2$states
View(topfive)

topfive2 <- rename(topfive2, c("location"="region"))
View(topfive2)

states <- map_data("")
map.df <- map.df[order(map.df$order),]

distmap <- ggplot(map.df, aes(x=long,y=lat,group=group))+
  geom_polygon(aes(fill=X2017))+
  geom_path()+ 
  scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90")+
  coord_map()

View(map.df)
library(ggplot2)
window

distmap + ggtitle("Number of Breweries by State - 2017") +
  theme(plot.title = element_text(lineheight=.8, face="bold"))
windows(width = 8, height = 8)

