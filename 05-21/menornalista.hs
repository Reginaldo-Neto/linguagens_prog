minlist[] = error "Empty List"
minlist[x] = x
minlist(x:y:xs) = if(x<y) 
                    then minlist(x:xs) 
                    else minlist(y:xs)