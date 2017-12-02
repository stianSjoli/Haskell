import Graphics.EasyPlot
import Data.List
import Data.Function 

w1::[[Float]]

w2::[[Float]]

dotp::[Float]->[Float]-> Float

train::[Float]->[Float]

train':: [Float] -> [[Float]]

converged::[Float] -> Bool

classify::[Float] -> Int

w1 = [[0.0, 1.0, 1.0],[0.0, 0.0,1.0]]

w2 = [[1.0, 1.0,1.0],[1.0, 0.0,1.0]]

dotp xs ys = foldl (+) 0 (zipWith (*) xs ys)

train' w = scanl f w set
			where 
				f w xt | xt `elem` w1 && (dotp xt w <= 0) = zipWith (+) w (map (*rho) xt)	
				f w xt | xt `elem` w2 && (dotp xt w >= 0) = zipWith (-) w (map (*rho) xt)	
				f w xt = w
				rho = 1
				set = w2 ++ w1 

train w | not (converged w) = train newW
	where 
		newW = last (train' w) 

train w | converged w = w

converged weight = all (==x) xs
	where 
		(x:xs) = train' weight  

classify' weight x | dotp x weight > 0 = 1

classify' weight x | dotp x weight < 0 = 0

classify = classify' (train [0.0,0.0,1.0])
   
main = print $ map classify (w2 ++ w1) 







