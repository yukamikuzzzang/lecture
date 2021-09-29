#QuickSort with Selection
#함수부분
def S_sort(A, k): #k번째
    A.sort()      #sort를 이용해 바로 값을 가져옴
    return A[k - 1] #배열의 내용을 가져와야 하기에

def Selection(A, left, right, k):
     pos = partition(A, left, right) #pos = middle value

     if(pos+1 == left+k):
         #피봇을 정했는데 그게 중앙값이네?
          return A[pos]
     elif(pos+1>left+k):
         #피봇이 더 큰 경우:왼편을 분할
         return Selection(A, left, pos-1, k)
         #피봇이 작은 경우:오른편을 분할
     else:
         return Selection(A, pos+1, right, k - (pos+1-left))
        
         

#재귀함수
def partition(A,left,right):
    low = left+1    #처음 장소(A[0])는 값 역시 0
    high= right
    pivot=A[left]   #피봇설정, A[0]에 피봇값을 넣음

    while(low <= high):
        while low <= right and A[low] < pivot:
            low += 1
        while high >= left and A[high] > pivot:
            high -= 1
        if low < high:
            A[low], A[high] = A[high], A[low]
    A[left], A[high] = A[high], A[left]
    return high
            
        
#출력부분
d = [40,8,9,2,30,60,15,55,3]
print("처음 값",d)

print("3th Value?",Selection(d,0,len(d)-1, 3))
#A[0]는 포함하지 않음, 7번째 숫자를 추출할 것.

#sort를 이용하여 원하는 값을 추출.
print("3th Value?", S_sort(d,3))


