#In class assignment: 09/24/2018, Name: Laura R Cortes

#set working directory if needed [i did not] 
setwd("C:/Users/Bio-user/Desktop")

#load the library GEOquery, limma, and affy

library(affy)

# use the following FTP link to download sample microarray data from GEO database using the function getGEO and assign the data to object named gse

url <- "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE1nnn/GSE1000/matrix/GSE1000_series_matrix.txt.gz"

filenm <- "GSE1000_series_matrix.txt.gz" 

if(!file.exists(filenm)) download.file(url, destfile=filenm)

gse <- getGEO(filename=filenm)

#check what you have in the gse object 

#object can be a class data frame, or a matrix, or a list, or a vector. 

#to check type of object 
class(gse)

head(gse)
#this just tells you about the object 

#to see expression levels of object 
head(exprs(gse))

#make two objects called treatment and control and put first 5 columns of gse in treatment and next five columns in control 

treatment <- exprs(gse[,c("GSM15785", "GSM15786", "GSM15787", "GSM15788", "GSM15789")])
#you only want the expression levels of gse data set 
#comma before c because you need column info. 

treatment <- exprs(gse[,1:5]) #better way because you don't need the column labels and names

control <- exprs(gse[,6-10])
#you need the comma before six because you need columns not rows. 

#take row means of object treatment
rowMeans(treatment)
rowMeans(control)

#make objects
treatment_means <-rowMeans(treatment)
control_means <-rowMeans(control)

#calculate fold change
fold <- treatment_means/control_means

#use if else loop, if fold change is >2, put genes into a new object called up regulation. If fold change is < -2 put genes into a new object called down regulation

#up_regulation object needs to be made first
up_regulation = list()
down_regulation = list()

up_regulation <- fold[which(fold > 2)]
down_regulation <- fold[which(fold < -2)]


#write the object onto a file (.txt, .xls, .xlsx, .csv)

write.csv(fold, file="class_assignment_fold.csv", row.names=FALSE)
