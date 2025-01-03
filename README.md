**README**  | [Setup](Tools/README.md) | [Repository Tools](Tools/Scripts/Comp/Shaderfuse/Repository%20Tools/README.md)

 :warning: **Unfortunately, with version 19.1 of DaVinci Resolve, BMD has decided to disable the so-called 'UI Manager' for the free version; from now on, it can only be used through extensions in the paid Studio version. However, essential parts of Shaderfuses (and many other great free tools out there) are based on exactly this component. So unless you have the paid version, the Shaderfuses cannot be installed via the Reactor or our installer scripts from this version onwards. The setup for development on the fuses no longer works either, nor does the browser for selecting a Shaderfuse and probably a few other things - all in all, meaningful use is virtually impossible.**

*We do this in our spare time and as a hobby. We understand that we are absolutely not part of BMD's target group and we are sure that the people over there at BMD know best how to run their business - from this perspective this step may be reasonable. But for people like us, it makes little sense to invest much more of our free time in this and similar projects. Not because of the Studio license (we bought our own licenses with our own money), but rather because it was fun to develop free things that can be used for free. But contributing unpaid work to a commercial product where others have to pay for our unpaid work - that doesn't feel right somehow.*

*However, it was not the software in particular, but above all the community that had formed around it that gave us a lot of support and motivation. If BMD is now restricting itself to professional use - which they absolutely deserve as a provider of professional tools - then in this world there is obviously no room for hobbyists, enthusiasts, beginners and tinkerer. It's sad, but it is what it is.*

*Long story short: If you don't have Studio, then we can't help you; and if you have Studio, then you must be a "pro" and in case of any questions we can't help you either - because we ourselves are neither professionals nor are we the support staff of BMD ... in our personal opinion this is how you kill a great and enthusiastic community.*


-------


# Shaderfuse
[![GitHub release](https://img.shields.io/github/v/release/nmbr73/Shaderfuse?include_prereleases)](https://github.com/nmbr73/Shaderfuse/releases/latest) [![License](https://img.shields.io/badge/license-various-critical)](LICENSE) [![Discord](https://img.shields.io/discord/793508729785155594?label=discord)](https://discord.gg/Zb48E4z3Pg)

[Shadertoy.com](https://www.shadertoy.com/) fragment shaders converted to Fuses for use in DaFusion (this is either the stand alone version of Fusion or DaVinci Resolve's Fusion page) on Mac or Windows. If you are a software dev interested in contributing to the Shaderfuse project, then you've come to the right place. If you are more of a digital artist mainly wanting to just use the Fuses in BMD's DaFusion, then it's recommended that you start your journey at [nmbr73.github.io/Shaderfuse/](https://nmbr73.github.io/Shaderfuse/). And if you don't know what all of this is about, then you may want to have a look at our [Shaderfuse video playlist](https://www.youtube.com/playlist?list=PLqbIsaWc6bt1AuwEHF116QcFsNPKnLYHD) first to get an idea.



# Installation

:bomb::bomb::bomb: **With v19.1 the installation of this project will not work anymore in any of the free variants of BMD's software.**

Make sure to read, understand and respect the [LICENSE](LICENSE) information: As we do run some shady scripts that make changes to your system you need to know that in particular absolutely no warranties are made and all of this is completely at your own risk!

First `cd` into a directory where the project can permanently reside. Some links will be created pointing into this directory to make it work with your DaFusion installation; therefore its location can not easily be changed later. Checkout the whole repository ...
```bash
git clone https://github.com/nmbr73/Shaderfuse.git
```
Then use your systems file manager (*File Explorer* on Windows, resp. *Finder* on a Mac) to Drag'n'drop the `Tools/Setup.lua` onto your Fusion's working area. Select *'Use Fuses under Shaders straight out of the repository'*. Save this setting and restart the application. See [Setup](Tools/README.md) for further information on what this Lua scripts tries to do behind the scenes.

Now you should be ready to play with the code and try it in DaFusion. Also you can now follow along the latest developments with a simple `git pull`.

If you want to track your own changes and maybe even contribute them via pull requests, then you should do all of the above on your own fork of the [Shaderfuses](https://github.com/nmbr73/Shaderfuse) project (highly recommended; works pretty much the same; just replace `nmbr73` with your GitHub user name).



# Local Build

In case you want to build the documentation locally, and/or to test the Reactor Atom package build, then do the following (Mac only at the moment; and even more fragile than the normal installation already is). Note: Some of this functionality should also be accessible from within DaFusion via the [Repository Tools](Tools/Scripts/Comp/Shaderfuse/Repository%20Tools/README.md), but the 'build.sh' script is in the end what's being used in the Action workflows on GitHub.

Be sure to have Lua installed and make the `build.sh` script executable ...
```bash
brew install lua
cd Shaderfuse
chmod +x ./build.sh
```

Then a `./build.sh help` should show you the available options as something like:
```
Usage:

  build.sh <command>

The commands are:

  atom         create the atom package under 'atom/'
  csv          create Shaders.csv with a list of all the shaders
  assets       create 'assets/' with files to add to a GitHub release
  installers   create the drag'n'drop installer lua scripts
  docs         create all the input needed for mkdocs
  clean        delete any of the autogenerated / temporary content
```

If you also want to render and view the documentation with [MkDocs](https://www.mkdocs.org), then install its dependencies into a virtual Python environment:
```bash
cd Shaderfuse
python3 -m venv venv
source venv/bin/activate
pip install mkdocs-material
pip install mkdocs-callouts
pip install mkdocs-awesome-pages-plugin
```

This should then allow you to build and serve the documentation on your computer:
```bash
cd Shaderfuse
source venv/bin/activate
./build.sh docs
mkdocs serve
```

## Acknowledgements

This code is mainly based on the work of **Chris Ridings** and his *[Guide to Writing Fuses for Resolve/fusion](https://www.chrisridings.com/guide-to-writing-fuses-for-resolve-fusion-part-1/)* and the [FragmentShader.fuse](https://www.chrisridings.com/wp-content/uploads/2020/05/FragmentShader.fuse) from his *[Davinci Resolve Page Curl Transition](https://www.chrisridings.com/page-curl/)* article; **Bryan Ray**, who did a whole series of blog posts on *[OpenCL Fuses](http://www.bryanray.name/wordpress/opencl-fuses-index/)*; **JiPi**, who did an excellent 'We Suck Less' post on how to *[Convert a Shadertoy WebGL Code to DCTL](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=17&t=4460)* accompanied by a (German) [DCTL Tutorial](https://youtu.be/dbrPWRldmbs) video. As an introduction and if you want to know more about shaders in general, a look into *[The Book of Shaders](https://thebookofshaders.com)* is highly recommended. Again the [We Suck Less](https://www.steakunderwater.com/wesuckless/index.php) forum is the place where you will find tons of information and all the experts. A big *thank you!!!* must go to **Andrew Hazelden** for all his exceptional support and for his everlasting commitment to the stimulation of the Fusion development community. And last but not least one must note that in the end all these fuses are based on the remarkable work shared by those wonderful people out there on **[Shadertoy.com](https://www.shadertoy.com/)**.


