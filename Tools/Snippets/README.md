[Setup](../README.md)  | [Repository Tools](../Scripts/Comp/Shadertoys/Repository%20Tools/README.md) | **Snipptes**

Each Fuse contains a block of code to register the component with DaFusion - this block determines the Fuse's name, it shows an edit and a reload button for development purposes, etc. The `Tools/Snippets/FUREGISTERCLASS.development.lua` file contains that code block for all the Fuses under `Shaders/`. The `Tools/Snippets/FUREGISTERCLASS.reactor.lua` contains that exact block for Fuses that are supposed to be published to the WSL Reactor.

Each Fuse contains some information that is displayed in the Inspector. That is e.g., a link to the web page containing further information, the original name and author, etc. The `Tools/Snippets/SHADERFUSECONTROLS.*.lua` files contain the respective code block variants for the Fuses in the repository (`Shaders/`) as `*.development.lua` and those in case the Fuses are bundled for Reactor (`Atom/`) as `*.reactor.lua`.

Calling the 'Update Fuses with current BOILERPLATE Code' menu item in the 'Repository Tools' submenu scans all Fuses under `Shaders/` and replaces the respective code blocks with those from the `*.development.lua` snippet files.

When generating the Reactor package by calling 'Write ATOM and compile Fuses for publication on Reactor' the script uses the `*.reactor.lua` snippets when writing the Fuses into the `Atom/` folder.

Long story short: this way we have some consistent registration and information for each Fuse that, if needed, can be changed for all Fuses by simply editing the corresponding 'snippets'.
