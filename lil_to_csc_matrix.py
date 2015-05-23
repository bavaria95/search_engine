from scipy.sparse import lil_matrix
from scipy.sparse import csc_matrix
import pickle

f = open('matrix.dat', 'r')
A = pickle.load(f)

B = A.tocsc()

f = open('matrix_csr.dat', 'w')
pickle.dump(B, f)
f.close()
