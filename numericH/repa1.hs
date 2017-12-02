import qualified Data.Array.Repa as R


main = do 
	let inputs = [1..10] ::[Double]
	let x = R.fromListUnboxed (R.Z R.:. (10::Int)) inputs
	let y = R.fromListUnboxed (R.Z R.:. (3::Int) R.:. (3::Int) R.:. (3::Int)) ([1..27]::[Int])
	--let t :: R.Array R.U R.Z Int;t = R.fromListUnboxed (Z R.:. (3::Int), R.:. (3::Int) R.:. (3::Int)) [1..27]::[Int]
 