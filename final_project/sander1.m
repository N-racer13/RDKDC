A = [2 -3 2; 0 -1 3/2; 0 0 2]
y_0 = [0; 1; 2]
expA = expm(A)
[v, d] = eig(A)