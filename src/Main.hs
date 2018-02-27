{- Main.hs
 -
 - Example driver file for NaiveBayes module.
 -
 - Will Badart
 - created: FEB 2018
 -}

import NaiveBayes (classify, splitBy)
import System.Environment (getArgs)
import System.IO (
    BufferMode(NoBuffering), getLine, hSetBuffering, readFile, stdout)


main = do
    args <- getArgs
    let fname = if length args >= 1
                then args !! 0 else "weather.csv"

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
