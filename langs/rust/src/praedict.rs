use std::path;
use std::process::Command;


pub struct Praedict {
    input_file:     path::PathBuf,
    output_binary:  path::PathBuf,

    stdout_compile: String,
    stderr_compile: String,
    stdout_runtime: String,
    stderr_runtime: String,

}

impl Praedict {

    pub fn new() -> Praedict {
        return Praedict {
            input_file: path::PathBuf::from("./snippet/snippet.rs"),
            output_binary: path::PathBuf::from("./snippet/dist/praedict.bin"),

            stdout_compile: String::from(""),
            stderr_compile: String::from(""),
            stdout_runtime: String::from(""),
            stderr_runtime: String::from(""),
        }
    }

    pub fn echo() {
        println!("echo!");
        // let x: String = String::from("asdfasdf");
    }

    pub fn compile(&mut self) {


        let compile = Command::new("rustc")
        .arg(self.input_file.clone())
        .arg("-o")
        .arg(self.output_binary.clone())
        .output()
        .expect("Failed to execute command");

        println!("DEBUG: {:?}", compile.status);
        

        self.stdout_compile = String::from_utf8_lossy(&compile.stdout).to_string();
        self.stderr_compile = String::from_utf8_lossy(&compile.stderr).to_string();

    }

    pub fn run(&mut self) {

        // Make sure file exists
        let file_location = std::path::PathBuf::from(self.output_binary.clone());
        if !file_location.is_file() {
            return;
        }

        let runtime = Command::new(self.output_binary.clone())
        .arg("")
        .output()
        .expect("Failed to execute command");

        self.stdout_runtime = String::from_utf8_lossy(&runtime.stdout).to_string();
        self.stderr_runtime = String::from_utf8_lossy(&runtime.stderr).to_string();
        
    }   

    pub fn cleanup(&mut self){
        
        Command::new("rm")
        .arg("./snippet/dist/praedict.bin")
        .output()
        .expect("Failed to execute command");
    }


    pub fn print(&self) {
        println!("// stdout compile");
        println!("{}", self.stdout_compile);
        println!("// stderr compile");
        println!("{}", self.stderr_compile);
        println!("// stdout runtime");
        println!("{}", self.stdout_runtime);
        println!("// stderr runtime");
        println!("{}", self.stderr_runtime);
        println!("// end praedict");
    }

}