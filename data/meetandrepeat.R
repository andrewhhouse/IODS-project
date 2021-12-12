#### Chapter 6 Data Wrangling 

## Load the RATS data into R 
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Look at the (column) names of BPRS
names(RATS)

# Factor variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#Check the structure of the wide data 
str(RATS)

View(RATS)

### Convert to long data
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

#Check the structure of the newly long converted data 
str(RATSL)

#View the file after long conversion 
View(RATSL)


#Load the BPRS data into R
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)


BPRS$ID <- factor(BPRS$treatment)
BPRS$Group <- factor(BPRS$subject)
# Look at the (column) names of BPRS
names(BPRS)



# Look at the structure of BPRS
str(BPRS)
View(BPRS)

# print out summaries of the variables
summary(BPRS)

### Convert to long data
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Check the names 
names(BPRSL)

#Check the structure
str(BPRSL)

#View the file after long conversion 
View(BPRSL)
