import Control.Concurrent (threadDelay)
import System.Directory (doesFileExist)
import System.Environment (getArgs)
import System.IO
import Control.Concurrent
import Control.Exception


cellToInt :: Char -> Int
cellToInt '#'  = 1
cellToInt '.'  = 0
cellToInt  c   = error("Invalid character in grid: " ++ [c]) 

generateGrid :: String -> [[Int]]
generateGrid = map (map cellToInt) . lines

checkGridSize :: [[Int]] -> Bool
checkGridSize [] = False
checkGridSize (x:rest) = 
    let width = length (x)
    in all (\row -> length row == width) (x:rest)

paused :: [[Int]] -> IO ()
paused board = do
    inputAvailable <- hReady stdin
    if inputAvailable
        then do
            c <- getChar
            if c == 'p'
                then simulate board
            else paused board
    else
        paused board

simulate :: [[Int]] -> IO ()
simulate board = do
    putStr "\ESC[2J"
    printGrid board

    threadDelay 400000

    let nextBoard = calculateNextMove board

    inputAvailable <- hReady stdin

    if inputAvailable
        then do
            c <- getChar
            if c == 'q'
                then putStrLn "User ended the simulation."
            else if c == 'p'
                then do
                    putStrLn "Simulation paused. Press p to continue..."
                    paused nextBoard
            else simulate nextBoard
        else
            simulate nextBoard

printGrid :: [[Int]] -> IO ()
printGrid grid = do
    mapM_ printRow grid
    putStrLn "Press Ctrl+C or q to end or p to freeze the simulation."
  where
    printRow row = putStrLn (concatMap showCell row)
    showCell 0 = "."
    showCell 1 = "#"
    showCell _ = "?"


generateMapFromFile :: String -> IO [[Int]]
generateMapFromFile file = do
    content <- readFile file
    return (generateGrid content)

getCellValue :: [[Int]] -> Int -> Int -> Int
getCellValue grid x y
    | y < 0 || y >= length grid = 0
    | x < 0 || x >= length (grid !! y) = 0
    | otherwise = (grid !! y) !! x

getNeighborSum :: [[Int]] -> Int -> Int -> Int
getNeighborSum grid x y =
    sum [ getCellValue grid (x + dx) (y + dy)
        | dx <- [-1,0,1]
        , dy <- [-1,0,1]
        , (dx, dy) /= (0,0)
        ]

getNextCellValue :: [[Int]] -> Int -> Int -> Int
getNextCellValue grid x y =
    let neighbors = getNeighborSum grid x y
        current = getCellValue grid x y
    in case neighbors of
        3 -> 1
        2 -> current
        _ -> 0

calculateNextMove :: [[Int]] -> [[Int]]
calculateNextMove grid =
    [ [ getNextCellValue grid x y
      | x <- [0 .. width - 1]
      ]
    | y <- [0 .. height - 1]
    ]
  where
    height = length grid
    width  = length (grid !! 0)

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetEcho stdin False

    (arg:rest) <- getArgs
    if null (arg:rest)
        then error("Please provide a file name as an argument.")
    else do
        exists <- doesFileExist arg
        if exists
            then do
                board <- generateMapFromFile arg
                if not (checkGridSize board)
                    then error("Invalid grid size: All rows must have the same number of columns.")
                    else simulate board
            else do
                error("File not found.") 