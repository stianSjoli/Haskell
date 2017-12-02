{-# LANGUAGE TypeOperators #-}

import qualified Data.Array.Repa as R
import System.Random
import Data.Random.Normal
import Data.List
import Data.Function 
import qualified Data.Array.Repa.Algorithms.Matrix as M
import Numeric 

row::Int -> [Double]

markov:: Int -> R.Array R.U R.DIM2 Double

iteration:: R.Array R.U R.DIM2 Double -> R.Array R.U R.DIM3 Double

values' gen range = n: (values' gen (0,1.0-n)) 
	where 
		n = head $ take 1 $ randomRs range gen

row columns = freeColums ++ [1.0 - sum freeColums]
	where
		freeColums = take (columns-1) $ values' (mkStdGen 1) (0,1) 
	
markov size = R.fromListUnboxed (R.Z R.:. size R.:. size) $ concatMap row $ replicate size size


iteration m = R.fromListUnboxed (R.Z R.:. rows R.:. columns R.:. 2) $ R.toList (M.mmultS m m) ++ R.toList (m)
	where 
		(R.Z R.:. rows R.:. columns) = R.extent m 

main = do
	let m = markov 10000
	print $ R.sumAllS m
	--print $ iteration m 
	--print $ addNew m   


	