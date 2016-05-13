#include <stdio.h>

int main(void){
	char input;
	input=getchar();
	while (input != EOF && input != '\n'){
		printf("%x ", input);
		input=getchar();
	}
	printf("\n");
	return 0;
}
