arr = [45, 20, 60, 35, 10, 55, 90, 85, 75, 25]
max = arr[0]

for i in range(len(arr)):
    if max < arr[i]:
        max = arr[i]
print(arr, "최대값=", max)
