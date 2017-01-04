
### Defining the loss function to be the MSE(Mean Squared error).We need to minimise this function
loss<-function(y,yhat){
	return(sum((yhat-y)^2)/length(y))
}

### Derivative for intercept...
theta0_derivative<- function(y,yhat){
	return(sum(yhat-y)/length(y))
}

### Derivative for x variable
theta1_derivative<- function(y,yhat,x){
	return(sum((yhat-y)*x)/length(y))
}

### Function to calculate the yhat
yValuePred<- function(theta0,theta1,x){
	return((theta0+theta1*x))
}

x=c(1:10)
y=2+5*x

### Initial parameter setting...
alpha=0.01
theta0=0
theta1=0
threshold=0.0001

### Iterate until convergence...
for(i in 1:10000){
	yhat=yValuePred(theta0,theta1,x)
	l=loss(y,yhat)
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
