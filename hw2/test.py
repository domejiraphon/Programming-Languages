def mystery(a1, a2, a3, a4, a5):
    for count in [1,2, 3]:
        a1 = a2 + a4 
        a4 = a4+1 
        a5 = (a3+a2) * 2
        print(a1, a2, a3, a4, a5)
i = 1 
j = 0 
mystery(i, i+1, i*4, j, j)