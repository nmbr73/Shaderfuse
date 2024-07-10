[README](../../../../../README.md) | [Setup](../../../../README.md) | **Repository Tools**

# Repository Tools

The 'Repository Tools' should appear in your DaFusion's scripts submenu and ar meant to be called by selecting them from that menu. Alternatively most of the exact same functionality can be performed from the command line by calling the corresponding script in `Tools/Scripts/`.


## Overview

'**All Fuses in this Repository (just an OVERVIEW)**' opens a window just showing a list of all the Shaderfuses in your local working copy. In particular useful to quickly identify Fuses that may still need some rework / compatibility testing.


## Installer

'**Create an INSTALLER script for every Fuse**'. Traverses your working copy for valid Fuses (valid means tested to compile at least on Windows and Mac) and creates an installer Lua file that can be used to install a particular Fuse via drag'n'drop on any other DaFusion installation.

You can cd into `Tools/Shell/` and call `lua generate_installer.lua` to perform the same functionality from the command line.


## Markdown

'**Refresh the Fuse overview MARKDOWN files**' does rewrite the OVERVIEW.md and all the README.md files in the `Shaders/` folder.

THIS DOES NOT WORK FROM WITHIN FUSION ANYMORE! AS IT DOES NOT WORK BY SIMPLY CALLING `generate_markdown.lua` AT THE MOMENT!

For the time being use `build.sh docs` instead.


## CVS

'**Update the Fuse overview CSV table**' rewrites the file `Shaders.csv` in your working copy.


## Atom

DOES CURRENTLY NOT WORK!!! 'Write ATOM and compile Fuses for publication on Reactor' copies all Fuses from `Shaders/` to the `Atom/com.JiPi.Shadertoys/Fuses/Shaderfuse_wsl/` folder. Target filenames are the original Fuses' Shadertoy.com IDs to avoid any issues for the end user who installed the shaders via Reactor in case a Fuse file is renamed or moved within the repository. In each Fuse the FU register code and the code for the Fuse's Inspector controls is replaced by the respective `Tools/Snippets/*.reactor.lua` snipped (see the 'Snippets' section in this document for further information on this). After executing this script via the DaFusions script menu, the `Atom` folder should be ready to be zipped and shipped as a Reactor publication suggestion in the WSL forum (which is in general done by [JiPi](../Site/Profiles/JiPi.md)).
