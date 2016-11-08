# GUI_Test

This project provides a native (Linux/Windows) version of the user interface.
It allows for quick development of the UI by avoiding slow board flashing
procedure.

## Requirements

To compile this project, you will need to install GNAT with the GTKada library:
http://libre.adacore.com/download/configurations

## Build

`$ gprbuild -P GUI_test.gpr`

## Run

`$ ./gui_test`
