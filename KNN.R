setwd("C:\\Users\\ha294046\\Desktop\\Machine Learning from Scratch")
data=iris
library(caret)


### Data partitioning
index=createDataPartition(data$Species,p=0.70,list=F)
train=data[index,]
test=data[-index,]

### Euclidean distance 
distance <- function(ex1,ex2){
	sqrt(sum((ex1-ex2)^2))
}

### Calculating the distance between each test instance and all training instances and taking top K omitting the actual class for all values to be numeric...
Neighbours <- function(train,test,K,ind){
	predictions=vector()
	for(i in 1:nrow(test)){
		dist=data.frame(class=character(),distance=numeric())
		t1=as.numeric(test[i,-ind])
		for(j in 1:nrow(train)){
			t2=as.numeric(train[j,-ind])
			dis=distance(t1,t2)
			dist=rbind(dist,data.frame(class=train[j,ind],distance=dis))
		}
		dist=dist[order(dist$distance),]
		topK=dist[1:K,]
		predictions[i]=names(sort(-table(topK$class)))[1]	
	}
	return(predictions)
}

### Predicting and calculating accuracy..
pred=Neighbours(train,test,3,5)
confusionMatrix(test$Species,pred)
