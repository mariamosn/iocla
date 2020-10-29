#include <stdio.h>

void main(void)
{
	int v[] =  {1, 2, 15, 51, 53, 66, 202, 7000};
	int dest = v[2]; /* 15 */
	int start = 0;
	int end = sizeof(v) / sizeof(int) - 1;

	/* TODO: Implement binary search */
	int poz;

whilelabel:
	poz = (start + end) / 2;
	if (v[poz] == dest) {
		goto found;
	}
	if (v[poz] < dest) {
		start = poz;
		goto whilelabel;
	}
	end = poz;
	goto whilelabel;

found:
	printf("Pozitia valorii %d este %d.\n", dest, poz);
}
