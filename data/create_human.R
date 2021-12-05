
## Loading datasets (hd and gii), changing column names, creating new variables and joining the data. 

#Load package 
library(dplyr)


### read the data and create to datasets (hd and gii)
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)


gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# check the dimensions and structure of the data
dim(hd) #195 obs. of  8 variables
str(hd) 

dim(gii) #195 obs. of  10 variables
str(gii) 

#Print the column names 
colnames(hd) 
colnames(gii)

#Chang the column names 
colnames(hd)[3] <- "HDI" #"Human.Development.Index..HDI." 
colnames(hd)[4] <- "LEB" #"Life.Expectancy.at.Birth" 
colnames(hd)[5] <- "EYE" #"Expected.Years.of.Education"
colnames(hd)[6] <- "MYE" #"Mean.Years.of.Education"
colnames(hd)[7] <- "GNI" #"Gross.National.Income..GNI..per.Capita"
colnames(hd)[8] <- "GNI_HDI" #"GNI.per.Capita.Rank.Minus.HDI.Rank"

colnames(hd) #HDI.Rank,Country,HDI,LEB,EYE,MYE,GNI,GNI_HDI

colnames(gii)[3] <- "GII" #"Gender.Inequality.Index..GII." 
colnames(gii)[4] <- "MMR" #"Maternal.Mortality.Ratio" 
colnames(gii)[5] <- "ABR" #"Adolescent.Birth.Rate"  
colnames(gii)[6] <- "PRP" #"Percent.Representation.in.Parliament" 
colnames(gii)[7] <- "PSE_F" #"Population.with.Secondary.Education..Female."
colnames(gii)[8] <- "PSE_M" #"Population.with.Secondary.Education..Male."
colnames(gii)[9] <- "LFPR_F" #"Labour.Force.Participation.Rate..Female."
colnames(gii)[10] <- "LFPR_M" #"Labour.Force.Participation.Rate..Male."

colnames(gii) #GII.Rank,Country,GII,MMR,ABR,PRP,PSE_F,PSE_M,LFPR_F,LFPR_M


#Mutate the gii dataset and create two new variables 

# Create ratio of Female and Male populations with secondary education in each country 
gii <- mutate(gii, PSE_ratio = (PSE_F / PSE_M))

#Create ratio of labour force participation of females and males in each country 
gii <- mutate(gii, LFPR_ratio = (LFPR_F / LFPR_M))


#Join the data by 'Country'
hd_gii <- inner_join(hd, gii, by = "Country", suffix = c(".hd", ".gii"))


#Let us check that all the columns and dimensions exist
colnames(hd_gii)
dim(hd_gii)
str(hd_gii)
library(stringr)

# look at the structure of the GNI column in 'human'
str(hd_gii$GNI)


# read the human data
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)

# look at the (column) names of human
names(human)

# look at the structure of human
str(human)

# print out summaries of the variables
summary(human)

# access the stringr package
library(stringr)

# look at the structure of the GNI column in 'human'
str(human$GNI)

# remove the commas from GNI and print out a numeric version of it
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric



# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))



# look at the last 10 observations
tail(human, 10)

# last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human_ <- human[1:last, ]

# add countries as rownames
rownames(human) <- human$Country

# remove the Country variable
human_ <- select(human, -Country)

library(stringr)
library(dplyr)

#Reading the data
human = read.table(file="hd_gii.txt", sep=",", header=TRUE)

data.frame(human[-1], comp = complete.cases(human))

#Filtering out all rows with NA (missing) values
human_na <- filter(human, complete.cases(human) == TRUE)
human <- filter(human, complete.cases(human) == TRUE)
human$GNI <- as.numeric(human$GNI)
str(human)
