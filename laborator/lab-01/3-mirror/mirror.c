#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void mirror(char *s)
{
	/* TODO */
	int dim = strlen(s);
	int i;
	char aux;
	for (i = 0; i < dim / 2; i++) {
		aux = *(s + i);
		*(s + i) = *(s + dim - 1 - i);
		*(s + dim - 1 - i) = aux;
	}
}

int main()
{
	/* TODO: Test function */
	char str[100];
	scanf("%s", str);
	mirror(str);
	printf("%s\n", str);
	return 0;
}

