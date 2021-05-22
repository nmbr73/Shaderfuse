# Vine.fuse


Based on '_[Vine](https://www.shadertoy.com/view/XldSz7)_' by [gaz](https://www.shadertoy.com/user/gaz) and ported by [JiPi](../../Site/Profiles/JiPi.md).

Colorful lines entwine and fade across the screen

[![Vine](Vine.png)](https://github.com/nmbr73/Shadertoys/blob/main/AbstractShader/Vine.fuse)

This shader consists of an image buffer that recursively processes the image. It is important that the color depth should be set to at least "float16", otherwise the thread will not deliver a good result due to the lack of resolution ("black" is not achieved).
This shader has been tested under Cuda, OpenCL, and Metal.

Have fun playing

## Compatibility
- [x] Tested on macOS/Metal
- [x] Tested on macOS/OpenCL
- [x] Tested on Windows/Cuda
- [x] Tested on Windows/OpenCL