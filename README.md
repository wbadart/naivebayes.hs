# naivebayes.hs

Small implementation of a Naive Bayes model in Haskell


## Installation

`naivebayes.hs` has no dependencies outside of the standard library, so it can
be installed simply as follows:

    $ git clone https://github.com/wbadart/naivebayes.hs
    $ cabal install naivebayes.hs.cabal


## Usage

The `NaiveBayes` module's main export is `classify`, which is a function of a
dataset and an unlabeled tuple. The dataset must be a 2D matrix of strings
where each row is a training instance and each column is a feature/ value. Yes,
this means that currently, the module only works on categorical data (what can
I say, I wrote this to learn Haskell, not advance the state of the art of
machine learning :P).

Take the following driver file, for instance (it uses the other export of the
module, `splitBy`, to help form the training data):


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


This example is actually provided by `Main.hs`, here in the repo.


## License

Distributed under the MIT license. See [LICENSE] and [opensource.org] for
details.


[LICENSE]: ./LICENSE
[opensource.org]: https://opensource.org/licenses/MIT
