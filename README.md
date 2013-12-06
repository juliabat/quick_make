Script of quickly compiling c-files to one program. The script links the object files of all c files in the current directory to one program (which is specified as an
command line argument). If an object file does not exist yet or is  older than its corresponding cfile, gcc creates the
object file. 

Usage: "./quickmake.sh name-of-program"
