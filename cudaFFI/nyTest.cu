#include <stdio.h>

extern "C"
int example(int a, int b){
	return a + b;
}

extern "C"
void example2(int input){
	printf("%s%d\n", "hello ", input);
}

extern "C"
void gpuTest(void){
	int n = 10;
	int a[n], b[n], c[n];
	int *dev_a, *dev_b, *dev_c;

	cudaMalloc( (void**)&dev_a, n * sizeof(int) ); 
	cudaMalloc( (void**)&dev_b, n * sizeof(int) ); 
	cudaMalloc( (void**)&dev_c, n * sizeof(int) );

	for (int i=0; i<n; i++) { 
		a[i] = -i;
		b[i] = i * i; 
	}

	cudaMemcpy( dev_a, a, n * sizeof(int), cudaMemcpyHostToDevice );
	cudaMemcpy( dev_b, b, n * sizeof(int), cudaMemcpyHostToDevice );
    //add<<<n,1>>>( dev_a, dev_b, dev_c );
       // copy the array 'c' back from the GPU to the CPU
	cudaMemcpy( c, dev_c, n * sizeof(int), cudaMemcpyDeviceToHost );
       // display the results
	for (int i=0; i<n; i++) {
		printf( "%d + %d = %d\n", a[i], b[i], c[i] );
	}
       // free the memory allocated on the GPU
    cudaFree( dev_a );
    cudaFree( dev_b );
    cudaFree( dev_c );
}
/*
int main(){
	gpuTest();
	printf("hello");
}
*/