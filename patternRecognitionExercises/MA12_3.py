import scipy.io as sio 
import numpy as np 
from scipy.spatial import distance 
import itertools as it 
import matplotlib.pyplot as plt
import operator 
import math 

def addMember(m, v):
	return np.concatenate((m,v), axis=0)

def createCluster(clusters, new):
	clusters.append(new)
	return clusters

def average(m):
	return np.mean(m, axis=0)

def clusterMember(x, clusters):
	if sum([x in c for c in clusters]) == 1:
		return True
	else: 
		print "hello"
		return False

def mbsas(matrix, q=10, tetha=math.sqrt(2)):
	m = 1
	clusters = [matrix[0,:]]
	for x in matrix[1:]:
		distances = map(lambda y: distance.euclidean(x,y), map(average, clusters))
		if min(distances) > tetha and m < q:
			m += 1
			clusters = createCluster(clusters, x)
	for x in matrix:
		if not clusterMember(x, clusters):
			distances = map(lambda y: distance.euclidean(x,y), map(average, clusters))
			closest = clusters[distances.index(min(distances))]
			clusters[distances.index(min(distances))] = addMember(closest, x)
	return clusters 

def bsas(matrix, q=10, tetha=math.sqrt(2)):
	m = 1
	clusters = [matrix[0,:]]
	for x in matrix[1:]:
		distances = map(lambda y: distance.euclidean(x,y), map(average, clusters))
		if min(distances) > tetha and m < q:
			m += 1
			clusters = createCluster(clusters, x)
		else:
			closest = clusters[distances.index(min(distances))]
			clusters[distances.index(min(distances))] = addMember(closest, x)
	return clusters 

def coordinates(members, index):
	return [x[index] for x in members.tolist()]

def flatten(l):
	return reduce(operator.add,l)

if __name__ == "__main__": 
	m = np.matrix([[1,1],[1,2],[2,2],[2,3],[3,3],[3,4],[4,4],[4,5],[5,5],[5,6],[-4,5],[-3,5],[-4,4],[-3,4]])
	clusters = bsas(m)
	clusters = mbsas(m)
	xValues = map(lambda cluster: coordinates(cluster, 0), clusters)
	yValues = map(lambda cluster: coordinates(cluster, 1), clusters)
	colours = ['b', 'g', 'r', 'c', 'm', 'y','k','w', "brown", "Aqua", "darkred"]
	col = []
	i = 0
	for cluster in clusters:
		col.append([colours[i]]*len(cluster))
		i += 1
	plt.scatter(flatten(xValues),flatten(yValues),s=40.0,c=flatten(col),alpha=0.5)
	plt.show()