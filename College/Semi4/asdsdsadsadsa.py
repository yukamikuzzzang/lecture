import copy

def shortest(v,w):
    vsize = len(v)
    D = copy.deepcopy(w)

    for k in range(vsize):
        for i in range(vsize):
            for j in range(vsize):
                D[i][j] = min(D[i][k]+D[k][j],D[i][j])
                print(D)
    
#출력
def printD(D):
    vsize = len(D)
    print("========================")

    for i in range(vsize):
        for j in range(vsize):
            if (D[i][j]==INF):
                print(" INF", end="")
            else:
                print("%4d" % D[i][j], end="")
        print(" ")


#데이터
INF = 999  #무한대
vertex = ['V0','V1','V2']
weight=[[0,3,INF],
        [6.0,2],
        [1,5,0]]

print("Algorithm")
print(list(weight))
shortest(vertex, weight)
