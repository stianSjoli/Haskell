{-# LANGUAGE TypeOperators #-}

import qualified Data.Array.Repa as R
import System.Random
import Data.Random.Normal
import Data.List
import Data.Function 
import qualified Data.Array.Repa.Algorithms.Matrix as M

-- The python code that this is based on: http://adorio-research.org/wordpress/?p=1308

weights:: (Int,Int)->(Double,Double) -> R.Array R.U (R.Z R.:. Int R.:. Int) Double

{-
    Performs iterative power method for dominant eigenvalue.
     A  - input matrix.
     x0 - initial estimate vector.
     maxiter - maximum iterations
     ztol - zero comparison.
     mode:
       0 - divide by last nonzero element.
       1 - unitize.
    Return value:
     eigenvalue, eigenvector
    """
-}

powerIteration::R.Array R.U (R.Z R.:. Int R.:. Int) Double->R.Array R.U (R.Z R.:. Int R.:. Int) Double->[(R.Array R.U (R.Z R.:. Int R.:. Int) Double, Double)]

weights (nodes,features) range = R.fromListUnboxed (R.Z R.:. nodes R.:. features) values
	where 
		values = take (nodes * features) $ randomRs range gen
		gen = mkStdGen 1


powerIteration m b = (newB, lambda):powerIteration m newB
	where 
		lambda = nom/sumSquared b 
		nom = R.sumAllS $ (R.computeS $ R.zipWith (*) newB b :: R.Array R.U (R.Z R.:. Int R.:. Int) Double)
		newB = M.mmultS v (vector v (1/(sumSquared v), 1/(sumSquared v)))		
		v = M.mmultS m b
		sumSquared n = R.sumAllS $ (R.computeS $ R.map (^2) n :: R.Array R.U (R.Z R.:. Int R.:. Int) Double) 
	 
vector m range = weights (rows,1) range
	where 
		(R.Z R.:. _ R.:. rows) = R.extent m

main = do 
	let matrix = R.fromListUnboxed (R.Z R.:. (2::Int) R.:. (2::Int)) ([3,6,1,4]::[Double])
	let x = weights (2,1) (1,1)
	print $ (powerIteration matrix x) !! 1000   