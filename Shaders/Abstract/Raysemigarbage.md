# Raysemigarbage

This Fuse is based on the Shadertoy '_[raysemigarbage#3 but hilly](https://www.shadertoy.com/view/3tdSW8)_' by [supastav](https://www.shadertoy.com/user/supastav). Conversion to DCTL and encapsulation into a fuse done by [JiPi](../../Site/Profiles/JiPi.md). See [Abstract](README.md) for more fuses in this category.

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE +++ IT WOULD BE A REALLY BAD IDEA +++ -->

A very small shader, but I found it very good for getting to know the basic principles.
We have a raymarching function that can be set with the two parameters SampleCount & density. We have the two three-dimensional parameters Direction & Look (Camera) to set the view of the scene. The standard block scale, offset, angle and pivot relate to the scanning and are completely independent of raymarching.
The shader shows a texture (Image1) on a surface that can be distorted in the X and Y directions (sinus/cosinus). A second texture can be loaded for the horizon (sky) (Image2).
Due to the many parameters, you can now understand the mode of action very well. No garbage, just a cute little shader :-)

![Raysemigarbage](https://user-images.githubusercontent.com/78935215/115949042-5c168800-a4d2-11eb-95ef-cc63703e293c.gif)
[![Raysemigarbage](Raysemigarbage_screenshot.png)](Raysemigarbage.fuse)

Have fun playing

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT EDIT ANY TEXT THAT COMES AFTER THIS LINE +++ TRUST ME: JUST DON'T DO IT +++ -->

## Problems

Number of problems: 1

- Thumbnail seems to be not a 320x180 pixel PNG



