
### Cost function for logistic regression...
cost<-function(y,yhat){
	return(-sum(y*log(yhat)+(1-y)*log(1-yhat))/length(y))
}

### Sigmoid function..
yValuePred<-function(theta0,theta1,x){
	thetaX=theta0+theta1*x
	yhat=(1/(1+exp(-thetaX)))
	return(yhat)
}

### Derivative for the intercept
theta0_derivative<- function(y,yhat){
	return(sum(yhat-y)*1/length(y))   ### 1 is the bias term
}

### Derivative for x variable
theta1_derivative<- function(y,yhat,x){
	return(sum((yhat-y)*x)/length(y))
}

### Initial parameters...
x=c(1:20)
y=sample(c(0,1),20,replace=T)
alpha=0.01
theta0=0
theta1=0
threshold=0.0001

for(i in 1:10000){
	yhat=yValuePred(theta0,theta1,x)
	l=cost(y,yhat)
	if(l<=threshold){
		print("STOPPED")
		print(theta0)
		print(theta1)
		break
	}
	theta0=theta0-(alpha*theta0_derivative(y,yhat))
	theta1=theta1-(alpha*theta1_derivative(y,yhat,x))
	if(i%%200==0){
		print(paste("Iteration:",i,sep=""))
		print(theta0)
		print(theta1)
	}
}