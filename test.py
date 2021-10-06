class mSets:
    def __init__(self, n):
        self.parent=[-1]*n
        self.set_size=n
        
    def find(self, id):
        while(self.parent[id]>=0):
            id = self.parent[id]
        return id
    
    def union(self, s1, s2):
        self.parent[s1]=s2
        self.set_size-=1    


def test(V, m):
    n = len(V)
    dsets = mSets(n) #클래스로 받음.
    E=[] # 간선 리스트

    for i in range(n-1):
        for j in range(i+1, n):
            if m[i][j] != None:
                E.append((i, j, m[i][j]))

    E.sort(key = lambda e: e[2])
    ecount = 0
                
    for i in range(len(E)):
        e=E[i]
        uset=dsets.find(e[0])   #클래스로..
        vset=dsets.find(e[1])

        if uset != vset:
            dsets.union(uset, vset)
            print("추가(%s, %s, %d)"% (V[e[0]], V[e[1]], e[2]))
            ecount+=1 #간선추가

        if ecount == n-1:
            break
                        
                    
ver = ["A","B","C","D","E","F","G","H"] #노드
weight = [[None, 5, 3 ,None, 7, None, None, None], #A
          [5, None, None, 4, 1, None, None, None], #B
          [3, None, None, None, 4, 3, None, 6], #C
          [None, 4, None, None, None, None, 3, None], #D
          [7, 1, 4, None, None, None, 8, 2], #E
          [None, None, 3, None, None, None, None, 1], #F
          [None, None, None, 3, 8, None, None, 5], #G
          [None, None, 6, None, 2, 1, 5, None]] #H


test(ver, weight)
