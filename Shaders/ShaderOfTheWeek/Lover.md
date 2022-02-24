# Lover
[![Download Installer](https://img.shields.io/static/v1?label=Download&message=Lover-Installer.lua&color=blue)](https://github.com/nmbr73/Shadertoys/releases/download/V1.1/Lover-Installer.lua "Installer")

Based on '_[Lover](https://www.shadertoy.com/view/fsjyR3)_' by [wyatt](https://www.shadertoy.com/user/wyatt) and ported by [JiPi](../../Site/Profiles/JiPi.md).

A cool shader that uses all four buffers. I implemented a few parameters to play with. Among other things, you can connect a texture, which then specifies the shape, with the snake being placed where the alpha channel is set to 1 in the texture.

![Thumbnail](Lover_2y.png)


The image depth is fixed here at float32, since otherwise no calculation via the buffer is possible. The default resolution is set to 800x450 pixels but can be changed in Page Image.

Have fun playing


[![Lover](https://user-images.githubusercontent.com/78935215/155531303-950f901d-2797-4c5e-8def-9a7a22328bd0.gif)](https://www.shadertoy.com/view/fsjyR3 "View on Shadertoy.com")


[![Thumbnail](Lover.png)](Lover.fuse)



## Compatibility
- [ ] Tested on macOS/Metal
- [ ] Tested on macOS/OpenCL
- [X] Tested on Windows/Cuda
- [X] Tested on Windows/OpenCL
