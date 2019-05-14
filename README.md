# MFPowershellToys

This is a collection of utility functions I've written for various personal usage in jobs over the years. Some are more useful than others.

This is largely for personal practice. Any updates can and will be completely random unless there's a major bug.

Long term goal is to fill this out with enhancements to repetitive tasks to improve speed of deployments or ticket fixing.

## v 1.0.0 goals

I do intend to connect this to a build project and have it automatically compile after running tests, just like the bigger modules do. Until this, consider everything in this repository in alpha status.

## TODO

### Conemu Tools

Sadly this is probably going to be removed long term. With the announcement of Windows Terminal and my own migration away from using ConEmu, this is just a handy script that is largely irrelevant now.

### MSI/EXE tools

I'm looking to expand usages here and improving the overall experience. Goal is to make any tools here usable by helpdesk/sysadmins and make things easy to use.
I may end up writing a packaging utility to connect installers with PSD1 files that contain details on how to install things, so that those can be passed in instead of arguments.
Not trying to replace Chocolatey or other package managers, but more trying to enable rapid remote installs using only powershell.