import csv
import pickle
from scipy.sparse import lil_matrix
import numpy as np 

data = []
with open('data.csv', 'rb') as csvfile:
	d = csv.reader(csvfile)
	for rec in d:
		data.append({'title': rec[0], 'link': rec[1], 'text': eval(rec[2])})


f = open('dict.dat', 'r')
d = eval(f.readline())


A = lil_matrix((len(d), len(data)))

counter = 0

for article in data:
	vect = np.zeros((len(d), 1))
	
	for word in article['text']:
		if word in d:
			index = d.index(word)
			vect[index] += 1

	A[:, counter] = vect

	counter += 1
	print(counter)
	
f = open('matrix.dat', 'w')

pickle.dump(A, f)

f.close()
