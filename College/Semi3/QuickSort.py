#QuickSort
#함수부분
#재귀함수
def QuickSort(A, left, right):
    if(left < right):
        mid = partition(A, left, right)
        QuickSort(A, left, mid-1)
        QuickSort(A, mid+1, right)

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

QuickSort(d,0,len(d)-1) #A[0]는 포함하지 않음
print("정렬 후",d)
