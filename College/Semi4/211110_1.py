import padnas
def EditDistance(S,T,m,n,mem):
    if m == 0:
        return n
    if n == 0:
        return m
    #맨 끝자리에 있을 때 어떤 값을 리턴하는지를 결정.
    if mem[m-1][n-1] == None:
        if S[m-1]==T[n-1]:
            mem[m-1][n-1]=EditDistance(S,T,m-1,n-1,mem)
        else:
            mem[m-1][n-1]=1+\
                           min(EditDistance(S,T,m,n-1,mem), #삽입
                               EditDistance(S,T,m-1,n,mem), #삭제
                               EditDistance(S,T,m-1,n-1,mem))#대체
        print("mem[%d][%d]="%(m-1, n-1), mem[m-1][n-1])
    return mem[m-1][n-1]

S="strong"
T="stone"

m=len(S)
n=len(T)

mem = [[None for _ in range(n)] for _ in range(m)]

dist=EditDistance(S,T,m,n,mem)
print("편집거리=",dist)

print(dist)

