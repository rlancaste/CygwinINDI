# CygwinINDI

This repository is meant to support INDI on cygwin.  Installing INDI on cygwin will involve several steps.

1. Download this repository.
2. Download Cygwin 64 bit from here: https://cygwin.com/setup-x86_64.exe
3. Put setup-x86_64.exe in the same folder as the other files
4. Run install.bat by double clicking.
5. Double click the Shortcut to launch "Cygwin Terminal" and type buildINDI.sh from inside cygwin.
6. Answer the prompts as the program runs.  Please note, libnova is REQUIRED for INDI.
7. Once it finishes, INDI can be run from the "Cygwin Terminal" in the normal manner.  You can also use the included link to start the Simulators.

The Shortcut to start the indiserver simulators is this command:
C:\cygwin64\bin\mintty.exe -h always /bin/bash -l -c "/usr/bin/indiserver.exe ./indi_simulator_telescope ./indi_simulator_ccd ./indi_simulator_focus"

The Shortcut to start the Cygwin Terminal is this command:
C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico -

Please note this is a work in progress.

-Thank you very much to the Cygwin project https://cygwin.com for developing Cygwin
-Thank you very much to the INDI project for developing INDI: https://github.com/indilib/indi
-Thank you to "peenut" in this thread for providing the idea for the package installer install-pkg:
https://superuser.com/questions/40545/upgrading-and-installing-packages-through-the-cygwin-command-line/69113#69113
-And thank you to Will Rogers for sharing the automatic cygwin installation script that I based install.bat on. https://gist.github.com/wjrogers
