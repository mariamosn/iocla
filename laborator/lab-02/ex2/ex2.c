#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char* delete_first(char *s, char *pattern) {
	char *p, *cp = strdup(s);
	p = strstr(cp, pattern);
	*p = '\0';
	strcat(cp, p + strlen(pattern));
	return cp;
}

int main(){
	char *s = "Ana are mere";
	char *pattern = "re";

	// Decomentati linia dupa ce ati implementat functia delete_first.
	printf("%s\n", delete_first(s, pattern));

	return 0;
}
