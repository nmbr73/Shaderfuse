[README](../../../../../README.md) | [Setup](../../../../README.md) | **Repository Tools**

# Repository Tools

The 'Repository Tools' should be linked into your DaFusion's scripts submenu and ar meant to be called by selecting them from that manu (so no drag'n'drop or whatsoever). Alternatively they can be called from the command line.

## Overview

'All Fuses in this Repository (just an OVERVIEW)' opens a window just showing a list of all the Shadertoy Fuses in your local working copy. In particular useful to quickly identify Fuses that may still need some rework.


## Installer

'Create an INSTALLER script for every Fuse' DOES NOT WORK YET! DOES NOTHING FOR THE TIME BEING!


## Markdown

'Refresh the Fuse overview MARKDOWN files' does rewrite the OVERVIEW.md and all the README.md files in the `Shaders/` folder.

...

## CVS

...


## Atom

DOES CURRENTLY NOT WORK!!! 'Write ATOM and compile Fuses for publication on Reactor' copies all Fuses from `Shaders/` to the `Atom/com.JiPi.Shadertoys/Fuses/Shaderfuse_wsl/` folder. Target filenames are the original Fuses' Shadertoy.com IDs to avoid any issues for the end user who installed the shaders via Reactor in case a Fuse file is renamed or moved within the repository. In each Fuse the FU register code and the code for the Fuse's Inspector controls is replaced by the respective `Tools/Snippets/*.reactor.lua` snipped (see the 'Snippets' section in this document for further information on this). After executing this script via the DaFusions script menu, the `Atom` folder should be ready to be zipped and shipped as a Reactor publication suggestion in the WSL forum (which is in general done by [JiPi](../Site/Profiles/JiPi.md)).
