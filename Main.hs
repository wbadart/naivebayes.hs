{- Main.hs
 -
 - Example driver file for NaiveBayes module.
 -
 - Will Badart
 - created: FEB 2018
 -}

import NaiveBayes (classify, splitBy)
import System.IO (getLine, readFile)


main = do
    content <- readFile "weather.csv"
    let split = splitBy (==',')
        rows = map split $ lines content

    putStr "instance> "
    line <- getLine

    let tup = split  line
    print $ classify rows tup
    main
