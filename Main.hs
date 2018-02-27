{- Main.hs
 -
 - Implement a Naive Bayes machine learning model in Haskell.
 -
 - Will Badart
 - created: FEB 2018
 -}

import Data.Function (on)
import Data.List (genericLength, maximumBy, nub)
import System.Environment (getArgs)
import System.IO (readFile)


main = do
    content <- readFile "weather.csv"
    let rows = map (wordsWhen (==',')) $ lines content
        tup = ["rainy", "hot", "high", "false"]
    putStrLn $ show (probability 0 "sunny" "yes" rows)
    putStrLn $ show (labelprob rows tup "yes")
    putStrLn $ show (labelprob rows tup "no")
    putStrLn $ show (classify rows tup)
    return ()


wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p "" = []
wordsWhen p s = let (w, s') = break p s in w:wordsWhen p s'


classify :: [[String]] -> [String] -> String
classify data_ tup =
    let labels = nub $ map last data_
    in maximumBy (compare `on` (labelprob data_ tup)) labels


labelprob :: [[String]] -> [String] -> String -> Double
labelprob data_ tup label =
    let label_ct = genericLength $ filter ((==label) . last) data_
        prior_prob = label_ct / genericLength data_
    in prior_prob * product [probability ft val label data_ | (ft, val) <- zip [0..] tup]


probability :: Int -> String -> String -> [[String]] -> Double
probability feature value label data_ =
    let tupmatch tup = tup !! feature == value && last tup == label
        count = genericLength $ filter tupmatch data_
        total = genericLength $ filter ((==label) . last) data_
    in count / total
