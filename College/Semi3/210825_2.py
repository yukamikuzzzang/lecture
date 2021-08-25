#최대공약수
def gcd(a,b):
    while(b != 0):
        temp = a % b
        a = b
        b = temp
    return a

a = int(input("자연수 n은 "))
b = int(input("자연수 m은 "))


print(a ,"와 ",b,"의 최대 공약수 =", gcd(a,b))

