
### Gini index calculation

def gini_calc(groups,classes):
	gini=0
	for catgry in classes:
		for grp in groups:
			size=len(grp)
			if size==0:
				continue
			prop=[row[-1] for row in grp].count(catgry)/float(size)
			gini+=prop*(1-prop)
	return gini

print gini_calc([[[0,0],[0,1]],[[1,1],[1,1]]],[0,1])

### Split a dataset
def data_split(ind,val,data):
	left,right=list(),list()
	for row in data:
		if row[ind]<val:
			left.append(row)
		else:
			right.append(row)
	return left,right


### Getting a best split point
def get_best_split(data,ind):
	classes=list(set([row[ind] for row in data]))
	b_index,b_val,b_score,b_grps=999,999,999,None
	for index in range(len(data[0])-1):
		for row in data:
			grps=data_split(index,row[index],data)
			gini=gini_calc(grps,classes)
			print("X%d < %.3f : gini %.3f"%((index+1),row[index],gini))
			if gini<b_score:
				b_score=gini
				b_index=index
				b_val=row[index]
				b_grps=grps
	return {"index":b_index,"Val":b_val,"grps":grps}


data = [[2.771244718,1.784783929,0],
	[1.728571309,1.169761413,0],
	[3.678319846,2.81281357,0],
	[3.961043357,2.61995032,0],
	[2.999208922,2.209014212,0],
	[7.497545867,3.162953546,1],
	[9.00220326,3.339047188,1],
	[7.444542326,0.476683375,1],
	[10.12493903,3.234550982,1],
	[6.642287351,3.319983761,1]]

print(data[0])
print(get_best_split(data,2))

### Terminal node with prediction
def to_terminal(grp):
	outcomes=[row[-1] for row in grp]
	return max(set(outcomes),key=outcomes.count)

### A recursive function to split a node or make it a terminal
def split(node,max_depth,min_size,depth):
	left,right=node['grps']
	if not left or not right:
		node['left']=node['right']=to_terminal(left+right)
		return
	if depth>=max_depth:
		node['left'],node['right']=to_terminal(left),to_terminal(right)
		return
	if len(left)<=min_size:
		node['left']=to_terminal(left)
	else:
		node['left']=get_best_split(left,2)
		split(node['left'],max_depth,min_size,depth+1)
	if len(right)<=min_size:
		node['right']=to_terminal(right)
	else:
		node['right']=get_best_split(right,2)
		split(node['right'],max_depth,min_size,depth+1)


def build_tree(train,max_depth,min_size):
	root=get_best_split(train,2)
	split(root,max_depth,min_size,1)
	return root

tree=build_tree(data,2,2)
print(tree)

### Make predictions
def predict(node,row):
	if row[node['index']]<node['value']:
		if isinstance(node['left'],dict):
			return predict(node['left'],row)
		else:
			return node['left']
	else:
		if isinstance(node['right'],dict):
			return predict(node['right'],row)
		else:
			return node['right']

test_tree = {'index': 0, 'right': 1, 'value': 6.642287351, 'left': 0}

for row in data:
	prediction=predict(test_tree,row)
	actual=row[-1]
	print "Actual %d , Predicted %d" %(actual,prediction)