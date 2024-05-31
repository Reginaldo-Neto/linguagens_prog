type Student = (String, Int)
type ListStudents = [Student]
list :: ListStudents
list = [("John",23),("Ana",21),("Julia",18),("Theo",15)]
age(n,i) = i
ages = map age
age_average l =average (map age l)
average l = div (foldr (+) 0 l) (length l)
countAdults [] = 0
countAdults ((n,i):xs) = if i>18 then (1+ countAdults xs)
 else countAdults xs
count_adults2 list =length (filter(\(x,y) -> (y>18)) list) 