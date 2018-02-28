{- Main.hs
 -
 - Example driver file for NaiveBayes module.
 -
 - Will Badart
 - created: FEB 2018
 -}

import System.Environment (getArgs)
import System.IO (
    BufferMode(NoBuffering), getLine, hSetBuffering, readFile, stdout)

import NaiveBayes (classify, splitBy)


splitBy :: (Char -> Bool) -> String -> [String]
splitBy p = foldr f [[]]
    where f c l@(x:xs) | p c = []:l
                       | otherwise = (c:x):xs

main = do
    args <- getArgs
    let fname = if not $ null args
                then head args else "weather.csv"

    putStrLn $ "Using training set from " ++ fname

    hSetBuffering stdout NoBuffering

    content <- readFile fname
    let split = splitBy (==',')
        rows = map split $ lines content

    let loop = do

        putStr "instance> "
        line <- getLine

        let tup = split  line
        print $ classify rows tup

        loop

    loop
