#include <stdio.h>
#include <stdlib.h>

void print_binary(int number, int nr_bits)
{
	/* TODO */
	int rest[nr_bits], i;
	for (i = nr_bits - 1; i >= 0; i--) {
		rest[i] = number & 1;
		number = number / 2;
	}
	printf("0b");
	for (i = 0; i < nr_bits; i++) {
		printf("%d", rest[i]);
	}
	printf("\n");
}

void check_parity(int *numbers, int n)
{
	/* TODO */
	int i;
	for (i = 0; i < n; i++) {
		if (numbers[i] & 1) {
			printf("0x%.8x\n", numbers[i]);
		} else {
			print_binary(numbers[i], 8);
		}
	}
}

int main()
{
	/* TODO: Test functions */
	int numbers[100], n, i;
	scanf("%d", &n);
	for (i = 0; i < n; i++) {
		scanf("%d", &numbers[i]);
	}
	check_parity(numbers, n);
	return 0;
}

