Shadertoys
==========

DCTL Shader Fuses for use within DaVinci Resolve's Fusion page (aka DaFusion). These are based on WebGL shaders realeased on [Shadertoy.com](https://www.shadertoy.com/) with a license that allows for porting (see each fuse's source code for the respective license information); please note that neither we are related to Shadertoy.com, nor is this an official Shadertoy.com repository; but we are definitely huge fans of this amazing website!

Furthermore must be mentioned that this repository is only a playground and incubator to develop such Fuses and to exchange the experiences and solutions. If you are searching for production ready extensions to really use for your day to day work, then the [Reactor](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=32&t=1814) is the right place for you. As soon as an implementation in this repo achieves an appropriate maturity we will suggest it for inclusion into the Reactor - thereby Reactor is the one and only source for the outcomes and stable versions of our experiments. You should find the stable Fuses in reactor under the same name but without the annoying '`ST_`' prefixes (ST has nothing to do with Shadertoy - it is ST for STaging, Some Trash, Sharder Test, or whatever).

Background
----------

This code is mainly based on the work of **Chris Ridings** and his *[Guide to Writing Fuses for Resolve/fusion](https://www.chrisridings.com/guide-to-writing-fuses-for-resolve-fusion-part-1/)* and the [FragmentShader.fuse](https://www.chrisridings.com/wp-content/uploads/2020/05/FragmentShader.fuse) from his *[Davinci Resolve Page Curl Transition](https://www.chrisridings.com/page-curl/)* article; **Bryan Ray**, who did a whole series of Blog posts on *[OpenCL Fuses](http://www.bryanray.name/wordpress/opencl-fuses-index/)*; **JiPi**, who did an excelent post on how to *[Convert a Shadertoy WebGL Code to DCTL](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=17&t=4460)* accompanied by a (German) [DCTL Tutorial](https://youtu.be/dbrPWRldmbs) Video and who last but not least was very patient in helping me and answering my questions. As an introduction and if you want to know more about shaders in general, I highly recommend to have a look at *[The Book of Shaders](https://thebookofshaders.com)*.

See also the [Conversions](Conversions.md) (under construction) file for some more details on how to port GLSL to DCTL.


Installation
------------

Just copy the whole folder resp. clone the repository into your `Fusion/Fuses/` directory (macOS: `~/Library/Application Support/Blackmagic Design/DaVinci Resolve/`; Windows 10: `%APPDATA%\\Blackmagic Design\\DaVinci Resolve\\Support\\`) or pick and choose only the .fuse files you are interested in and copy them into the target folder.

Alternatively you can also use the installer: drag'n'drop the `Shadertoys_Installer.lua` onto you Fuison working area, perform the installation and restart DaVinci Resolve.

<p align="center">
<a href="https://github.com/nmbr73/Shadertoys/releases/download/v0.1-alpha.1/Shadertoys_Installer.lua"><img src="https://user-images.githubusercontent.com/78935215/107845614-fb394800-6ddc-11eb-826c-59d53fd29b8f.png"></a>
</p>


Usage
-----

In the Fusion page of DaVinci Resolve right click into the working area. In the context menu under 'Add tool' you'll find a 'Fuses/Shadertoys/' submenu. That submenu corresponds to the repositorie's directory structure and provides access to all fuses installed.

Alternatifely you can open the *'Select Tool'* dialog (Shift+Space Bar) and start typing "ST-" to filter for all our shadertoy fuses.

Fuses
-----

Okay, so far there's not much here, which of course seems a bit silly after that long and thorough introduction ... but hey: it's a start.


- Object Shaders
  - [Dancy Tree Doodle](ObjektShader/DancyTreeDoodle.md) ported by [JiPi](Profiles/JiPi.md)
- Tunnel Shaders
  - [Try Not To Hit The Walls](TunnelShader/TNTHTW.md) ported by [JiPi](Profiles/JiPi.md)
- Planet Shaders
  - [Fake3DScene](PlanetShader/Fake3DScene.md) ported by [JiPi](Profiles/JiPi.md)
  - [Cracker Cars](PlanetShader/CrackerCars.md) ported by [JiPi](Profiles/JiPi.md)
- Uncategorized
   - [Cross Distance](CrossDistance.md) ported by [nmbr73](Profiles/nmbr73.md)
  - [Rainbow Slices](RainbowSlices.md) ported by [nmbr73](Profiles/nmbr73.md)
  - [Favela](Favela.md) ported by [nmbr73](Profiles/nmbr73.md)







### Noisecube.fuse :zap:

Based on '_[Noisecube](https://www.shadertoy.com/view/4sGBD1)_' by [flimshaw](https://www.shadertoy.com/user/flimshaw) and ported by [J-i-P-i](https://www.youtube.com/channel/UCItO4q_3JgMVV2MFIPDGQGg). A flight through a Phongshader

[![Noisecube](https://user-images.githubusercontent.com/78935215/107971617-fded9600-6fb2-11eb-82dd-7630ff3c34bd.PNG)](https://github.com/nmbr73/Shadertoys/blob/main/AbstractShader/Noisecube.md)


### LonelyVoxel.fuse :star2:

Based on '_[LonelyVoxel](https://www.shadertoy.com/view/Mslczn)_' by [SudoNhim](https://www.shadertoy.com/user/SudoNhim) and ported by [J-i-P-i](https://www.youtube.com/channel/UCItO4q_3JgMVV2MFIPDGQGg). A cube with rounded corners and a very nice bump map.

[![LonelyVoxel](https://user-images.githubusercontent.com/78935215/108084988-2211ab80-7075-11eb-911d-b24996b84a65.PNG)](https://github.com/nmbr73/Shadertoys/blob/main/ObjektShader/LonelyVoxel.md)




### Kali3D.fuse :crystal_ball:

Based on '_[Kali3D](https://www.shadertoy.com/view/MdB3DK)_' by [guil](https://www.shadertoy.com/user/guil) and ported by [J-i-P-i](https://www.youtube.com/channel/UCItO4q_3JgMVV2MFIPDGQGg). A flight through an abstract universe - colorful and very changeable

[![Kali3D](https://user-images.githubusercontent.com/78935215/108375469-464ec300-7202-11eb-829f-172e724172a5.PNG)](https://github.com/nmbr73/Shadertoys/blob/main/AbstractShader/Kali3D.md)
