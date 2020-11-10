#include <unistd.h>
#include <stdarg.h>
#include <string.h>

// TYPE_MAX_LENGTH reprezintă lungimea maximă a unui șir de caractere ce
// reprezintă valoarea de tip TYPE + 1 (pentru '\0')
#define INT_MAX_LENGTH 12
#define UNSIGNED_MAX_LENGTH 11
#define HEXA_MAX_LENGTH 9

#define INT_NEGATIVE_LIMIT -2147483648
#define UNSIGNED_LIMIT 4294967295

static int write_stdout(const char *token, int length)
{
	int rc;
	int bytes_written = 0;

	do {
		rc = write(1, token + bytes_written, length - bytes_written);
		if (rc < 0)
			return rc;

		bytes_written += rc;
	} while (bytes_written < length);

	return bytes_written;
}

void int_to_string(int d, char *out) {
	int v[INT_MAX_LENGTH], size = 0, i, start = 0, flag = 0;
	if (d == INT_NEGATIVE_LIMIT) {
		d++;
		flag = 1;
	}
	if (d < 0) {
		d *= -1;
		out[0] = '-';
		start = 1;
	}
	while (d) {
		v[size++] = d % 10;
		d /= 10;
	}
	if (start == 1) {
		size++;
	}
	for (i = start; i < size; i++) {
		out[i] = v[size - 1 - i] + '0';
	}
	if (flag) {
		out[i - 1]++;
	}
	out[i] = '\0';
}

void unsigned_to_string(unsigned int u, char *out) {
	int v[UNSIGNED_MAX_LENGTH], size = 0, i;
	while (u) {
		v[size++] = u % 10;
		u /= 10;
	}
	for (i = 0; i < size; i++) {
		out[i] = v[size - 1 - i] + '0';
	}
	out[size] = '\0';
}

void int_to_hex_string(int x, char *out) {
	int v[HEXA_MAX_LENGTH], size = 0, i;
	unsigned aux;
	/*if (x >= 0) {
		aux = x;
	} else {
		aux = -x;
		aux = ~aux;
		if (aux == UNSIGNED_LIMIT) {
			aux = 0;
		} else {
			aux++;
		}
	}*/
	aux = x;
	while (aux) {
		v[size++] = aux % 16;
		aux /= 16;
	}
	for (i = 0; i < size; i++) {
		out[i] = v[size - 1 - i];
		if (out[i] >= 10) {
			out[i] = out[i] - 10 + 'a';
		} else {
			out[i] += '0';
		}
	}
	out[size] = '\0';
}

int iocla_printf(const char *format, ...)
{
	/* TODO */
	int i = 0, cnt = 0;
	va_list args;
	va_start(args, format);

	while (format[i]) {
		if (format[i] != '%') {
			write_stdout(format + i, 1);
			cnt++;
		} else {			
			i++;
			if (format[i] == 'd') {
				int d = va_arg(args, int);
				char out[INT_MAX_LENGTH];
				int_to_string(d, out);
				write_stdout(out, strlen(out));
				cnt += strlen(out);
			} else if (format[i] == 'u') {
				unsigned int u = va_arg(args, unsigned int);
				char out[UNSIGNED_MAX_LENGTH];
				unsigned_to_string(u, out);
				write_stdout(out, strlen(out));
				cnt += strlen(out);
			} else if (format[i] == 'x') {
				int x = va_arg(args, int);
				char out[HEXA_MAX_LENGTH];
				int_to_hex_string(x, out);
				write_stdout(out, strlen(out));
				cnt += strlen(out);
			} else if (format[i] == 'c') {
				char c = va_arg(args, int);
				write_stdout(&c, 1);
				cnt++;
			} else if (format[i] == 's') {
				char *s = va_arg(args, char *);
				write_stdout(s, strlen(s));
				cnt += strlen(s);
			} else {
				write_stdout("%", 1);
				cnt++;
				if (format[i] != '%') {
					i--;
				}
			}
		}
		i++;
	}
	va_end(args);
	return cnt;
}
