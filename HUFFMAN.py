import heapq

def heap_tree(freq,alpha):
    n=len(alpha)
    h=[]

#(키, 값) 삽입
    for i in range(n):
        heapq.heappush(h, (freq[i],alpha[i]))
        #빈 리스트 h에 빈도수, alpha값을 push<삽입>

#병합
    for i in range(1,n):
        test1 = heapq.heappop(h) #가장 작은 트리
        test2 = heapq.heappop(h) #그 다음으로 작은 트리
        heapq.heappush(h, (test1[0]+test2[0], test1[1]+test2[1]))
        print(test1, "+", test2)

    print(heapq.heappop(h))
    #작은 노드들을 병합하여 부모노드 생성   
alpha=["a","b","c","d","e"]
freq=[6,4,3,5,1] #빈도수
heap_tree(freq, alpha)


    
