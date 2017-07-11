<div align="center">

# Bash-Snippets Extras

</div>

## Why are these here?

If there is a tool in this folder that means it is not part of the main installer pipeline

It was removed or never made it to the pipeline only for two possible reasons:
* It is platform dependent meaning it doesn't work the same on all \*nix machines
* It had many dependencies that aren't native to all forms of \*nix

## Can I install these & is it safe
Yes you can install these, only tools that are considered to be fully functional will make it here. Just make sure you only install extras for the correct platform and if they require dependencies make sure to install them (although the tool itself should remind you of this)

## Install
To install the tool just ```cd``` into the folder of the tool and run ```cp toolNameGoesHere /usr/local/bin || echo "Run the install as sudo" ```

## Uninstall
To uninstall the tool just run ```rm -f /usr/local/bin/toolNameGoesHere || echo "Run the uninstall as sudo" ```. Notice that the recursive flag is not set so even if you accidentally go to remove ```/usr/local/bin``` the flags will not let you delete the directory.

## Platform Specific Tools

### Linux

#### Maps
* Provides driving directions from a certain location to another
* Generates a route map of the trip and displays it
* Generates maps of the from and to locations and displays them
* The map functions require imagemagick to be installed

### OSX
None for now

## Dependent tools
None for now

## License
MIT License

Copyright (c) 2017 Alex Epstein

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
