# some standard map packages.
install.packages(c("maps", "mapdata"))

# the ggmap package.  Might as well get the bleeding edge version from GitHub
devtools::install_github("dkahle/ggmap")

library(tidyverse)
library(mapdata)
library(maps)
library(stringr)
library(viridisLite)


states <- map_data("state")

dim(states)

head(states)

#Create Colorado map

co_df <- states %>%
  filter(region == "colorado")

head(co_df)

#Add County Lines

counties <- map_data("county")
co_county <- counties %>%
  filter(region == "colorado")

head(co_county)

#Theme first plot

co_base <- ggplot(data = co_df, mapping = aes(x = long, y = lat, group = group)) + 
  coord_quickmap() + 
  geom_polygon(color = "black", fill = "gray")
co_base + theme_void()

#Plot counties in white
co_base1 <- 
co_base + theme_void() + 
  geom_polygon(data = co_county, fill = NA, color = "white") +
  geom_polygon(color = "black", fill = NA)  # get the state border back on top

co_base1

View(co_county)

CancerData1<- read.csv("CancerCountyDoctor1.csv", sep=",")
CancerData1 <- read.csv("CancerCountyDoctor1.csv", sep+",")

View(CancerData1)

CancerData2 <-  read.csv("CancerCountyDoctor2.csv", sep=",")

View(CancerData2)

CancerData3 <- read.csv("CancerCountyDoctor3.csv", sep=",")

CancerData4 <- read.csv("CancerCountyDoctor4.csv", sep = ",")

View(CancerData3)

head(CancerData3)
               

#Joining datasets

cococa <- left_join(co_county, CancerData1, by = "subregion")

cococa1 <- left_join(co_county, CancerData2, by = "subregion")

cococa2 <- left_join(co_county, CancerData3, by = "subregion")
                    
cococa3 <- left_join(co_county, CancerData4, by = "subregion")


head(cococa3)

#Plot of comparison of cancer

library(ggplot2)

by_cancer1 <- co_base1 +
geom_polygon(data = cococa, aes(fill = Age.Adjusted.Incidence.Rate...cases.per.100.000), color = "green") +
  geom_polygon(color = "green", fill = NA) +
  theme_dark()

by_cancer1 



by_cancer2 <- co_base1 +
  geom_polygon(data = cococa1, aes(fill = Age.Adjusted.Incidence.Rate...cases.per.100.000), color = "white") +
  geom_polygon(color = "black", fill = NA) +
  theme_void()

by_cancer2

by_cancer3 <- co_base1 +
  geom_polygon(data = cococa2, aes(fill = Adjusted.Incident.Rate), color = "white") +
  geom_polygon(color = "black", fill = NA) +
  theme_void()

by_cancer3

PCPRatio <- co_base1 +
  geom_polygon(data = cococa3, aes(fill = PCP.Ratio), color = "white") +
  geom_polygon(color = "black", fill = NA) +
  theme_void()

PCPRatio

by_doctor <- co_base1 +
  geom_polygon(data = cococa2, aes(fill = Number.Primary.Physicians), color = "white") +
  geom_polygon(color = "black", fill = NA) +
  theme_void()

by_doctor
by_cancer3

install.packages("tmap")
library(tmap)

tmap_arrange(by_doctor, by_cancer3)

by_doctor + labs(title="Number of Primary Physicians by County", subtitle="2017")
by_doctor + labs(caption="(based on data from https://data.hrsa.gov/data/download)")


FinalDoctor <- 
by_doctor + 
  theme_minimal() +
  ggtitle("Number of Primary Physicians by County - Colorado") +
  theme(axis.line = element_blank(), axis.text = element_blank(),
        axis.ticks = element_blank(), axis.title = element_blank()) +
        labs(caption="(based on data from https://data.hrsa.gov/data/download)") +
scale_fill_viridis_c(option = "plasma", direction =-1)


FinalAge <- 
by_cancer3 +
  theme_minimal() +
  ggtitle("Age-Adjusted Incidence Rate - cases per 100,000") +
  theme(axis.line = element_blank(), axis.text = element_blank(),
        axis.ticks = element_blank(), axis.title = element_blank()) +
  labs(caption="(based on data from https://www.statecancerprofiles.cancer.gov)") +
  scale_fill_viridis_c(option = "plasma", direction =-1)

FinalPCP <- 
  PCPRatio +
  theme_minimal() +
  ggtitle("Ratio of population to primary care physicians") +
  theme(axis.line = element_blank(), axis.text = element_blank(),
        axis.ticks = element_blank(), axis.title = element_blank()) +
  labs(caption="(based on data from http://www.countyhealthrankings.org)") +
  scale_fill_viridis_c(option = "plasma", direction =-1)

FinalPCP

library(gridExtra)

grid.arrange(FinalAge, FinalDoctor)

head(CancerData3)


CancerData3 <- read.csv("CancerCountyDoctor3.csv", sep=",")

COtime <- read.csv("COUSACANCER.csv", sep=",")
view(COtime)


ObservedYear <- 
ggplot(data=COtime, aes(x=Year, y=Observed)) + geom_line() 


USAbyYear <- 
ggplot(data = COtime, aes(x=Year, y=Observed)) +
  geom_point(shape=1) +
  geom_smooth()


USAbyYear2 <- 
USAbyYear + labs(y = "Deaths per 100,000 resident population")

USAbyYear3 <- 
USAbyYear2 + labs(title = "Historical Trends (1975-2015)", subtitle = "Mortality - All Cancer Sites - USA")

USAbyYear3

#Historical Trends Colorado 1975-2015

CObyYear <- 
  ggplot(data = COtime, aes(x=Year, y=COObserved)) +
  geom_point(shape=1) +
  geom_smooth()

CObyYear2 <- 
  CObyYear + labs(y = "Deaths per 100,000 resident population", title = "Historical Trends (1975-2015)", subtitle = "Mortality - All Cancer Sites - Colorado")

CObyYear2

CombCOUSA = ggplot() +
  geom_line(data = COtime, aes(x = Year, y = Observed), color = "blue") +
  geom_line(data = COtime, aes(x = Year, y = COObserved), color = "red") +
  ylab('USA & Colorado') +
  labs(title = "Historical Trends (1975-2015)", subtitle = "Mortality - All Cancer Sites - USA and Colorado")

CombCOUSA


#Area Line Graph

d <- ggplot(data = COtime, aes(x = Year, y = Observed))
d
d2 <- d + geom_ribbon(aes(ymax = Observed, ymin(pv$Observed), alpha = 0.4, fill = "turquoise")
d2

d3 <- d + geom_line(color = "blue")
d3                    

qplot(Year, Observed, data = COtime, colour = Observed)

qplot(Year, COObserved, data = COtime, colour = COObserved)

view(CancerData4)

p <- 
ggplot(data = CancerData4)+geom_bar(aes(x=Adjusted.Incident.Rate)
                                    
COinc <- geom_point(data = CancerData4, mapping = aes(x = subregion, y = Adjusted.Incident.Rate))
COinc                               
                                    