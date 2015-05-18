import numpy as np
from scipy.sparse.linalg import svds
from scipy.sparse import lil_matrix
import pickle

f = open('matrix_idf.dat', 'r')
A = pickle.load(f)
f.close()

print 'reading done'

t = [20, 50, 100, 500, 800]

for i in t:
	u, s, v = svds(A, k=i)

	f = open('u'+str(i)+'.dat', 'w')
	pickle.dump(u, f)
	f.close()

	f = open('s'+str(i)+'.dat', 'w')
	pickle.dump(s, f)
	f.close()

	f = open('v'+str(i)+'.dat', 'w')
	pickle.dump(v, f)
	f.close()

	print i