[Setup](../../../../README.md) | **Repository Tools** | [Snipptes](../../../../Snippets/README.md)

# Repository Tools

The 'Repository Tools' should be linked into your DaFusion's scripts submenu and ar meant to be called by selecting them from that many (so no drag'n'drop or whatsoever).

## Overview

'All Fuses in this Repository (just an OVERVIEW)' opens a window just showing a list of all the Shadertoy Fuses in your local working copy.


## Installer

'Create an INSTALLER script for every Fuse' DOES NOT WORK YET! DOES NOTHING FOR THE TIME BEING!


## Markdown

'Refresh the Fuse overview MARKDOWN files' does rewrite the OVERVIEW.md and all the README.md files in the `Shaders/` folder.

...

## Boilerplate

'Update Fuses with current BOILERPLATE Code' goes through all Fuses under `Shaders/` and replaces the FUREGISTERCLASS and the SHADERFUSECONTROLS code with the code blocks found in `Tools/Snippets/FUREGISTERCLASS.development.lua` resp. `Tools/Snippets/SHADERFUSECONTROLS.development.lua`. To do so it searches for some magic "SCHNIPP"/"SCHNAPP" markers - it's important that the code snippets themselves again include these markers so that the action can be redone (in the particular case of the `*.reactor.lua` code replacement these markers don't have to be maintained as the generation of the atom package is alway performed on the source Fuses but not repeated on the target files).

**TODO:** This menu item has no user interface yet. It would be nice to show a yes/no dialog explaining the functionality and to show the results in an info dialog afterwards (currently you have to look into the console window to see if something happened).


## Atom

'Write ATOM and compile Fuses for publication on Reactor' copies all Fuses from `Shaders/` to the `Atom/com.JiPi.Shadertoys/Fuses/Shaderfuse_wsl/` folder. Target filenames are the original Fuses' Shadertoy.com IDs to avoid any issues for the end user who installed the shaders via Reactor in case a Fuse file is renamed or moved within the repository. In each Fuse the FU register code and the code for the Fuse's Inspector controls is replaced by the respective `Tools/Snippets/*.reactor.lua` snipped (see the 'Snippets' section in this document for further information on this). After executing this script via the DaFusions script menu, the `Atom` folder should be ready to be zipped and shipped as a Reactor publication suggestion in the WSL forum (which is in general done by [JiPi](../Site/Profiles/JiPi.md)).
