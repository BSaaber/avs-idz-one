#include <stdio.h>
#include <malloc.h>
 
int main() {
        int n, divider;
        scanf("%d %d", &n, &divider);
        int* array = malloc(n * sizeof(int));
        int* temp = array;
        int result_array_len = 0;
        for (int i = 0; i < n; ++i) {
                scanf("%d", temp);
                if (*temp++ % divider == 0) {
                        result_array_len++;
                }
 
        }
        int* result_array = malloc(result_array_len * sizeof(int));
        temp = array;
        int* result_temp = result_array;
        for (int i = 0; i < n; ++i) {
                if (*temp % divider == 0) {
                        *result_temp++ = *temp;
                }
                temp++;
        }
        result_temp = result_array;
        for (int i = 0; i < result_array_len; ++i) {
                printf("%d ", *result_temp++);
        }
        free(array);
        free(result_array);
}
