leInt :: IO Int
leInt = do putStr "write a number: "
 n <- getLine
 return ((read n)::Int)
prog1 :: IO ()
prog1 = do n <- leInt
 putStrLn ("Result is "++show(n+5) ++ "\n")
leInt2 :: IO String
leInt2 = do putStr "write a number: "
 n <- getLine
 return n
prog2 :: IO ()
prog2 = do n <- leInt2
 putStrLn("Result is "++(show(((read
n)::Int)+5))) 
