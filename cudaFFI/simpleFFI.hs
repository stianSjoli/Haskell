{-# LANGUAGE ForeignFunctionInterface #-}

import Foreign.C.Types

foreign import ccall safe "example" example
    :: CInt -> CInt -> CInt
foreign import ccall unsafe "example2" example2
    :: CInt->IO()
foreign import ccall unsafe "gpuTest" gpuTest
    :: IO()
main = do 
		example2 (example 42 27)
		gpuTest --(example 42 27) >>= print