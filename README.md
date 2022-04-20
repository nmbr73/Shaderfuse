<center>
<a href="https://youtu.be/oyndG0pLEQQ"><img src="Site/img_subscribe.png" /></a>
</center>

# Shadertoys

[![GitHub release](https://img.shields.io/github/v/release/nmbr73/Shadertoys?include_prereleases)](https://github.com/nmbr73/Shadertoys/releases/latest) [![License](https://img.shields.io/badge/license-various-critical)](LICENSE)

DCTL shader fuses for use within Fusion and/or DaVinci Resolve's Fusion page (aka "DaFusion"). These are based on WebGL shaders released on [Shadertoy.com](https://www.shadertoy.com/) with a license that allows for porting (see each Fuse's source code for the respective license information); please note that neither we are related to Shadertoy.com, nor is this an official Shadertoy.com repository; but we are obviously and definitely huge fans of this amazing website!

<!--
[![Shadertoy](https://img.shields.io/badge/-Shadertoy-ff801f)](https://www.shadertoy.com/ "Visit Shadertoy") [![WSL](https://img.shields.io/badge/-WeSuckLess-7e6a3f)](https://www.steakunderwater.com/wesuckless/index.php "Visit 'We Suck Less")
-->

Furthermore must be mentioned that this repository is only an incubator to develop such fuses and to exchange on experiences, approaches and solutions. If you are searching for production ready extensions to really use for your day to day work, then the [Reactor](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=32&t=1814) is the right and de facto go to place for you. As soon as an implementation in this repo achieves an appropriate maturity we will suggest it for inclusion into the Reactor - thereby Reactor is the one and only source for the outcomes and stable versions of our experiments. You should find the stable Fuses in Reactor under the same name but without any of the annoying '`ST_`', '`BETA_`', whatsoever prefixes.

See the following videos to get an idea what these Fuses look like:

<center>
<table>
<tr>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=oyndG0pLEQQ" target="_blank"><img src="http://img.youtube.com/vi/oyndG0pLEQQ/0.jpg" alt="Demo 1" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/oyndG0pLEQQ?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=GJz8Vgi8Qws" target="_blank"><img src="http://img.youtube.com/vi/GJz8Vgi8Qws/0.jpg" alt="Demo 2" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/GJz8Vgi8Qws?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=ntrp6BfVk0k" target="_blank"><img src="http://img.youtube.com/vi/ntrp6BfVk0k/0.jpg" alt="Demo 3" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/ntrp6BfVk0k?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=QE6--iYtikk" target="_blank"><img src="http://img.youtube.com/vi/QE6--iYtikk/0.jpg" alt="Demo 4" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/QE6--iYtikk?style=social" /></a></td>
</tr>
<tr>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=WGWCrhPNmdg" target="_blank"><img src="http://img.youtube.com/vi/WGWCrhPNmdg/0.jpg" alt="Demo 5" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/WGWCrhPNmdg?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=OYOar65omeM" target="_blank"><img src="http://img.youtube.com/vi/OYOar65omeM/0.jpg" alt="Demo 6" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/OYOar65omeM?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=8sUu5GcDako" target="_blank"><img src="http://img.youtube.com/vi/8sUu5GcDako/0.jpg" alt="Demo 7" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/8sUu5GcDako?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=OKpJbFisE4c" target="_blank"><img src="http://img.youtube.com/vi/OKpJbFisE4c/0.jpg" alt="Demo 8" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/OKpJbFisE4c?style=social" /></a></td>
</tr>
<tr>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=wKhv1nPb2lk" target="_blank"><img src="http://img.youtube.com/vi/wKhv1nPb2lk/0.jpg" alt="Demo 9" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/wKhv1nPb2lk?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=dFqDDr7S_K0" target="_blank"><img src="http://img.youtube.com/vi/dFqDDr7S_K0/0.jpg" alt="Demo 10" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/dFqDDr7S_K0?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=f14cOuMq-vk" target="_blank"><img src="http://img.youtube.com/vi/f14cOuMq-vk/0.jpg" alt="Demo 11" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/f14cOuMq-vk?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=tDWsdnl7SdE" target="_blank"><img src="http://img.youtube.com/vi/tDWsdnl7SdE/0.jpg" alt="Demo 12" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/f14cOuMq-vk?style=social" /></a></td>
</tr>
<tr>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=ZyZ2y_07wXs" target="_blank"><img src="http://img.youtube.com/vi/ZyZ2y_07wXs/0.jpg" alt="Demo 13" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/ZyZ2y_07wXs?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=ExNG8n559NY" target="_blank"><img src="http://img.youtube.com/vi/ExNG8n559NY/0.jpg" alt="Demo 14" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/ExNG8n559NY?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=3vrS5hUsU60" target="_blank"><img src="http://img.youtube.com/vi/3vrS5hUsU60/0.jpg" alt="Demo 15" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/3vrS5hUsU60?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=UVl4vYk1D-o" target="_blank"><img src="http://img.youtube.com/vi/UVl4vYk1D-o/0.jpg" alt="Demo 16" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/UVl4vYk1D-o?style=social" /></a></td>
<tr>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=QTft66_s8qY" target="_blank"><img src="http://img.youtube.com/vi/QTft66_s8qY/0.jpg" alt="Demo 17" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/QTft66_s8qY?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=3ikzubTYlm0" target="_blank"><img src="http://img.youtube.com/vi/3ikzubTYlm0/0.jpg" alt="Demo 18" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/3ikzubTYlm0?style=social" /></a></td>
<td><a href="http://www.youtube.com/watch?feature=player_embedded&v=EIIfA28pvZQ" target="_blank"><img src="http://img.youtube.com/vi/EIIfA28pvZQ/0.jpg" alt="Demo 19" width="120" height="90" border="10" /><br /><img src="https://img.shields.io/youtube/views/EIIfA28pvZQ?style=social" /></a></td>
</tr>
</table>
</center>


This code is mainly based on the work of **Chris Ridings** and his *[Guide to Writing Fuses for Resolve/fusion](https://www.chrisridings.com/guide-to-writing-fuses-for-resolve-fusion-part-1/)* and the [FragmentShader.fuse](https://www.chrisridings.com/wp-content/uploads/2020/05/FragmentShader.fuse) from his *[Davinci Resolve Page Curl Transition](https://www.chrisridings.com/page-curl/)* article; **Bryan Ray**, who did a whole series of blog posts on *[OpenCL Fuses](http://www.bryanray.name/wordpress/opencl-fuses-index/)*; **JiPi**, who did an excellent post on how to *[Convert a Shadertoy WebGL Code to DCTL](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=17&t=4460)* accompanied by a (German) [DCTL Tutorial](https://youtu.be/dbrPWRldmbs) video. As an introduction and if you want to know more about shaders in general, a look into *[The Book of Shaders](https://thebookofshaders.com)* is highly recommended. Again the [We Suck Less](https://www.steakunderwater.com/wesuckless/index.php) forum is the place where you will find tons of information and all the experts. And last but not least are all these fuses based on work shared by those wonderful people on [Shadertoy.com](https://www.shadertoy.com/).

[![JiPi](https://img.shields.io/badge/-JiPi-ff0000?style=for-the-badge&logo=youtube)](https://youtu.be/oyndG0pLEQQ "WebGL to DCTL: Shadertoyparade") [![nmbr73](https://img.shields.io/badge/-nmbr73-ff0000?style=for-the-badge&logo=youtube)](https://youtu.be/GJz8Vgi8Qws "The Shader Cut")



# Shader of the week

On the home page of ShaderToy.com the "Shader of the Week" is presented. As far as this can be converted to DCTL, the fuse is published here.
[Shader of the Week](Shaders/ShaderOfTheWeek/ShaderOfTheWeek.md)

**Current Shader of the Week (20th of April 2022):**

[![DangerNoodle](https://user-images.githubusercontent.com/78935215/164216037-35b7febd-440e-42c7-af87-3cf259c0eece.gif)
](Shaders/ShaderOfTheWeek/DangerNoodle.md)



# Fuses

See  [Shaders/](Shaders/README.md) for a list of all shaders implemented so far - resp. the [Overview](Shaders/OVERVIEW.md) to have with thumbnails a more 'visual experience'. In particular you may want to have a look at [WorkInProgress/](WorkInProgress/README.md) to see what's coming next!
And if you want to build shaderfuses yourself, you can see here which projects have already been started: [Shaderfuseattempts](WorkInProgress/Shaderfuseattempts.md).

## Latest Conversions

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

# Installation

<!--
[![Download](https://img.shields.io/badge/download-installer-blue)](https://github.com/nmbr73/Shadertoys/releases/download/v0.1-alpha.1/Shadertoys_Installer.lua "Installer")
-->
[![Download ZIP](https://img.shields.io/badge/download-zip-blue)](https://github.com/nmbr73/Shadertoys/zipball/main "ZIP")

## Reactor

Best way to install the Fuses is to just use Reactor. Find the 'Shadertoys' package in the - guess what - 'Shaders' category. This is the most convenient and recommended way to if you just what to use them or have a quick look if they might be useful for you.

Only thing to take into account is that this way you don't get the latest development versions. Stable toys are bundled from time to time and integrated in Reactor when reviewed.

## Repository

Just clone the whole repository into a folder where it can reside. Drag'n'drop the `Tools/Setup.lua` onto your DaFusions working area. Select *'Use Fuses under Shaders straight out of the repository'*. Save this setting and restart the application. See the [Tools/README.md](Tools/README.md) for further information.

This is the installation method recommended if you want to have with a single `git pull` all the latest development versions at hand. And in particular it is the way to go if you want to work on the code and contribute to the repository yourself.

## ZIP-File

Find on [GitHub Pages](https://nmbr73.github.io/Shadertoys/) the Links to download the full `.tar.gz` or `.zip` archive. After unpacking you can copy the whole `Shaders/` folder into your `Fuses` directory or pick and choose only single `.fuse` files you want to keep.

<!--
## Fuse-Installers

For this method you must have cloned the repository or downloaded and unpacked the ZIP file. You can then drag'n'drop the `*-Installer.lua` files (which you find in `Shaders/` folder's subdirectories of the repo or the ZIP archive) into your Fusion working area to copy the corresponding fuse into the appropriate path. These Installers are currently under construction and not available for all fuses.

These installers are more meant to quickly try a single fuse or to share it via email, discord, etc.
-->

<!--
### Installer

Alternatively you can also use the installer of the v0.1-alpha.1 release: drag'n'drop the `Shadertoys_Installer.lua` onto you Fusion working area, perform the installation and restart DaVinci Resolve.
-->

<!--
[![Download](img_download.png)](https://github.com/nmbr73/Shadertoys/releases/download/v0.1-alpha.1/Shadertoys_Installer.lua)
-->

<!--
[![Download](https://img.shields.io/badge/-download-60a0ff?style=for-the-badge&logo=github)](https://github.com/nmbr73/Shadertoys/releases/download/v0.1-alpha.1/Shadertoys_Installer.lua "Installer")
-->

# Usage

In the Fusion page of DaVinci Resolve right click into the working area. In the context menu under 'Add tool' you'll find a 'Shadertoys/' submenu. That submenu corresponds to the repository's directory structure and provides access to all fuses installed.

Alternatively you can open the *'Select Tool'* dialog (Shift+Space Bar) and start typing "ST-" to filter for all our shadertoy fuses.

And last but not least in 'Effects' (Fusion) resp. the 'Effects Library' (DaVinci Resolve) pane under 'Tools' you should now find an entry 'Shadertoys' that lists all the categories and the different fuses.



# Audio Shader

Shaders that use audio data (wave and frequency) over an image for display. Shadertoy provides an interface consisting of an image (512*2 pixels). One line contains 512 sampled waveform values ​​belonging to the current frame and the second line contains the FFT (Spectrum) values.
This interface can also be implemented in Resolve/Fusion. The [AudioWaveform.fuse](Fuses/AudioWaveform.md) generates the corresponding image from a loaded WAV file. The AudioWaveform has a second output for this. This Output is connected to an AudioShaderfuse-Input.

[![Download Installer](https://img.shields.io/static/v1?label=Download&message=AudioWaveform-Installer.lua&color=blue)](https://github.com/nmbr73/Shadertoys/releases/download/V1.1/AudioWaveform-Installer.lua "Installer")

Here are the AudioShaderfuses:
- [AudioWaveformVisualizer](Shaders/Audio/AudioWaveformVisualizer.md)
- [AudioHeightfield1](Shaders/Audio/AudioHeightfield1.md)
- [JamSession](Shaders/Audio/JamSession.md)
- [ReactiveVoronoi](Shaders/Audio/ReactiveVoronoi.md)
- [Rlstyle](Shaders/Audio/Rlstyle.md)
- [ShadertoyAudioDisplay](Shaders/Audio/ShadertoyAudioDisplay.md)


# Cubemap Shader

These are shaders that require a cubemap as input. nmbr73 created a tool to provide a cubemap for the shader fuses.

[![Download Installer](https://img.shields.io/static/v1?label=Download&message=CubeMapLoader-Installer.lua&color=blue)](https://github.com/nmbr73/Shadertoys/releases/download/V1.1/CubeMapLoader-Installer.lua "Installer")

Here are the cubemap shader fuses:
- [BallsAreTouching](Shaders/Cubemap/BallsAreTouching.md)
- [GlassAndBubble](Shaders/Cubemap/GlassAndBubble.md)
- [KissTracing](Shaders/Cubemap/KissTracing.md)
- [NewtonPendulum](Shaders/Cubemap/NewtonPendulum.md)
- [OceanElemental](Shaders/Cubemap/OceanElemental.md)

# Contribute

[![Discord](https://img.shields.io/discord/793508729785155594?label=discord)](https://discord.gg/Zb48E4z3Pg) [![GitHub Watchers](https://img.shields.io/github/watchers/nmbr73/Shadertoys?style=social)](https://github.com/nmbr73/Shadertoys) [![GitHub Stars](https://img.shields.io/github/stars/nmbr73/Shadertoys?style=social)](https://github.com/nmbr73/Shadertoys) [![GitHub Forks](https://img.shields.io/github/forks/nmbr73/Shadertoys?style=social)](https://github.com/nmbr73/Shadertoys)

<!--
[![Discord](https://img.shields.io/badge/-discord-e0e0e0?style=for-the-badge&logo=discord)](https://discord.gg/Zb48E4z3Pg "PlugIn Discord")
-->
<!-- regrettably the iframe works on github pages bit not on github :-/ ...  iframe src="https://discord.com/widget?id=793508729785155594&theme=dark" width="350" height="500" allowtransparency="true" frameborder="0" sandbox="allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts"></iframe -->

Just fork this repository, have fun and send your pull requests. See also the [Wiki](https://github.com/nmbr73/Shadertoys/wiki) (under construction) for some more details on how to port GLSL to DCTL. For further information meet us on the DaVinci Resolve Plug-in Developers Discord server.
