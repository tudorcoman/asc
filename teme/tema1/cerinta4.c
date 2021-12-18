
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int v[10001], vv[10001];
char input[11001];

int main() {
    gets(input);
    
    char *p = strtok(input, " ");
    
    p = strtok(NULL, " "); // ajungem la nr_linii

    int nr_lin = atoi(p);
    p = strtok(NULL, " ");

    int nr_col = atoi(p);
    p = strtok(NULL, " ");

    int i, j;
    i = j = 0;
    while (strcmp(p, "let")) {
	v[nr_col * i + j] = atoi(p);
        j ++;
        if (j == nr_col) {
	    j = 0; i ++;
        }
	p = strtok(NULL, " ");
    }

    p = strtok(NULL, " "); // sarim peste let

    if(strcmp(p, "rot90d")) {
	p  = strtok(NULL, " "); // sarim peste numele variabilei;
    	// nu avem rotire;
	int op = atoi(p); 
	p = strtok(NULL, " ");
	if (strcmp(p, "add") == 0) {
	    for (int i = 0; i < nr_lin * nr_col; i ++)
	        v[i] += op;
	} else if (strcmp(p, "sub") == 0) {
	    for (int i = 0; i < nr_lin * nr_col; i ++)
		v[i] -= op;
	} else if (strcmp(p, "mul") == 0) {
	    for (int i = 0; i < nr_lin * nr_col; i ++)
		v[i] *= op;
	} else {
	    for (int i = 0; i < nr_lin * nr_col; i ++)
		v[i] /= op;
	}
	printf("%d %d ", nr_lin, nr_col);
	for (int i = 0; i < nr_lin; i ++)
		for (int j = 0; j < nr_col; j ++)
			printf("%d ", v[i * nr_col + j]);
    } else {
       for (int i = 0; i < nr_col; i ++)
           for (int j = 1; j <= nr_lin; j ++)
	       vv[i * nr_lin + j - 1] = v[(nr_lin - j) * nr_col + i];
       
       printf("%d %d ", nr_col, nr_lin);
       for (int i = 0; i < nr_col; i ++)
           for (int j = 0; j < nr_lin; j ++)
	       printf("%d ", vv[i * nr_lin + j]); 
    }
    return 0;    
}
