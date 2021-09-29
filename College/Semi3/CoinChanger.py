#거스름돈 금액:100, 500, 1000, 5000, 10000
import random


change = random.randint(0,99999) % 1000
change = change * 100
print("랜덤으로 99900원 까지 받습니다.",change)

a=b=c=d=e=0
if(change == 0):
    print("동전을 넣지 않았습니다.")
while(change >= 100):
    if change >= 10000 :
        change=change - 10000
        a = a+1
    elif change >= 5000 :
        change=change - 5000
        b=b+1
    elif change >= 1000 :
        change=change - 1000
        c=c+1
    elif change >= 500 :
        change=change - 500
        d=d+1
    elif change >= 100 :
        change=change - 100
        e=e+1

print("10000: ",a,"5000: ",b,"1000: ",c,"500: ",d,"100: ",e)
print("동전의 총 개수:", a+b+c+d+e)

