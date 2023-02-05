[![GitHub release](https://img.shields.io/github/v/release/nmbr73/Shaderfuse?include_prereleases)](https://github.com/nmbr73/Shaderfuse/releases/latest) [![License](https://img.shields.io/badge/license-various-critical)](LICENSE)


<center>
    <img src="Tools/Assets//GitHubLogo.png" alt="Shaderfuse" style="width:70%; " align="center" />
</center>


See the corresponding GitHub Pages on [nmbr73.github.io/Shaderfuse/](https://nmbr73.github.io/Shaderfuse/) to get an idea of what this is all about. Or watch some videos to see what you can do with it:

[![JiPi](https://img.shields.io/badge/-JiPi-ff0000?style=for-the-badge&logo=youtube)](https://youtu.be/oyndG0pLEQQ "WebGL to DCTL: Shadertoyparade") [![nmbr73](https://img.shields.io/badge/-nmbr73-ff0000?style=for-the-badge&logo=youtube)](https://youtu.be/GJz8Vgi8Qws "The Shader Cut")


This code is mainly based on the work of **Chris Ridings** and his *[Guide to Writing Fuses for Resolve/fusion](https://www.chrisridings.com/guide-to-writing-fuses-for-resolve-fusion-part-1/)* and the [FragmentShader.fuse](https://www.chrisridings.com/wp-content/uploads/2020/05/FragmentShader.fuse) from his *[Davinci Resolve Page Curl Transition](https://www.chrisridings.com/page-curl/)* article; **Bryan Ray**, who did a whole series of blog posts on *[OpenCL Fuses](http://www.bryanray.name/wordpress/opencl-fuses-index/)*; **JiPi**, who did an excellent post on how to *[Convert a Shadertoy WebGL Code to DCTL](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=17&t=4460)* accompanied by a (German) [DCTL Tutorial](https://youtu.be/dbrPWRldmbs) video. As an introduction and if you want to know more about shaders in general, a look into *[The Book of Shaders](https://thebookofshaders.com)* is highly recommended. Again the [We Suck Less](https://www.steakunderwater.com/wesuckless/index.php) forum is the place where you will find tons of information and all the experts. And last but not least are all these fuses based on work shared by those wonderful people on [Shadertoy.com](https://www.shadertoy.com/).



# Installation

[![Download ZIP](https://img.shields.io/badge/download-zip-blue)](https://nmbr73.github.io/Shaderfuse/Shaderfuse-Installers.zip "ZIP")

## Reactor

Best way to install the Fuses is to just use Reactor. Find the 'Shadertoys' package in the - guess what - 'Shaders' category. This is the most convenient and recommended way to if you just what to use them or have a quick look if they might be useful for you.

Only thing to take into account is that this way you don't get the latest development versions. Stable toys are bundled from time to time and integrated in Reactor when reviewed.

## Repository

Just clone the whole repository into a folder where it can reside. Drag'n'drop the `Tools/Setup.lua` onto your DaFusions working area. Select *'Use Fuses under Shaders straight out of the repository'*. Save this setting and restart the application. See the [Tools/README.md](Tools/README.md) for further information.

This is the installation method recommended if you want to have with a single `git pull` all the latest development versions at hand. And in particular it is the way to go if you want to work on the code and contribute to the repository yourself.

<!--
## ZIP-File

Find on [GitHub Pages](https://nmbr73.github.io/Shaderfuse/) the Links to download the full `.tar.gz` or `.zip` archive. After unpacking you can copy the whole `Shaders/` folder into your `Fuses` directory or pick and choose only single `.fuse` files you want to keep.
-->

<!--
## Fuse-Installers

For this method you must have cloned the repository or downloaded and unpacked the ZIP file. You can then drag'n'drop the `*-Installer.lua` files (which you find in `Shaders/` folder's subdirectories of the repo or the ZIP archive) into your Fusion working area to copy the corresponding fuse into the appropriate path. These Installers are currently under construction and not available for all fuses.

These installers are more meant to quickly try a single fuse or to share it via email, discord, etc.
-->

<!--
### Installer

Alternatively you can also use the installer of the v0.1-alpha.1 release: drag'n'drop the `Shaderfuse_Installer.lua` onto you Fusion working area, perform the installation and restart DaVinci Resolve.
-->

<!--
[![Download](img_download.png)](https://github.com/nmbr73/Shaderfuse/releases/download/v0.1-alpha.1/Shaderfuse_Installer.lua)
-->

<!--
[![Download](https://img.shields.io/badge/-download-60a0ff?style=for-the-badge&logo=github)](https://github.com/nmbr73/Shaderfuse/releases/download/v0.1-alpha.1/Shaderfuse_Installer.lua "Installer")
-->



# MkDocs local build

```bash
cd Shaderfuse
chmod +x ./build.sh
python3 -m venv venv
source venv/bin/activate
pip install mkdocs-material
pip install mkdocs-callouts
pip install mkdocs-awesome-pages-plugin
```



# Contribute

[![Discord](https://img.shields.io/discord/793508729785155594?label=discord)](https://discord.gg/Zb48E4z3Pg) [![GitHub Watchers](https://img.shields.io/github/watchers/nmbr73/Shaderfuse?style=social)](https://github.com/nmbr73/Shaderfuse) [![GitHub Stars](https://img.shields.io/github/stars/nmbr73/Shaderfuse?style=social)](https://github.com/nmbr73/Shaderfuse) [![GitHub Forks](https://img.shields.io/github/forks/nmbr73/Shaderfuse?style=social)](https://github.com/nmbr73/Shaderfuse)

<!--
[![Discord](https://img.shields.io/badge/-discord-e0e0e0?style=for-the-badge&logo=discord)](https://discord.gg/Zb48E4z3Pg "PlugIn Discord")
-->
<!-- regrettably the iframe works on github pages bit not on github :-/ ...  iframe src="https://discord.com/widget?id=793508729785155594&theme=dark" width="350" height="500" allowtransparency="true" frameborder="0" sandbox="allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts"></iframe -->

Just fork this repository, have fun and send your pull requests. See also the [Wiki](https://github.com/nmbr73/Shaderfuse/wiki) (under construction) for some more details on how to port GLSL to DCTL. For further information meet us on the DaVinci Resolve Plug-in Developers Discord server.
