**README**  | [Setup](Tools/README.md) | [Repository Tools](Tools/Scripts/Comp/Shaderfuse/Repository%20Tools/README.md)

[![GitHub release](https://img.shields.io/github/v/release/nmbr73/Shaderfuse?include_prereleases)](https://github.com/nmbr73/Shaderfuse/releases/latest) [![License](https://img.shields.io/badge/license-various-critical)](LICENSE) [![Discord](https://img.shields.io/discord/793508729785155594?label=discord)](https://discord.gg/Zb48E4z3Pg)


<center>
    <img src="Tools/Assets//GitHubLogo.png" alt="Shaderfuse" style="width:70%; " align="center" />
</center>


See the corresponding GitHub Pages on [nmbr73.github.io/Shaderfuse/](https://nmbr73.github.io/Shaderfuse/) to get an idea of what this is all about. See [Shaders.csv](https://github.com/nmbr73/Shaderfuse/blob/gh-pages/Shaders.csv) for a list of shaders converted so far.

<!-- Or watch some videos to see what you can do with it:
[![JiPi](https://img.shields.io/badge/-JiPi-ff0000?style=for-the-badge&logo=youtube)](https://youtu.be/oyndG0pLEQQ "WebGL to DCTL: Shadertoyparade") [![nmbr73](https://img.shields.io/badge/-nmbr73-ff0000?style=for-the-badge&logo=youtube)](https://youtu.be/GJz8Vgi8Qws "The Shader Cut")
-->

This code is mainly based on the work of **Chris Ridings** and his *[Guide to Writing Fuses for Resolve/fusion](https://www.chrisridings.com/guide-to-writing-fuses-for-resolve-fusion-part-1/)* and the [FragmentShader.fuse](https://www.chrisridings.com/wp-content/uploads/2020/05/FragmentShader.fuse) from his *[Davinci Resolve Page Curl Transition](https://www.chrisridings.com/page-curl/)* article; **Bryan Ray**, who did a whole series of blog posts on *[OpenCL Fuses](http://www.bryanray.name/wordpress/opencl-fuses-index/)*; **JiPi**, who did an excellent post on how to *[Convert a Shadertoy WebGL Code to DCTL](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=17&t=4460)* accompanied by a (German) [DCTL Tutorial](https://youtu.be/dbrPWRldmbs) video. As an introduction and if you want to know more about shaders in general, a look into *[The Book of Shaders](https://thebookofshaders.com)* is highly recommended. Again the [We Suck Less](https://www.steakunderwater.com/wesuckless/index.php) forum is the place where you will find tons of information and all the experts. And last but not least are all these fuses based on work shared by those wonderful people on [Shadertoy.com](https://www.shadertoy.com/).


# Installation

> Does not work! The Setup.lua seems to have some problems currently. Have to fix this.

Just clone the whole repository into a folder where it can reside. Drag'n'drop the `Tools/Setup.lua` onto your DaFusions working area. Select *'Use Fuses under Shaders straight out of the repository'*. Save this setting and restart the application. See the [Tools/README.md](Tools/README.md) for further information.

This is the installation method recommended if you want to have with a single `git pull` all the latest development versions at hand. And in particular is it the way to go if you want to work on the code and contribute to the repository yourself. If you just want to use the Fuses for your own Fusion compositions, then you should consider one of the installation methods described on [nmbr73.github.io/Shaderfuse/](https://nmbr73.github.io/Shaderfuse/).

# MkDocs local build

## Install

```bash
cd Shaderfuse
chmod +x ./build.sh
python3 -m venv venv
source venv/bin/activate
pip install mkdocs-material
pip install mkdocs-callouts
pip install mkdocs-awesome-pages-plugin
```

## Build

```bash
cd Shaderfuse
source venv/bin/activate
./build.sh
```
