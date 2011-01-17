#include <stdlib.h>
#include <string.h>

struct jcm_struct
{
	int the_int;
	char the_char;
	float the_float;
	char the_buffer[16];
};

void jcm_do_nothing();
int jcm_return_int();
int jcm_process_int(int);
void jcm_access_pointer(int *);
int jcm_access_string(char *);
double jcm_process_doubles(double *);
void jcm_process_struct(struct jcm_struct *, int, char, float);
char *jcm_return_dynamic();
void jcm_free_dynamic(char *ptr);
