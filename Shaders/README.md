# Shaderfuse

DCTL shader fuses for use within Fusion and/or DaVinci Resolve's Fusion page (aka "DaFusion"). See the [videos](Videos.md) to get an idea of what this does look like. The Fuses are based on WebGL shaders released on [Shadertoy.com](https://www.shadertoy.com/) with a license that allows for porting (see each Fuse's source code and/or info pane for the respective license information); please note that neither we are related to Shadertoy.com, nor is this an official Shadertoy.com repository; but we are obviously and definitely huge fans of this amazing website!

> [!danger] Watch out for each shader's license information!
>
> Most (but not all) shaders contained here are CC BY-NC-SA as on Shadertoy they default to this license if not stated otherwise. Please give proper attribution to the fragment shader's author when using one of the in your work plus you must not use them in any commercial context.

Furthermore must be mentioned that this repository is only an incubator to develop such fuses and to exchange on experiences, approaches and solutions. If you are searching for production ready extensions to really use for your day to day work, then the [Reactor](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=32&t=1814) is the right and de facto go to place for you. As soon as an implementation in this repository achieves an appropriate maturity we will suggest it for inclusion into the Reactor - thereby Reactor is the one and only source for the outcomes and stable versions of our experiments. You should find the stable Fuses in Reactor under the same name but without any of the annoying '`_DEV`', '`_BETA`', or whatsoever suffixes.


## Fuses

See [Shaders](Shaders.md) for a list of all shaders implemented so far - resp. the [Overview](Overview.md) to have with thumbnails a more 'visual experience'. Find what's new with the [latest conversions](Latest Conversions.md), or have a look at the [Shader of the Week](ShaderOfTheWeek/ShaderOfTheWeek.md) list.

Current Shader of the Week (15th of August 2023):
<center>

[![bomlka](https://github.com/nmbr73/Shaderfuse/assets/78935215/97e1ea2a-743a-4834-9df0-3c6f1178b8d4)
](ShaderOfTheWeek/Bomlka.md)


[bomlka](ShaderOfTheWeek/Bomlka.md) by [lamogui](https://www.shadertoy.com/user/lamogui)
</center>


## Installation

### Reactor

Best way to install the Fuses is to just use [Reactor](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=32&t=1814). Find the 'Shadertoys' package in the - guess what - 'Shaders' category. This is the most convenient and recommended way to if you just what to use them or have a quick look if they might be useful for you.

![Reactor](Reactor.png)

Only thing to take into account is that this way you don't get the latest development versions. Stable toys are bundled from time to time and integrated in Reactor when reviewed. You will find the Shaderfuses installed this way in Effects under 'Shaderfuse'.

### Installer

Alternately to the Reactor package install, you can download a Fuse's '`*-Installer.lua`' installation script in case you want to quickly try out the latest version of a single Fuse. Drag and drop that script onto your Fusion workspace and follow installer's instructions. You will find Fuses installed this way in Effects under 'Shaderfuse (beta)' and node instances of such Fuses will have a '_BETA' suffix in your composition.

If you want to try out multiple Shaderfuses this way, you can download all the latest installers as [Shaderfuse-Installers.zip](Shaderfuse-Installers.zip). Unpack the that archive and then drag and drop the installers of your choice onto Fusion.


## Usage

In the Fusion page of DaVinci Resolve right click into the working area. In the context menu under 'Add tool' you'll find a 'Shaderfuse' submenu (resp. 'Shaderfuse (beta)' for their variants installed using an installer). That submenu corresponds to the Fuse categories you see on this page and provides access to all fuses installed.

Alternatively you can open the *'Select Tool'* dialog (Shift+Space Bar) and start typing "`sf.`" to filter for the shadertoy fuses (or use "sf-b." for the beta versions installed via an installer script).

And last but not least in 'Effects' (Fusion) resp. the 'Effects Library' (DaVinci Resolve) pane under 'Tools' you should now find an entry 'Shaderfuse' (resp. 'Shaderfuse (beta)') that lists all the categories and the different fuses.

Please note, that there a some specific shaders that might need additional Fuses at their input to be used. These are in particular all the [Cubemap](Cubemap/README.md) and [Audio](Audio/README.md) shaders.
