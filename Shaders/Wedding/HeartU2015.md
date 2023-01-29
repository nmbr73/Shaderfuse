# HeartU2015

This Fuse is based on the Shadertoy '_[heart u 2015](https://www.shadertoy.com/view/lts3RX)_' by [mattz](https://www.shadertoy.com/user/mattz). Conversion to DCTL and encapsulation into a fuse done by [JiPi](../../Site/Profiles/JiPi.md). See [Wedding](README.md) for more fuses in this category.

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE +++ IT WOULD BE A REALLY BAD IDEA +++ -->

Nested partially open hearts that rotate around each other like clockwork.
The viewing angle can be changed using the mouse parameters.
The focus and a zoom can be adjusted with yscl and f.
Reflections (_R), Diffusion ( Diffamb) and Specular ( Spec ) are customizable, as is the strength of the cubemap (Decube). This is connected to iChannel0 and causes the mirroring.
With the help of the parameters tmy1, tmy2 and tmy3 the individual switches of the hearts can be selected for the setting with activated TexOn (inputs iChannel1 to IChannel3). The texture can then be moved to the correct position with the Tuv1, Tuv2 and Tuv3 respectively. The background color (Color) can be set and also become transparent. The Canvas setting under Edges is recommended for use with textures, otherwise the textures will be mirrored, expanded or continued at the edge.

Have fun playing


[![HeartU2015](https://user-images.githubusercontent.com/78935215/199003640-74bd4e63-31d1-47ce-91ae-b156845575c6.gif)](HeartU2015.fuse)

[![Thumbnail](HeartU2015.png)](https://www.shadertoy.com/view/lts3RX "View on Shadertoy.com")

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



