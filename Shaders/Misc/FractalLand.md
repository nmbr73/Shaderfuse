In the meantime this Fuse's output is pretty close to the original Shader and it also runs on Win/Mac, Metal/OpenCL/Cuda now.

![screenshot](FractalLand_screenshot.png "FractalLand.fuse in DaVinci Resolve")

Still some work left to be done:
- investigate if and how to really substitute `texture` and `textureLod` function calls
- add parameters for `WAVE`, other aspects already outlined in the original shader code, and maybe for some color adjustments
- get this :cat: into the Fuse