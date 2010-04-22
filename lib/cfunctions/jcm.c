/* Implementations */

#include "jcm.h"

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

void jcm_process_struct(struct jcm_struct *s,
						int an_int,
						char a_char,
						float a_float)
{
	s->the_int = an_int;
	s->the_char = a_char;
	s->the_float = a_float;
}

char *jcm_return_dynamic()
{
	char *my_ptr;
	my_ptr = (char *)malloc(4);

	*my_ptr = 'X';

	return my_ptr;
}

void jcm_free_dynamic(char *ptr)
{
	*ptr = 0;
	free(ptr);
}
