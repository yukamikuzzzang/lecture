def FirstFit(product, C):
    n = 0 #통의 수
    remain = [0] * len(product) #남는 통 <초기화>

    for i in range(len(product)):
        F = False
        for j in range(n):  #0 >= 7
            if remain[j] >= product[i]:
                remain[j] = remain[j]-product[i]
                F = True
                break;
        if F == False:
            remain[n] = C-product[i]
            n = n+1
    return n

def BestFit(product, C):
    product.sort(reverse=True)
    return FirstFit(product, C)

def NextFit(product, C):
    n = 0
    remain = 0
    
    for i in range(len(product)):
        if product[i] > remain: #7>0
            n = n+1             #통 수를 하나 증가
            remain = C-product[i]   #통의 크기(10 - 7 = 3)
        else:
            remain=remain-product[i]
    return n



product = [1,4,9,5,2,3,6]
C=10
print(product,C)
print("최초적합=",FirstFit(product, C))
print("Next적합=",NextFit(product, C))
print("Best적합=",BestFit(product, C))    #정렬된 상태가 영향을 주기 때문에

X = FirstFit(product, C)
Y = NextFit(product, C)
Z = BestFit(product, C)

Answer = 0

if X >= Y:
    if Z >= Y:
           Answer = Y
    else:
           Answer = Z
else:
    if Z >= X:
           Answer = X
    else:
           Answer = Z

print("필요한 최소한의 통의 개수 = ",Answer,"개")
