# GrowingWeatheringRocks

This Fuse is based on the Shadertoy '_[GrowingWeatheringRocks](https://www.shadertoy.com/view/ftSSDy)_' by [stb](https://www.shadertoy.com/user/stb). Conversion to DCTL and encapsulation into a fuse done by [JiPi](../../Site/Profiles/JiPi.md). See [Recursive](README.md) for more fuses in this category.

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE +++ IT WOULD BE A REALLY BAD IDEA +++ -->

An attempt to make a bump/height map for natural stone surfaces. Not physically-based.

There are extensive parameters available. In particular, three textures can be faded in or overlaid. Two variables are calculated in the calculation of the BufferA. These are taken over in the textures in the red and yellow dimension. These can be selected with the checkboxes PX / PY. The corresponding variable can also be selected for the draw function.

The standard settings for image size and depth have been replaced with this fuse. You can choose between float16 and float32 for the depth. In addition to the standard and the manual setting, the image size now includes the adoption of the image size of the image texture1 as well as four specified image sizes. The GlobalOut setting has now been moved from the header area in the inspector to the image page. Thanks to LeanNowFX (David) for the information.

Have fun playing

![GrowingWeatheringRocks](https://user-images.githubusercontent.com/78935215/128998614-85759f48-e57a-4021-aebd-10a3bf5c138c.gif)

[![GrowingWeatheringRocks](GrowingWeatheringRocks_screenshot.png)](GrowingWeatheringRocks.fuse)

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT EDIT ANY TEXT THAT COMES AFTER THIS LINE +++ TRUST ME: JUST DON'T DO IT +++ -->

## Compatibility

🟩 macOS / Metal: <span style="color:green; ">checked</span><br />
⬛ macOS / OpenCL: <span style="color:red; ">NOT TESTED!</span><br />
🟩 Windows / CUDA: <span style="color:green; ">checked</span><br />
🟩 Windows / OpenCL: <span style="color:green; ">checked</span><br />


## Problems

Number of problems: 2

- Thumbnail seems to be not a 320x180 pixel PNG
- macOS_OpenCL compatibility not checked



