#include <stdio.h>
#include <malloc.h>

void print_array(int *vals, int size) {
	for (int i = 0; i < size; ++i) {
		printf("%d ", *vals++);
	}
}

int insert_A_and_count_B_size(int *vals, int size, int divider) {
	int answer = 0;
	for (int i = 0; i < size; ++i) {
		scanf("%d", vals);
		if (*vals++ % divider == 0) {
			answer++;	
		}
	}
	return answer;
}

void fill_B(int *A, int *B, int size_A, int divider) {
	for (int i = 0; i < size_A; ++i) {
		if (*A % divider == 0) {
			*B++ = *A;
		}
		A++;
	}
}

int main() {
        int n, divider;
        scanf("%d %d", &n, &divider);
        int* array = malloc(n * sizeof(int));
        int result_array_len = insert_A_and_count_B_size(array, n, divider);
        int* result_array = malloc(result_array_len * sizeof(int));
	fill_B(array, result_array, n, divider);
	print_array(result_array, result_array_len);
        free(array);
        free(result_array);
}
