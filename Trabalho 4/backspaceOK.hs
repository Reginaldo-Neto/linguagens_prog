import System.IO
import Control.Monad
import Data.List
import Control.Applicative

data Class = Class {
    className :: String,
    attributes :: [(String, String)],
    operations :: [String]
} deriving (Show, Eq)

data Relation = Relation {
    sourceClass :: String,
    relationSymbol :: String,
    targetClass :: String
} deriving (Show, Eq)

type Database = ([Class], [Relation])

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering
    hSetEcho stdin False
    menu ([], [])

menu :: Database -> IO ()
menu db = do
    putStrLn "1 - List Classes"
    putStrLn "2 - Insert Class"
    putStrLn "3 - Insert Relation"
    putStrLn "4 - Count Attributes"
    putStrLn "5 - Generate Mermaid Diagram"
    putStrLn "0 - Exit"
    choice <- readUserInput
    case choice of
        "1" -> listClasses db >> menu db
        "2" -> insertClassInteractive db >>= menu
        "3" -> insertRelationInteractive db >>= menu
        "4" -> countAttributesInteractive db >> menu db
        "5" -> generateMermaid db >> menu db
        "0" -> putStrLn "Exiting..."
        _   -> putStrLn "Invalid option, please try again." >> menu db

listClasses :: Database -> IO ()
listClasses (classes, _) = do
    forM_ classes $ \(Class name attrs ops) -> do
        putStrLn $ "Class Name: " ++ name
        putStrLn $ "Attributes: " ++ show attrs
        putStrLn $ "Operations: " ++ show ops
        putStrLn ""

insertClassInteractive :: Database -> IO Database
insertClassInteractive (classes, relations) = do
    putStrLn "Enter class name: "
    name <- readUserInput
    putStrLn "Enter attributes as pairs (type name) separated by spaces (e.g., String name Int age): "
    attrsInput <- readUserInput
    let attrs = parseAttributes attrsInput
    putStrLn "Enter operations separated by spaces (e.g., getName() getAge()): "
    opsInput <- readUserInput
    let ops = words opsInput
    let newClass = Class name attrs ops
    return (newClass : filter (\c -> className c /= name) classes, relations)

parseAttributes :: String -> [(String, String)]
parseAttributes input = 
    let pairs = words input
    in [(pairs !! i, pairs !! (i + 1)) | i <- [0,2..length pairs - 2]]

insertRelationInteractive :: Database -> IO Database
insertRelationInteractive (classes, relations) = do
    putStrLn "Enter the source class name: "
    source <- readUserInput
    displayRelationTypes
    putStrLn "Enter the left-hand relation code (choose from above): "
    leftType <- getRelType <$> readLn
    displayLinkTypes
    putStrLn "Enter the link code (choose from above): "
    linkType <- getLinkType <$> readLn
    displayRelationTypes
    putStrLn "Enter the right-hand relation code (choose from above): "
    rightType <- getRelType <$> readLn
    putStrLn "Enter the target class name: "
    target <- readUserInput
    if classExists source classes && classExists target classes
        then let symbol = formatRelation leftType linkType rightType
                 newRelation = Relation source symbol target
             in return (classes, newRelation : filter (\r -> sourceClass r /= source || targetClass r /= target) relations)
        else do
            printClassWarning source target classes
            return (classes, relations)

displayRelationTypes :: IO ()
displayRelationTypes = do
    putStrLn "Relation Types:"
    putStrLn "0 - [] Empty"
    putStrLn "1 - [*] Composition"
    putStrLn "2 - [o] Aggregation"
    putStrLn "3 - [>] Association"
    putStrLn "4 - [<] Association"
    putStrLn "5 - [|>] Realization"
    putStrLn "6 - [<|] Inheritance"

displayLinkTypes :: IO ()
displayLinkTypes = do
    putStrLn "Link Types:"
    putStrLn "1 - [--] Solid"
    putStrLn "2 - [..] Dashed"

getRelType :: Int -> String
getRelType idx = ["", "*", "o", ">", "<", "|>", "<|"] !! idx

getLinkType :: Int -> String
getLinkType idx = ["", "--", ".."] !! idx

classExists :: String -> [Class] -> Bool
classExists name = any (\c -> className c == name)

printClassWarning :: String -> String -> [Class] -> IO ()
printClassWarning source target classes = do
    unless (classExists source classes) $ putStrLn $ "Warning: Source class \"" ++ source ++ "\" does not exist."
    unless (classExists target classes) $ putStrLn $ "Warning: Target class \"" ++ target ++ "\" does not exist."

formatRelation :: String -> String -> String -> String
formatRelation left link right = left ++ link ++ right

countAttributesInteractive :: Database -> IO ()
countAttributesInteractive (classes, _) = do
    putStrLn "Enter class name to count its attributes: "
    name <- readUserInput
    case find (\c -> className c == name) classes of
        Just (Class _ attrs _) -> putStrLn $ "Number of attributes: " ++ show (length attrs)
        Nothing -> putStrLn "Class not found."

generateMermaid :: Database -> IO ()
generateMermaid (classes, relations) = do
    let classCodes = map mermaidClassCode classes
        relationCodes = map mermaidRelationCode relations
    writeFile "diagram_mermaid.txt" $ unlines $ "classDiagram" : classCodes ++ relationCodes
    putStrLn "Diagrama Mermaid salvo com sucesso em \"diagram_mermaid.txt\"."

mermaidClassCode :: Class -> String
mermaidClassCode (Class name attrs ops) =
    let header = "class " ++ name
        attrsStr = concatMap (\(t, a) -> "  +" ++ t ++ " : " ++ a ++ "\n") attrs
        opsStr = concatMap (\op -> "  +" ++ op ++ "\n") ops
    in if null attrs && null ops
       then header
       else header ++ " {\n" ++ attrsStr ++ opsStr ++ "}"

mermaidRelationCode :: Relation -> String
mermaidRelationCode (Relation source symbol target) =
    source ++ " " ++ symbol ++ " " ++ target

readUserInput :: IO String
readUserInput = readUserInput' []

readUserInput' :: String -> IO String
readUserInput' xs = do
    x <- getChar
    case x of
        '\n' -> do
            putStrLn ""
            return (reverse xs)
        '\DEL' -> do
            if null xs
                then readUserInput' xs
                else do
                    putStr "\b \b"
                    readUserInput' (tail xs)
        _ -> do
            putChar x
            readUserInput' (x:xs)
