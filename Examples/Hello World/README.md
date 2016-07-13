# Terminal - Hello World

This small example will create a command line tool that will print `Hello World` into the console when executed with the `hello` command.

### Build
Make sure that Swift 3.0 or later is accessable via command line. Navigate into the `Hello World` folder and execute: 
```bash
~ > swift build
```
This will check out the specified version of `Terminal` and build an executable at `./build/debug/`. The command line tool can now be run like:
```bash
~ > ./build/debug/say hello
```
