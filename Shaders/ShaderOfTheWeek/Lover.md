# Lover

This Fuse is based on the Shadertoy '_[Lover](https://www.shadertoy.com/view/fsjyR3)_' by [wyatt](https://www.shadertoy.com/user/wyatt). Conversion to DCTL and encapsulation into a fuse done by [JiPi](../../Site/Profiles/JiPi.md). See [ShaderOfTheWeek](README.md) for more fuses in this category.

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE +++ IT WOULD BE A REALLY BAD IDEA +++ -->

A cool shader that uses all four buffers. I implemented a few parameters to play with. Among other things, you can connect a texture, which then specifies the shape, with the snake being placed where the alpha channel is set to 1 in the texture.

![Thumbnail](Lover_2y.png)


The image depth is fixed here at float32, since otherwise no calculation via the buffer is possible. The default resolution is set to 800x450 pixels but can be changed in Page Image.

Have fun playing


[![Lover](https://user-images.githubusercontent.com/78935215/155531303-950f901d-2797-4c5e-8def-9a7a22328bd0.gif)](https://www.shadertoy.com/view/fsjyR3 "View on Shadertoy.com")


[![Thumbnail](Lover_screenshot.png)](Lover.fuse)

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT EDIT ANY TEXT THAT COMES AFTER THIS LINE +++ TRUST ME: JUST DON'T DO IT +++ -->

## Compatibility

⬛ macOS / Metal: <span style="color:red; ">NOT TESTED!</span><br />
⬛ macOS / OpenCL: <span style="color:red; ">NOT TESTED!</span><br />
🟩 Windows / CUDA: <span style="color:green; ">checked</span><br />
🟩 Windows / OpenCL: <span style="color:green; ">checked</span><br />


## Problems

Number of problems: 3

- Thumbnail seems to be not a 320x180 pixel PNG
- macOS_Metal compatibility not checked
- macOS_OpenCL compatibility not checked



