use std::vec::Vec;
use std::env;
fn main(){
	/*
		You know, this is probably the worst possible way to do this.
	*/
	let mut signals = Vec::new();
	signals.push("No signal 0.");
	signals.push("SIGHUP: Hang up. User's terminal has disconnected; Termination of controlling process; Sometimes used as a signal to reload config files (esp. Apache).");
	signals.push("SIGINT: Interrupt. Ctrl-C; User has requested the program be interrupted.");
	signals.push("SIGQUIT: Quit. Terminate process and generate core dump.");
	signals.push("SIGILL: Illegal Instruction. Executable file is corrupted; Attempt to execute data as instructions.");
	signals.push("SIGTRAP: Trace Trap/Exception. An exception or other condition that a debugger has requested to know about has occurred");
	signals.push("SIGABRT/SIGIOT: Abort. Terminate immediately and generate core dump; Usually initiated by itself with the abort() function.");
	signals.push("SIGBUS: Bus Error. Often incorrect memory address alignment or non-existent physical address.");
	signals.push("SIGFPE: Floating Point Error. Erroneous arithmetic operation, e.g. division by zero.");
	signals.push("SIGKILL: Unblockable Kill. Immediate program termination. Cannot be blocked or caught.");
	signals.push("SIGUSR1: User defined signal.");
	signals.push("SIGSEGV: Segmentation Fault. Bad memory access - outside valid range, null pointer, etc.");
	signals.push("SIGUSR2: User defined signal.");
	signals.push("SIGPIPE: Broken Pipe. Socket not connected; Unix pipe error, etc.");
	signals.push("SIGALRM: Alarm Clock. A timer has expired. This signal is used by the alarm() function.");
	signals.push("SIGTERM: Terminate gracefully. Terminate signal that can be blocked, handled, or ignored.");
	signals.push("SIGSTKFLT: Stack Fault.");
	signals.push("SIGCHLD: Child status has changed. Sent to parent process when child process is terminated or stops.");
	signals.push("SIGCONT: Continue. Usually after SIGINT: Interrupt.");
	signals.push("SIGSTOP: Unblockable Stop. Immediately stop program execution.");
	let errmsg = "You didn't give me a valid signal number!";
	let num : usize = env::args().nth(1)
		.expect(errmsg)
		.parse::<usize>()
		.expect(errmsg);
	match signals.get(num) {
		Some(x) => println!("Signal {}, {}", num, x),
		None => println!("{}", errmsg)
	}
	
	

}
