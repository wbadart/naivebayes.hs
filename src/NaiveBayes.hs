{- NaiveBayes.hs
 -
 - Implement a Naive Bayes machine learning model in Haskell.
 -
 - Will Badart
 - created: FEB 2018
 -}

module NaiveBayes (classify, splitBy) where

import Data.Function (on)
import Data.List (genericLength, maximumBy, nub)


splitBy :: (Char -> Bool) -> String -> [String]
splitBy p = foldr f [""]
    where f c l@(str:strs) | p c = []:l
                           | otherwise = (c:str):strs


countBy :: Num i => (a -> Bool) -> [a] -> i
countBy p = genericLength . filter p


classify :: [[String]] -> [String] -> String
classify data_ tup =
    let labels = nub $ map last data_
        prob = labelProb data_ tup
    in maximumBy (compare `on` prob) labels


labelProb :: [[String]] -> [String] -> String -> Double
labelProb data_ tup label =
    let label_ct = countBy ((==label) . last) data_
        prior_prob = label_ct / genericLength data_
    in prior_prob * product [probability ft val label data_ | (ft, val) <- zip [0..] tup]


probability :: Int -> String -> String -> [[String]] -> Double
probability feature value label data_ =
    let tupmatch tup = tup !! feature == value && last tup == label
        count = countBy tupmatch data_
        total = countBy ((==label) . last) data_
    in count / total
