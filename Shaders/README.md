# Shaderfuse

DCTL shader fuses for use within Fusion and/or DaVinci Resolve's Fusion page (aka "DaFusion"). These are based on WebGL shaders released on [Shadertoy.com](https://www.shadertoy.com/) with a license that allows for porting (see each Fuse's source code for the respective license information); please note that neither we are related to Shadertoy.com, nor is this an official Shadertoy.com repository; but we are obviously and definitely huge fans of this amazing website!

Furthermore must be mentioned that this repository is only an incubator to develop such fuses and to exchange on experiences, approaches and solutions. If you are searching for production ready extensions to really use for your day to day work, then the [Reactor](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=32&t=1814) is the right and de facto go to place for you. As soon as an implementation in this repo achieves an appropriate maturity we will suggest it for inclusion into the Reactor - thereby Reactor is the one and only source for the outcomes and stable versions of our experiments. You should find the stable Fuses in Reactor under the same name but without any of the annoying '`_DEV`', '`_BETA`', or whatsoever suffixes.

See the [videos](Videos.md) to get an idea what these Fuses look like.





## Fuses

See  [Shaders](Shaders.md) for a list of all shaders implemented so far - resp. the [Overview](Overview.md) to have with thumbnails a more 'visual experience'.

### Shader of the week

On the home page of ShaderToy.com the "Shader of the Week" is presented. As far as this can be converted to DCTL, the fuse is published here.
[Shader of the Week](Shaders/ShaderOfTheWeek/ShaderOfTheWeek.md)

[**Current Shader of the Week (8th of February 2023):**](Shaders/ShaderOfTheWeek/NintendoSwitch.md)

[![NintendoSwitch](https://user-images.githubusercontent.com/78935215/217755415-62e43bf7-801c-4811-9d9b-c307cee53820.gif)
](Shaders/ShaderOfTheWeek/NintendoSwitch.md)


#### Latest Conversions

[![MountainsLakes](https://user-images.githubusercontent.com/78935215/187472791-ae84973b-10e9-4945-8b45-2ea661b12b0a.gif)
](Shaders/Misc/MountainsLakes.md)
[![AnisotropicBlurImage](https://user-images.githubusercontent.com/78935215/173939861-554cd73b-f945-4af9-a775-42517b3e419d.gif)](Shaders/Recursive/AnisotropicBlurImage.md)
[![HappyBouncing](https://user-images.githubusercontent.com/78935215/147247710-5e0126ac-7252-4d47-8b03-96c461cf4564.gif
)](Shaders/Object/HappyBouncing.md)
[![ShareX](Shaders/Object/ShareX_320x180.png)](Shaders/Object/ShareX.md)
[![GrowingWeatheringRocks](https://user-images.githubusercontent.com/78935215/128998614-85759f48-e57a-4021-aebd-10a3bf5c138c.gif)](Shaders/Recursive/GrowingWeatheringRocks.md)
[![Dynamism](https://user-images.githubusercontent.com/78935215/126867926-b7bf3330-67ff-4604-8b83-6c8c54c20664.gif)](Shaders/Abstract/Dynamism.md)
[![LearningReationDiffusion](https://user-images.githubusercontent.com/78935215/126063449-f4ef9253-d228-4448-99cf-2c89cc3d6c87.gif)](Shaders/Recursive/LearningReactionDiffusion.md)
[![Oblivion](https://user-images.githubusercontent.com/78935215/123615732-e0082b80-d805-11eb-9511-eefaadecb8be.gif)](Shaders/Object/Oblivion.md)
[![ProceduralWalkAnimation](https://user-images.githubusercontent.com/78935215/121263523-05181700-c8b6-11eb-98f5-aa44d178ce23.gif)](Shaders/Object/ProceduralWalkAnimation.md)
[![MightyMorphingPowerSphere](https://user-images.githubusercontent.com/78935215/120659993-2e384200-c487-11eb-8918-f0f8957dc9d6.gif)](Shaders/Planet/MightyMorphingPowerSphere.md)
[![HeavenAndHell](https://user-images.githubusercontent.com/78935215/119268704-72f4eb00-bbf4-11eb-91e0-4af4d2ca9ec0.gif)](Shaders/Object/HeavenAndHell.md)
[![Rendezvous](https://user-images.githubusercontent.com/78935215/119050128-b74c7500-b9c1-11eb-84cc-9fe267e2432a.gif)](Shaders/Fractals/Rendezvous.md)


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
- [AudioWaveformVisualizer](Shaders/Audio/AudioWaveformVisualizer.md)
- [AudioHeightfield1](Shaders/Audio/AudioHeightfield1.md)
- [JamSession](Shaders/Audio/JamSession.md)
- [ReactiveVoronoi](Shaders/Audio/ReactiveVoronoi.md)
- [Rlstyle](Shaders/Audio/Rlstyle.md)
- [ShadertoyAudioDisplay](Shaders/Audio/ShadertoyAudioDisplay.md)
- [InerciaIntended](Shaders/Audio/Inerciaintended.md) :new:

[![InerciaIntended](https://user-images.githubusercontent.com/78935215/200139202-3c5b2c15-bd43-4998-84d6-a06820255d5d.gif)](Shaders/Audio/Inerciaintended.md)


### Cubemap Shader

These are shaders that require a cubemap as input. nmbr73 created a tool to provide a cubemap for the shader fuses.

[![Download Installer](https://img.shields.io/static/v1?label=Download&message=CubeMapLoader-Installer.lua&color=blue)](https://github.com/nmbr73/Shaderfuse/releases/download/V1.1/CubeMapLoader-Installer.lua "Installer")

Here are the cubemap shader fuses:
- [BallsAreTouching](Shaders/Cubemap/BallsAreTouching.md)
- [GlassAndBubble](Shaders/Cubemap/GlassAndBubble.md)
- [KissTracing](Shaders/Cubemap/KissTracing.md)
- [NewtonPendulum](Shaders/Cubemap/NewtonPendulum.md)
- [OceanElemental](Shaders/Cubemap/OceanElemental.md)
