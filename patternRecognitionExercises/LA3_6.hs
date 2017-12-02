import Numeric.LinearAlgebra
import System.Random
import Data.Random.Normal
import Data.List
import Data.Function 
 
random' mean randomGen = zip x y 
	where				 
		x = normals' (mean, 0.2) randomGen :: [Float]
		y = normals' (mean, 0.2) randomGen :: [Float]

randomW1 randomGen = [fromList [x,y,1] | (x,y) <- random' 1.0 randomGen]

randomW2 randomGen = [fromList [x,y,1] | (x,y) <- random' 0.0 randomGen]

lms':: Vector Float ->[Vector Float] -> [Vector Float] -> [Vector Float]  
lms' w w1 w2 = scanl f w w1
			where 
				f w xt | xt `elem` w1 =  w + rho * xt * y1 - xt * w * rho * xt	
				f w xt | xt `elem` w2 =  w + rho * xt * y2 - xt * w * rho * xt 	
				rho = 0.01
				y1 = 1 
				y2 = -1

converged weight w1 w2 = all (==x) xs
	where 
		(x:xs) = lms' weight w1 w2 

lms w w1 w2 | converged w w1 w2 = w 

lms w w1 w2 | not (converged w w1 w2) = lms newW w1 w2 
	where 
		newW = last (lms' w w1 w2) 

main = do 
	randomGen <- getStdGen
	let w1 = take 100 (randomW1 randomGen)
	let w2 = take 100 (randomW2 randomGen)
	let weight1 = lms (fromList [0,0,1]) w1 w2
	print weight1
	--print weight2



	