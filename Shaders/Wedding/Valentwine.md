# Valentwine
[![Download Installer](https://img.shields.io/static/v1?label=Download&message=Valentwine-Installer.lua&color=blue)](https://github.com/nmbr73/Shadertoys/releases/download/V1.1/Valentwine-Installer.lua "Installer")

Based on '_[Valentwine](https://www.shadertoy.com/view/fsffW4)_' by [Mipmap](https://www.shadertoy.com/user/Mipmap) and ported by [JiPi](../../Site/Profiles/JiPi.md).


A heart is formed from a loose rope. When activating the "mouse button pressed", you can use the "iMouse.xy" parameters to bring movement into the shader, the area and the strength of the force applied to the rope can be varied (MouseSize, MouseForce), the rope color and background color can be changed and can also be made transparent.
Here it is important (as with all recursive shaders) that the shader is started from frame = 0. The "Reset" checkbox can be used to start in the timeline. If this is activated, the start values of the shader are set, if deactivated, the rendering process then starts.

Have fun playing


[![Valentwine](https://user-images.githubusercontent.com/78935215/198817168-863e9681-f4b7-490a-b08f-76890d5ffb5d.gif)](Valentwine.fuse)


[![Thumbnail](Valentwine.png)](https://www.shadertoy.com/view/fsffW4 "View on Shadertoy.com")


## Compatibility
- [ ] Tested on macOS/Metal
- [ ] Tested on macOS/OpenCL
- [X] Tested on Windows/Cuda
- [ ] Tested on Windows/OpenCL :bomb: Unfortunately not executable under OpenCL - picture dissolves
