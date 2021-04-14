[![Shadertoyparade](Site/img_subscribe.png)](https://youtu.be/oyndG0pLEQQ "WebGL to DCTL")

[![YouTube Demo1](https://img.shields.io/youtube/views/oyndG0pLEQQ?style=social)](https://youtu.be/oyndG0pLEQQ)
[![YouTube Demo2](https://img.shields.io/youtube/views/GJz8Vgi8Qws?style=social)](https://youtu.be/GJz8Vgi8Qws&t)
[![YouTube Demo3](https://img.shields.io/youtube/views/ntrp6BfVk0k?style=social)](https://youtu.be/ntrp6BfVk0k)
[![YouTube Demo4](https://img.shields.io/youtube/views/QE6--iYtikk?style=social)](https://youtu.be/QE6--iYtikk)


<!-- WebbHook anyone -->

Shadertoys
==========
[![GitHub release](https://img.shields.io/github/v/release/nmbr73/Shadertoys?include_prereleases)](https://github.com/nmbr73/Shadertoys/releases/latest) [![License](https://img.shields.io/badge/license-various-critical)](LICENSE)

DCTL shader fuses for use within Fusion and/or DaVinci Resolve's Fusion page (aka "DaFusion"). These are based on WebGL shaders released on [Shadertoy.com](https://www.shadertoy.com/) with a license that allows for porting (see each Fuse's source code for the respective license information); please note that neither we are related to Shadertoy.com, nor is this an official Shadertoy.com repository; but we are obviously and definitely huge fans of this amazing website!

Furthermore must be mentioned that this repository is only an incubator to develop such fuses and to exchange on experiences, approaches and solutions. If you are searching for production ready extensions to really use for your day to day work, then the [Reactor](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=32&t=1814) is the right and de facto go to place for you. As soon as an implementation in this repo achieves an appropriate maturity we will suggest it for inclusion into the Reactor - thereby Reactor is the one and only source for the outcomes and stable versions of our experiments. You should find the stable Fuses in Reactor under the same name but without any of the annoying '`ST_`', '`BETA_`', whatsoever prefixes.

<!--
[![Shadertoyparade](https://img.shields.io/badge/-subscribe-ff0000?style=for-the-badge&logo=youtube)](https://youtu.be/oyndG0pLEQQ "WebGL to DCTL")
-->



Background
----------
[![Shadertoy](https://img.shields.io/badge/-Shadertoy-ff801f)](https://www.shadertoy.com/ "Visit Shadertoy") [![WSL](https://img.shields.io/badge/-WeSuckLess-7e6a3f)](https://www.steakunderwater.com/wesuckless/index.php "Visit 'We Suck Less")

This code is mainly based on the work of **Chris Ridings** and his *[Guide to Writing Fuses for Resolve/fusion](https://www.chrisridings.com/guide-to-writing-fuses-for-resolve-fusion-part-1/)* and the [FragmentShader.fuse](https://www.chrisridings.com/wp-content/uploads/2020/05/FragmentShader.fuse) from his *[Davinci Resolve Page Curl Transition](https://www.chrisridings.com/page-curl/)* article; **Bryan Ray**, who did a whole series of blog posts on *[OpenCL Fuses](http://www.bryanray.name/wordpress/opencl-fuses-index/)*; **JiPi**, who did an excellent post on how to *[Convert a Shadertoy WebGL Code to DCTL](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=17&t=4460)* accompanied by a (German) [DCTL Tutorial](https://youtu.be/dbrPWRldmbs) video. As an introduction and if you want to know more about shaders in general, a look into *[The Book of Shaders](https://thebookofshaders.com)* is highly recommended. Again the [We Suck Less](https://www.steakunderwater.com/wesuckless/index.php) forum is the place where you will find tons of information and all the experts. And last but not least are all these fuses based on work shared by those wonderful people on [Shadertoy.com](https://www.shadertoy.com/).



Installation
------------
<!--
[![Download](https://img.shields.io/badge/download-installer-blue)](https://github.com/nmbr73/Shadertoys/releases/download/v0.1-alpha.1/Shadertoys_Installer.lua "Installer")
-->
[![Download ZIP](https://img.shields.io/badge/download-zip-blue)](https://github.com/nmbr73/Shadertoys/zipball/main "ZIP")



### Repository
Just copy the whole folder resp. clone the repository into your `Fusion/Fuses/` directory, or pick and choose only the `.fuse` files you are interested in and copy them into the target folder. If you don't know how to clone a repository or if you don't know where to find the `Fusion/Fuses/` folder, don't bother - in this case it's just not the right kind of installation for you and we have other options to offer.

### ZIP-File

Find on [GitHub Pages](https://nmbr73.github.io/Shadertoys/) the Links to download the full `.tar.gz` or `.zip` archive. After unpacking you can again copy the whole `Shaders/`folder into you `Fuses` directory or keep only single `.fuse` files.

### Fuse-Installers

You can drag'n'drop the `*-Installer.lua` files (which you find in the repo or the ZIP archive) into your Fusion working area to copy the corresponding fuse into the appropriate path. These Installers are currently under construction and not available for all fuses.

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

Usage
-----
In the Fusion page of DaVinci Resolve right click into the working area. In the context menu under 'Add tool' you'll find a 'Shadertoys/' submenu. That submenu corresponds to the repository's directory structure and provides access to all fuses installed.

Alternatively you can open the *'Select Tool'* dialog (Shift+Space Bar) and start typing "ST-" to filter for all our shadertoy fuses.


Connect
-------
[![Discord](https://img.shields.io/discord/793508729785155594?label=discord)](https://discord.gg/Zb48E4z3Pg)

<!--
[![Discord](https://img.shields.io/badge/-discord-e0e0e0?style=for-the-badge&logo=discord)](https://discord.gg/Zb48E4z3Pg "PlugIn Discord")
-->

... meet us on Discord

<!-- regrettably the iframe works on github pages bit not on github :-/ ...  iframe src="https://discord.com/widget?id=793508729785155594&theme=dark" width="350" height="500" allowtransparency="true" frameborder="0" sandbox="allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts"></iframe -->


Contribute
----------
[![GitHub Watchers](https://img.shields.io/github/watchers/nmbr73/Shadertoys?style=social)](https://github.com/nmbr73/Shadertoys) [![GitHub Stars](https://img.shields.io/github/stars/nmbr73/Shadertoys?style=social)](https://github.com/nmbr73/Shadertoys) [![GitHub Forks](https://img.shields.io/github/forks/nmbr73/Shadertoys?style=social)](https://github.com/nmbr73/Shadertoys)

...

See also the [Wiki](https://github.com/nmbr73/Shadertoys/wiki) (under construction) for some more details on how to port GLSL to DCTL.


Fuses
-----

Okay, so far there's not much here, which of course seems a bit silly after that long and thorough introduction ... but hey: it's a start.

See  [Shaders/](Shaders/README.md) for a list of all shaders implemented so far. In particular you may want to have a look at [WorkInProgress/](WorkInProgress/README.md) to see what's coming next!






Overview
========

[![Shaders/Abstract/Crazyness.fuse](Shaders/Abstract/Crazyness_320x180.png)](Shaders/Abstract/Crazyness.md)
[![Shaders/Abstract/CrossDistance.fuse](Shaders/Abstract/CrossDistance_320x180.png)](Shaders/Abstract/CrossDistance.md)
[![Shaders/Abstract/Favela.fuse](Shaders/Abstract/Favela_320x180.png)](Shaders/Abstract/Favela.md)
[![Shaders/Abstract/Kali3D.fuse](Shaders/Abstract/Kali3D_320x180.png)](Shaders/Abstract/Kali3D.md)
[![Shaders/Abstract/Noisecube.fuse](Shaders/Abstract/Noisecube_320x180.png)](Shaders/Abstract/Noisecube.md)
[![Shaders/Abstract/RainbowSlices.fuse](Shaders/Abstract/RainbowSlices_320x180.png)](Shaders/Abstract/RainbowSlices.md)
[![Shaders/Object/DancyTreeDoodle.fuse](Shaders/Object/DancyTreeDoodle_320x180.png)](Shaders/Object/DancyTreeDoodle.md)
[![Shaders/Object/DancyTreeDoodle3D.fuse](Shaders/Object/DancyTreeDoodle3D_320x180.png)](Shaders/Object/DancyTreeDoodle3D.md)
[![Shaders/Object/LonelyVoxel.fuse](Shaders/Object/LonelyVoxel_320x180.png)](Shaders/Object/LonelyVoxel.md)
[![Shaders/Planet/CrackerCars.fuse](Shaders/Planet/CrackerCars_320x180.png)](Shaders/Planet/CrackerCars.md)
[![Shaders/Planet/Fake3DScene.fuse](Shaders/Planet/Fake3DScene_320x180.png)](Shaders/Planet/Fake3DScene.md)
[![Shaders/Blob/TorturedBlob.fuse](Shaders/Blob/TorturedBlob_320x180.png)](Shaders/Blob/TorturedBlob.md)
[![Shaders/Planet/RayCastSphere.fuse](Shaders/Planet/RayCastSphere_320x180.png)](Shaders/Planet/RayCastSphere.md)
[![Shaders/Planet/EARF.fuse](Shaders/Planet/EARF_320x180.png)](Shaders/Planet/EARF.md)
[![Shaders/Tunnel/Velocibox.fuse](Shaders/Tunnel/Velocibox_320x180.png)](Shaders/Tunnel/Velocibox.md)
[![FunWithMetaballs](Shaders/Blob/FunWithMetaballs_320x180.png)](Shaders/Blob/FunWithMetaballs.md)
[![HW3Swing](Shaders/Object/HW3Swing_320x180.png)](Shaders/Object/HW3Swing.md)
[![Vine](Shaders/Abstract/Vine_320x180.png)](Shaders/Abstract/Vine.md)
[![BumpyReflectingBalls](Shaders/Abstract/BumpyReflectingBalls_320x180.png)](Shaders/Abstract/BumpyReflectingBalls.md)
[![Fire_Water](Shaders/Misc/Fire_Water_320x180.png)](Shaders/Misc/Fire_Water.md)
[![WildKifs4D](Shaders/Misc/WildKifs4D_320x180.png)](Shaders/Misc/WildKifs4D.md)
[![Shaders/Misc/FractalLand.fuse](Shaders/Misc/FractalLand_320x180.png)](Shaders/Misc/FractalLand.md)
[![Spilled](Shaders/Recursive/Spilled_320x180.png)](Shaders/Recursive/Spilled.md)
[![TDSOTM_Nebula](Shaders/Recursive/TDSOTM_Nebula_320x180.png)](Shaders/Recursive/TDSOTM_Nebula.md)
[![FlightThroughANebula](Shaders/Abstract/FlightThroughANebula_320x180.png)](Shaders/Abstract/FlightThroughANebula.md)
[![FbmWarp](Shaders/Distortion/FbmWarp_320x180.png)](Shaders/Distortion/FbmWarp.md)
[![Shaders/Abstract/Mosaic.fuse](https://user-images.githubusercontent.com/78935215/111024004-98879c00-83dc-11eb-9152-cd0ad2fd8a54.gif)](Shaders/Abstract/Mosaic.md)
[![FractalRadioBase](https://user-images.githubusercontent.com/78935215/111519940-e2afab00-8757-11eb-883a-e8578422e648.gif)](Shaders/Object/FractalRadioBase.md)
[![IHEartFourier](https://user-images.githubusercontent.com/78935215/112179345-e67d7a80-8bfa-11eb-9670-d338dfe01382.gif)](Shaders/Misc/IHeartFourier.md)
[![FallingCuteBombs](https://user-images.githubusercontent.com/78935215/112716550-55065500-8ee7-11eb-8c67-a63abf1be8f7.gif)](Shaders/Abstract/FallingCuteBombs.md)
[![EggHunt](https://user-images.githubusercontent.com/78935215/112955107-6053bd80-913f-11eb-8407-da1100e60da4.gif)](Shaders/Object/EggHunt.md)
[![WindingMengerTunnel](https://user-images.githubusercontent.com/78935215/113430326-44b81380-93da-11eb-9581-0569c1567694.gif)](Shaders/Tunnel/WindingMengerTunnel.md)
[![BuoyantBalls](https://user-images.githubusercontent.com/78935215/113590215-ab376e80-9632-11eb-9cf2-c632d25069df.gif)](Shaders/Misc/BuoyantBalls.md)
[![DisplacementShader](https://user-images.githubusercontent.com/78935215/114025552-854ddc00-9875-11eb-996b-6799996bdf7b.gif)](Shaders/Distortion/DisplacementShader.md)
[![WalkingCubes](https://user-images.githubusercontent.com/78935215/114034649-a961eb00-987e-11eb-8be4-de55b8dd1e6c.gif)](Shaders/Object/WalkingCubes.md)
[![FractalEngine](https://user-images.githubusercontent.com/78935215/111883188-11c55700-89ba-11eb-89fe-163f55daf831.gif)](Shaders/Fractals/FractalEngine.md)
[![Fractal03_gaz](https://user-images.githubusercontent.com/78935215/111883240-55b85c00-89ba-11eb-9629-5543465c4de7.gif)](Shaders/Fractals/Fractal03.md)
[![FractalGutter](https://user-images.githubusercontent.com/78935215/111883269-7f718300-89ba-11eb-8ef9-27aa8a16c7dc.gif)](Shaders/Fractals/FractalGutter.md)
[![EnergyPlant](https://user-images.githubusercontent.com/78935215/114272288-e1e7fd00-9a15-11eb-9134-8cd8c8dcb2ad.gif)](Shaders/Fractals/EnergyPlant.md)
