{-# LANGUAGE TypeOperators #-}

import qualified Data.Array.Repa as R
import System.Random
import Data.Random.Normal
import Data.List
import Data.Function 

weights:: (Int,Int)->(Float,Float) -> R.Array R.U (R.Z R.:. Int R.:. Int) Float

feedForward:: R.Array R.U (R.Z R.:. Int R.:. Int) Float -> [layer] ->[Float]

data Layer = Layer {nodes :: R.Array R.U (R.Z R.:. Int R.:. Int) Float, activation:: Float -> Float}

weights (nodes,features) range = R.fromListUnboxed (R.Z R.:. nodes R.:. features) values
	where 
		values = take (nodes * features) $ randomRs range gen
		gen = mkStdGen 1

twoLayer features hidden = [input, hidden, output]
	where 
		input = Layer{nodes= weights (1,features) (1,1), activation=id}
		hidden = Layer{nodes = weights (hidden,features) (0,1), activation=tanh}
		output = Layer{nodes = weights (1,hidden) (0,1), activation=tanh}


feedForward input layers = scanl (\layer -> (activation layer) 1.0) input layers 

main = do 
	let network = twoLayer 10 3
	print "hello"
	print $ weights (3,3) (1,1)
	--let l = weights (3,3) (0,1)
	--let hl = Hidden{nodes=l, activation=tanh} 
	--print $ (activation l1) 1.0  