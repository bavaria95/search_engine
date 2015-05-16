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

N = float(len(data))

idf = []

i = 0

for w in d:
	count = 0
	for article in data:
		if w in article['text']: count += 1

	idf.append(np.log2(N / count))
	print(i)
	i += 1

f = open('idf.dat', 'w')

pickle.dump(idf, f)

f.close()

