import System.Random
import Data.Random.Normal
import Data.List
import Data.Function 

euclideanDistance:: [Float] -> [Float] -> Float 

euclideanDistance x1 x2 = sqrt $ sum square
	where 
		square = zipWith (*) diff diff 
		diff = zipWith (-) x1 x2 

kNN' k w1 w2 x = if w1N >= w2N then 1 else 0
	where  
		(w1N, w2N) = partition (`elem` w1) neighbours
		neighbours = take k (sortBy (\y z -> fromX y `compare` fromX z) (w1 ++ w2))
		fromX = euclideanDistance x  

random' mean = zip x y 
	where				 
		x = normals' (mean, 0.2) randomGenX :: [Float]
		y = normals' (mean, 0.2) randomGenY :: [Float]
		randomGenX = mkStdGen 666
		randomGenY = mkStdGen 6

randomW1 = [[x,y] | (x,y) <- random' 0.0]

randomW2 = [[x,y] | (x,y) <- random' 1.5]

main = do
	let w1Train = take 100 $ randomW1
	let w2Train = take 100 $ randomW2
	let kNN = kNN' 10 w1Train w2Train
	let w1Test = drop 100 $ take 200 $ randomW1
	let w2Test = drop 100 $ take 200 $ randomW2
  	print $ map kNN (w1Test ++ w2Test)
