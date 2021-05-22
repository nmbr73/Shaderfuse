# Spilled.fuse


Based on '_[Spilled](https://www.shadertoy.com/view/MsGSRd)_' by [flockaroo](https://www.shadertoy.com/user/flockaroo) and ported by [JiPi](../../Site/Profiles/JiPi.md).

A nice example for "computational flockarooid dynamics"

[![Spilled](Spilled.png)](Spilled.fuse)

It took a while until the penny for the implementation of a BufferA in DCTL fell. I struggled with an offset and strong artifacts. When tida wrote a post with exactly this shader in WSL, I first created the recursive call using Pieter's "loop" (WeSuckLessForum). The construction of the multi-core fuse was successful and tida added great features and parameters.
Now I found the time for a clean-up.
The use of this type of fuses is not very easy to handle, since a cycle must not be interrupted or disturbed by changing parameters. There is a reset button for "practicing", this executes a purge cache and initializes the image memory with Image1. Image1 can also be loaded as an initialization image by ticking the "Startpicture" checkbox for the start frames. For the blend functionality, first set the blend control to 1, then to zero, then the flow process can be carried out. Keyframes or expressions are then necessary for the production.


Here is a little study with this fuse: https://www.youtube.com/watch?v=oyndG0pLEQQ

The Fuse is tested with Cuda, OpenCL. The test for Metal is pending.

Have fun playing

## Compatibility
- [x] Tested on macOS/Metal
- [x] Tested on macOS/OpenCL
- [x] Tested on Windows/Cuda
- [x] Tested on Windows/OpenCL
