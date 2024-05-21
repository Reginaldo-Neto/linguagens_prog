max2 :: Int -> Int-> Int
max2 x y = if (x>y) then x else y
max3 :: Int -> Int-> Int -> Int
max3 x y z = let c = max2 x y in max2 c z

tri x y z = if ((x+y >= z) && (x+z >= y) && (z+y >= x))
	then True 
	else False