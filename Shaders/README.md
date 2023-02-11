# Shaderfuse

DCTL shader fuses for use within Fusion and/or DaVinci Resolve's Fusion page (aka "DaFusion"). See the [videos](Videos.md) to get an idea of what this does look like. The Fuses are based on WebGL shaders released on [Shadertoy.com](https://www.shadertoy.com/) with a license that allows for porting (see each Fuse's source code and/or info pane for the respective license information); please note that neither we are related to Shadertoy.com, nor is this an official Shadertoy.com repository; but we are obviously and definitely huge fans of this amazing website!

Furthermore must be mentioned that this repository is only an incubator to develop such fuses and to exchange on experiences, approaches and solutions. If you are searching for production ready extensions to really use for your day to day work, then the [Reactor](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=32&t=1814) is the right and de facto go to place for you. As soon as an implementation in this repository achieves an appropriate maturity we will suggest it for inclusion into the Reactor - thereby Reactor is the one and only source for the outcomes and stable versions of our experiments. You should find the stable Fuses in Reactor under the same name but without any of the annoying '`_DEV`', '`_BETA`', or whatsoever suffixes.


## Fuses

See [Shaders](Shaders.md) for a list of all shaders implemented so far - resp. the [Overview](Overview.md) to have with thumbnails a more 'visual experience'. Find what's new with the [latest conversions](Latest Conversions.md), or have a look at the [Shader of the Week](ShaderOfTheWeek/ShaderOfTheWeek.md) list.

Current Shader of the Week (8th of February 2023):
<center>
[![NintendoSwitch](https://user-images.githubusercontent.com/78935215/217755415-62e43bf7-801c-4811-9d9b-c307cee53820.gif)
](ShaderOfTheWeek/NintendoSwitch.md)
[Nintendo Switch](ShaderOfTheWeek/NintendoSwitch.md) by [jackdavenport](https://www.shadertoy.com/user/jackdavenport)
</center>


## Setup

### Installation

Best way to install the Fuses is to just use Reactor. Find the 'Shadertoys' package in the - guess what - 'Shaders' category. This is the most convenient and recommended way to if you just what to use them or have a quick look if they might be useful for you.

Only thing to take into account is that this way you don't get the latest development versions. Stable toys are bundled from time to time and integrated in Reactor when reviewed.

### Usage

In the Fusion page of DaVinci Resolve right click into the working area. In the context menu under 'Add tool' you'll find a 'Shaderfuse/' submenu. That submenu corresponds to the repository's directory structure and provides access to all fuses installed.

Alternatively you can open the *'Select Tool'* dialog (Shift+Space Bar) and start typing "ST-" to filter for all our shadertoy fuses.

And last but not least in 'Effects' (Fusion) resp. the 'Effects Library' (DaVinci Resolve) pane under 'Tools' you should now find an entry 'Shaderfuse' that lists all the categories and the different fuses.


## Specific Shaders

### Audio Shader

Shaders that use audio data (wave and frequency) over an image for display. Shadertoy provides an interface consisting of an image (512*2 pixels). One line contains 512 sampled waveform values ​​belonging to the current frame and the second line contains the FFT (Spectrum) values.
This interface can also be implemented in Resolve/Fusion. The [AudioWaveform.fuse](Fuses/AudioWaveform.md) generates the corresponding image from a loaded WAV file. The AudioWaveform has a second output for this. This Output is connected to an AudioShaderfuse-Input.

[![Download Installer](https://img.shields.io/static/v1?label=Download&message=AudioWaveform-Installer.lua&color=blue)](https://github.com/nmbr73/Shaderfuse/releases/download/V1.1/AudioWaveform-Installer.lua "Installer")

Here are the AudioShaderfuses:
- [AudioWaveformVisualizer](Audio/AudioWaveformVisualizer.md)
- [AudioHeightfield1](Audio/AudioHeightfield1.md)
- [JamSession](Audio/JamSession.md)
- [ReactiveVoronoi](Audio/ReactiveVoronoi.md)
- [Rlstyle](Audio/Rlstyle.md)
- [ShadertoyAudioDisplay](Audio/ShadertoyAudioDisplay.md)
- [InerciaIntended](Audio/Inerciaintended.md) :new:

[![InerciaIntended](https://user-images.githubusercontent.com/78935215/200139202-3c5b2c15-bd43-4998-84d6-a06820255d5d.gif)](Audio/Inerciaintended.md)


### Cubemap Shader

These are shaders that require a cubemap as input. nmbr73 created a tool to provide a cubemap for the shader fuses.

[![Download Installer](https://img.shields.io/static/v1?label=Download&message=CubeMapLoader-Installer.lua&color=blue)](https://github.com/nmbr73/Shaderfuse/releases/download/V1.1/CubeMapLoader-Installer.lua "Installer")

Here are the cubemap shader fuses:
- [BallsAreTouching](Cubemap/BallsAreTouching.md)
- [GlassAndBubble](Cubemap/GlassAndBubble.md)
- [KissTracing](Cubemap/KissTracing.md)
- [NewtonPendulum](Cubemap/NewtonPendulum.md)
- [OceanElemental](Cubemap/OceanElemental.md)
