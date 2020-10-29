#include <stdio.h>

/**
 * Afisati adresele elementelor din vectorul "v" impreuna cu valorile
 * de la acestea.
 * Parcurgeti adresele, pe rand, din octet in octet,
 * din 2 in 2 octeti si apoi din 4 in 4.
 */

int main() {
    int v[] = {0xCAFEBABE, 0xDEADBEEF, 0x0B00B135, 0xBAADF00D, 0xDEADC0DE};
	int n = sizeof(v) / sizeof(*v);
	int *final = v + n - 1;
    printf("Din octet in octet\n");
    char *p1;
    for (p1 = (char *) &v; (void *) p1 <= (void *) final; p1++) {
    	printf("%p -> 0x%x\n", p1, *p1);
    }

    printf("\nDin doi octeti in doi octeti\n");
    short *p2;
    for (p2 = (short *) &v; (void *) p2 <= (void *) final; p2++) {
    	printf("%p -> 0x%x\n", p2, *p2);
    }

    printf("\nDin patru octeti in patru octeti\n");
    int *p3;
    for (p3 = (int *) &v; (void *) p3 <= (void *) final; p3++) {
    	printf("%p -> 0x%x\n", p3, *p3);
    }

    return 0;
}
