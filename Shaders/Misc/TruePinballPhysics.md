TruePinballPhysics
==================

Based on '_[True Pinball Physics](https://www.shadertoy.com/view/4tBGRm)_' by [archee](https://www.shadertoy.com/user/archee) and ported by ported by [JiPi](../../Site/Profiles/JiPi.md).

Something completely different than the usual blob / tunnel / fractal / object shader.
A falling hopping ball bounces from line to line. I laid a big egg on the first try (sorry for the phrase). Due to this error, the shader completely refused to work. It took a while to isolate the error. But it is finally done. I have implemented all possible parameters in the fuse here. The colors, line and ball strength, gravity, the repetition time, motionblur and the bounceratio are adjustable. And of course the six lines can be changed. There are two points, a start and an end point. The parameters are almost all free, i.e. you can also make nonsensical settings, these will not be intercepted. In a pinch there is a "reset" button for the parameters.

Have fun playing

Oh, in addition to the adjustable repetition time, there is also the restriction to 50 bounces for the length of a run. But that could be changed quickly.

[![TruePinballPhysics](TruePinballPhysics.png)](TruePinballPhysics.fuse)

![TruePinballPhysics2](https://user-images.githubusercontent.com/78935215/116098822-a7d05980-a6ab-11eb-9e85-4ebd128ba09a.gif)





## Compatibility
- [x] Tested on macOS/Metal
- [x] Tested on macOS/OpenCL
- [x] Tested on Windows/Cuda
- [x] Tested on Windows/OpenCL