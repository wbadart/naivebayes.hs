{- Main.hs
 -
 - Example driver file for NaiveBayes module.
 -
 - Will Badart
 - created: FEB 2018
 -}

import NaiveBayes (classify, splitBy)
import System.Environment (getArgs)
import System.IO (getLine, readFile)


main = do
    args <- getArgs
    let fname = if length args >= 1
                then args !! 0 else "weather.csv"

    putStrLn $ "Using training set from " ++ fname

    content <- readFile fname
    let split = splitBy (==',')
        rows = map split $ lines content

    putStr "instance> "
    line <- getLine

    let tup = split  line
    print $ classify rows tup
    main
