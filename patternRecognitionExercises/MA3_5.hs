import System.Random
import Data.Random.Normal
import Graphics.EasyPlot
import Data.List
import Data.Function 

dotp::[Float]->[Float]-> Float

dotpAcc:: Acc (Vector Float) -> Acc (Vector Float) -> Acc (Scalar Float)

train::[Float]->[[Float]]-> [[Float]]->[Float]

train':: [Float] -> [[Float]]->[[Float]]-> [[Float]]

converged::[Float] -> [[Float]] -> [[Float]] -> Bool

classify'::[Float]->[Float]->Int 

dotp xs ys = foldl (+) 0 (zipWith (*) xs ys)

dotpAcc xs ys = fold (+) 0 (zipWith (*) xs ys)

train' w w1 w2 = scanl f w set
			where 
				f w xt | xt `elem` w1 && (dotp xt w <= 0) = zipWith (+) w (map (*rho) xt)	
				f w xt | xt `elem` w2 && (dotp xt w >= 0) = zipWith (-) w (map (*rho) xt)	
				f w xt = w
				rho = 1
				set = w2 ++ w1 

train w w1 w2 | not (converged w w1 w2) = train newW w1 w2
	where 
		newW = last (train' w w1 w2) 

train w w1 w2 | converged w w1 w2 = w

randomP mean randomGen = zip x y 
	where				 
		x = normals' (mean, 0.2) randomGen :: [Float]
		y = normals' (mean, 0.2) randomGen :: [Float]

randomW1 randomGen = [[x,y,1] | (x,y) <- randomP 1.0 randomGen, not (x + y < 1)]

randomW2 randomGen = [[x,y,1] | (x,y) <- randomP 0.0 randomGen, not (x + y > 1)]

converged weight w1 w2 = all (==x) xs
	where 
		(x:xs) = train' weight w1 w2  

classify' weight x | dotp x weight > 0 = 1

classify' weight x | dotp x weight < 0 = 0

main = do 
	randomGen <- getStdGen
	let w1 = take 10000 (randomW1 randomGen)
	let w2 = take 10000 (randomW2 randomGen)
	let weight = train [0.0, 0.0, 1.0] (take 5000 w1) (take 5000 w2) 
	print weight
	print $ train weight w1 w2 
	let classify = classify' weight 
	print $ map classify (w2 ++ w1)      
	print $ sum (filter (==1) (map classify ((drop 5000 w2) ++ (drop 5000 w1))))