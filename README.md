# CygwinINDI

This repository is meant to support INDI on cygwin.  Installing INDI on cygwin will involve several steps.

1. Download this repository.
2. Download Cygwin 64 bit from here: https://cygwin.com/setup-x86_64.exe
3. Put setup-x86_64.exe in the same folder as the other files
4. Run install.bat by double clicking.
5. Double click the Shortcut to launch "Cygwin Terminal" and type buildINDI.sh from inside cygwin.

Please note this is a work in progress.

-Thank you very much to the Cygwin project https://cygwin.com for developing Cygwin
-Thank you very much to the INDI project for developing INDI: https://github.com/indilib/indi
-Thank you to "peenut" in this thread for providing the idea for the package installer install-pkg:
https://superuser.com/questions/40545/upgrading-and-installing-packages-through-the-cygwin-command-line/69113#69113
-And thank you to Will Rogers for sharing the automatic cygwin installation script that I based install.bat on. https://gist.github.com/wjrogers
