import csv
import pickle
from scipy.sparse import lil_matrix
import numpy as np 


data = []
with open('data.csv', 'rb') as csvfile:
	d = csv.reader(csvfile)
	for rec in d:
		data.append({'title': rec[0], 'link': rec[1], 'text': eval(rec[2])})
print('articles loaded')

f = open('dict.dat', 'r')
d = eval(f.readline())
print('dictionary loaded')

f = open('idf.dat', 'r')
idf = np.array(pickle.load(f))
print('idf loaded')

f = open('matrix.dat', 'r')
A = pickle.load(f)
print('matrix loaded')

for i in range(len(data)):
	A[:, i] = np.transpose(np.multiply(np.transpose(A[:, i].toarray()), idf))

	print(i)

f = open('matrix_idf.dat', 'w')

pickle.dump(A, f)

f.close()