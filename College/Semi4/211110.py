def knapsack(wg, mm, C, rowCount):
    #초기화, K배열의 모든 값은 0
    k = [[0 for _ in range(C+1)] for _ in range(rowCount + 1)]

    for row in range(0, rowCount):
        print(wg[row], "kg[",mm[row],"]-->", end="")
        for col in range(0, C):
            if wg[row] > col:
                k[row][col] = k[row-1][col]
            else:
                #배낭에 들어갈 수 있는 개수를 구하는 것.
                v1 =mm[row] + k[row-1][col-wg[row]]
                v2 =k[row-1][col]
                k[row][col] = max(v1,v2)
            print("%2d "%k[row][col],end="")
        print()
    return k[rowCount-1][C-1]
                

C = 11              #배낭 무게
rowCount = 4
wg = [5, 4, 6, 3]    #선물 무게
mm = [10, 40, 30, 50]

#구하려는 것?
#배낭에 최대가치를 담아라..!

maxValue = knapsack(wg, mm, C, rowCount)
print()
print("배낭에 담는 최대값", maxValue)
