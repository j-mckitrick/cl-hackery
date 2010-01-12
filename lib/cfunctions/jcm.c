/* Implementations */

#include "jcm.h"
#include <string.h>

void jcm_do_nothing()
{
}

int jcm_return_int()
{
	return 0xf;
}

int jcm_process_int(int i)
{
	return i * i;
}

void jcm_access_pointer(int *i)
{
	*i = 42;
}

int jcm_access_string(char *s)
{
	int i = strlen(s);
	int c = i / 2;
	if (c >= 0)
		s[c] = 'X';

	return 0;
}

double jcm_process_doubles(double *d)
{
	double e = *d * 2.14;
	*d *= 3.14;

	return e;
}
