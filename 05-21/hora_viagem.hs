test (a,b) (c,d) 
    | a < c = True  
    | a == c && b < d = True
    | otherwise = False                    

minutos (a,b) (c,d) 
    | a < c = ((c - a) * 60) + (d - b)
    | a == c && b < d = d - b
    | otherwise = 0

trip_test [((x,y), (z,k))] = test (x,y) (z,k)

trip_test (((a,b), (c,d)):((e,f), (g, h)):cauda) 
    | test (a,b) (c,d) && test (c,d) (e,f) = trip_test (((e,f), (g,h)):cauda)
    | otherwise = False

total_travel [] = 0
total_travel (((a,b), (c,d)):cauda) = 
    minutos (a,b) (c,d) + total_travel cauda

total_wait [((a,b), (c,d))] = 0
total_wait (((a,b), (c,d)):((e,f), (g, h)):cauda) = minutos (c,d) (e,f) + total_wait (((e,f),(g,h)):cauda)

total_tudo l = total_travel l + total_wait l

{-- possivel teste
trip_test [((9,30), (10,15)), ((11,10),(12,00))]
total_travel [((9,30), (10,15)), ((11,10),(12,00))]
total_wait [((9,30), (10,15)), ((11,10),(12,00))]
total_tudo [((9,30), (10,15)), ((11,10),(12,00))]
}