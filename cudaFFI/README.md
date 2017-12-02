# cudaFFITest
just some some test code to test cud and the FFI haskell interface 

nvcc -c nyTest.cu
ghc simpleFFI.hs -o simpleFFI nyTest.o -L/usr/local/cuda/lib -optl-lcudart


