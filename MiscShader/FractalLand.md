Fractal Land
============

Based on '_[Fractal Land](https://www.shadertoy.com/view/XsBXWt)_' by [Kali](https://www.shadertoy.com/user/Kali) and ported by [nmbr73](../Profiles/nmbr73.md). In the meantime this Fuse's output is pretty close to the original Shader and it also runs on Win/Mac, Metal/OpenCL/Cuda now.

![screenshot](FractalLand_screenshot.png "FractalLand.fuse in DaVinci Resolve")

Still some work left to be done:
- investigate if and how to really substitute `texture` and `textureLod` function calls
- add parameters for `WAVE`, other aspects already outlined in the original shader code, and maybe for some color adjustments
- get this :cat: into the Fuse


## Compability
- [x] Tested on macOS/Metal
- [x] Tested on macOS/OpenCL
- [x] Tested on Windows/Cuda
- [x] Tested on Windows/OpenCL
