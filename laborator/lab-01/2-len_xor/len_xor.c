#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int my_strlen(const char *str)
{
	/* TODO */
	int i;
	for (i = 0; *(str + i); i++);
	return i;
}

void equality_check(const char *str)
{
	/* TODO */
	int i, poz, dim;
	dim = my_strlen(str);

	for (i = 0; i < dim; i++) {
		poz = (i + (1 << i)) % dim;
		if (!((*(str + i)) ^ (*(str + poz)))) {
			printf("Address of %c: %p\n", *(str + i), (void *) str + i);
		}
	}
}

int main(void)
{
	/* TODO: Test functions */
	char str[100];
	scanf("%s", str);
	printf("lenght = %d\n", my_strlen(str));
	equality_check(str);
	return 0;
}

