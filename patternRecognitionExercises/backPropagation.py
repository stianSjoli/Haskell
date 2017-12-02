import random as r
import numpy as np
from math import exp as exp

#This implementation is heavily based on: http://www.bogotobogo.com/python/python_Neural_Networks_Backpropagation_for_XOR_using_one_hidden_layer.php"

def rweights(layers):
    l = []
    for i in range(1,len(layers) -1):
        r = 2*np.random.random((layers[i-1]+1, layers[i]+1))-1 
        l.append(r)
    r = 2*np.random.random( (layers[i] + 1, layers[i+1])) - 1
    l.append(r)
    return l 

class NeuralNet(object):
    def __init__(self, weights): 
        self.weights = weights
        self.squashingFunc = np.tanh
        self.derivateSquashing = lambda x: 1.0-x**2 
        
    def train(self, data, labels):
        ones = np.atleast_2d(np.ones(data.shape[0]))
        data = np.concatenate((ones.T, X), axis=1)
        self.backPropagation(data, labels)

    def feedForward(self, input, weights):
        outputs = [input]
        def addOutput(weight):
            dot_value = np.dot(outputs[-1], weight)
            activation = self.squashingFunc(dot_value)
            outputs.append(activation)
        map(addOutput, weights)
        return outputs

    def backPropagation(self, data, labels, learning_rate=0.2, epochs=100000):
        for _ in range(epochs): 
            i = np.random.randint(len(labels))
            outputs = self.feedForward(data[i], self.weights)
            error = labels[i] - outputs[-1]
            deltas = [error * self.derivateSquashing(outputs [-1])]
            for l in range(len(outputs) - 2, 0, -1): 
                deltas.append(deltas[-1].dot(self.weights[l].T)*self.derivateSquashing(outputs[l]))
            deltas.reverse()
            for i in range(len(self.weights)):
                layer = np.atleast_2d(outputs[i])
                delta = np.atleast_2d(deltas[i])
                self.weights[i] += learning_rate * layer.T.dot(delta)

    def classify(self,x): 
        a = np.concatenate((np.ones(1).T, np.array(x)), axis=1) 
        for l in range(0, len(self.weights)):
            a = self.squashingFunc(np.dot(a, self.weights[l]))
        return (x,int(round(a,0)))


if __name__ == "__main__":
    np.random.seed(666)
    nn = NeuralNet(rweights([2,2,1]))
    X = np.array([[0, 0],
                  [0, 1],
                  [1, 0],
                  [1, 1]])
    y = np.array([0, 1, 1, 0])
    nn.train(X, y) 
    out = map(nn.classify, X) 
    print out 
