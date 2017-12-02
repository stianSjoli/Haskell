import Numeric.LinearAlgebra

distance mu x = (trans (x-mu)) <> (inv coVarMatrix) <> (x-mu)
	where 
		coVarMatrix = (2><2)  [var, std, std, var] :: Matrix Double
		var = 0.2
		std = sqrt var 

distanceW1 = distance $ (2><1) [1.0, 1.0]
distanceW2 = distance $ (2><1) [1.5, 1.5]

main = do 
	let x = (2><1) [1.0, 2.2] :: Matrix Double
	print (distanceW1 x) --I would classify x to w1 class 
	print (distanceW2 x)
