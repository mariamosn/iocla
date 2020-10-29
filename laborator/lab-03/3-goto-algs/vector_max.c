#include <stdio.h>

void main(void)
{
	int v[] = {4, 1, 2, -17, 15, 22, 6, 2};
	int max;
	int i;

	/* TODO: Implement finding the maximum value in the vector */
	i = 0;

forlabel:
	if (i >= sizeof(v) / sizeof(v[0])) {
		goto endforlabel;
	}
	if (i == 0 || max < v[i]) {
		max = v[i];
	}
	i++;
	goto forlabel;

endforlabel:
	printf("max = %d\n", max);
}
