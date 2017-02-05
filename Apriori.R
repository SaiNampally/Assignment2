rm(list=ls(all=TRUE))
setwd("C:/Users/Raghu/Documents")
data = read.transactions("Data.csv")
a <- as.data.frame(t(data))
write.csv(data,file="Rdata.csv",sep = ',')
data <- read.transactions(data)
data$ProductID <- NULL
data$ProductNumber <- NULL
data$X <- NULL
data$ReorderPoint <- NULL
data$SizeUnitMeasureCode <- NULL
data$WeightUnitMeasureCode <- NULL
data$ProductCategoryID <- NULL
data$ProductSubcategoryID <- NULL
data$ProductModelID <- NULL
library(arules)
library(arulesViz)
str(data)
data$MakeFlag <- as.factor(data$MakeFlag)
data$FinishedGoodsFlag <- as.factor(data$FinishedGoodsFlag)
data$SafetyStockLevel <- as.factor(data$SafetyStockLevel)
data$StandardCost <- as.factor(data$StandardCost)
data$ListPrice <- as.factor(data$ListPrice)
data$Size <- as.factor(data$Size)
data$Weight <- as.factor(data$Weight)
data$DaysToManufacture <- as.factor(data$DaysToManufacture)
data$TotalUnitPrice <- as.factor(data$TotalUnitPrice)
data$TotalUnitPriceDiscount <- as.factor(data$TotalUnitPriceDiscount)
b <- as.data.frame(t(data),row.names = F)
names(b) <- as.character(a[1,])

data <- b[-1,]
rules <- apriori(data, parameter = list(sup = 0.01, conf = 0.01, target="rules"))
rules<-sort(rules, decreasing=F,by="confidence")
inspect(rules)
summary(rules)
inspect(head(sort(rules), n=100))
rules.sub.product <- subset(rules, subset = lhs %pin% "120105,4710000000000")
