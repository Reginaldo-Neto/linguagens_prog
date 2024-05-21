conta x [] = 0
conta x (cabeca:cauda) = if (x==cabeca) 
                        then 1+conta x (cauda) 
                        else conta x (cauda) 