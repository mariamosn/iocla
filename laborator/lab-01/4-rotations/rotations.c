#include <stdio.h>

void simple_left(int *number) {
	int n = *number;
	int cut = n & (1 << 31);
	n = n << 1;
	if (cut) {
		n ++;
	}
	*number = n;
}

void rotate_left(int *number, int bits)
{
	/* TODO */
	int n = *number, cut, new;
	cut = n >> (32 - bits);
	if (cut < 0) {
		cut = -cut;
	}
	new = n << bits;
	*number = new + cut;
}

void rotate_right(int *number, int bits)
{
	/* TODO */
	int n = *number, cut, new;
	cut = n << (32 - bits);
	new = n >> bits;
	*number = new + cut;
}

int main()
{
	/* TODO: Test functions */
	int number = 0x00000001, bits = 16;
	rotate_right(&number, bits);
	printf("%d\n", number);
	return 0;
}

