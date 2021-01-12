###############################################################################
# This code shows how to download data from World Bank Open Data - DataBank
# (https://databank.worldbank.org/home.aspx), especially from World Development
# Indicators (WDI). After collecting the data, it showed two basic examples of 
# what you can do: basic statistical measurements and data visualization.
###############################################################################


# Libraries ---------------------------------------------------------------
library("tidyverse")
library("WDI")

# Collection and manipulating the data (See NOTE N°2) ---------------------
data <- WDI(indicator = c('NY.GDP.MKTP.KD.ZG','NY.GDP.PCAP.KD.ZG'),
            country = c("USA","WLD","HIC"), start = 1960, end = 2019) %>%
  select(year, country, "NY.GDP.MKTP.KD.ZG","NY.GDP.PCAP.KD.ZG")

colnames(data) <- c("year","country","GDP","GDPpc")


# Some descriptive statistics (mean and standard deviation) ---------------
print(data %>%
        group_by(country) %>%
        dplyr::summarise(m = mean(GDP, na.rm = TRUE),
                         sd = sd(GDP, na.rm = TRUE)))

print(data %>% 
        group_by(country) %>% 
        dplyr::summarise(m = mean(GDPpc, na.rm = TRUE),
                         sd = sd(GDPpc, na.rm = TRUE)))


# Plots (run 2_plots.R) ---------------------------------------------------
p1

p2


# Export the plots and the data -------------------------------------------
pdf(file = "../Plots/GDP.pdf")
p1
dev.off()

pdf(file = "../Plots/GDPpc.pdf")
p2
dev.off()

write.csv(data, file = "../Outputs/data.csv")


##############################################################################
# NOTE N°1: Packages information:
#       -> tidyverse - https://www.tidyverse.org/
#       -> WDI - https://cran.r-project.org/web/packages/WDI/WDI.pdf
#
# NOTE N°2: 
#          Occasionally, the World Bank API has sporadic issues that affect 
#          others libraries which use the connection with this organization. 
#          However, the problems are solved. More information about it in the 
#          next links:
#
#          https://github.com/vincentarelbundock/WDI/issues/35
#          https://github.com/nset-ornl/wbstats/issues/23
##############################################################################
