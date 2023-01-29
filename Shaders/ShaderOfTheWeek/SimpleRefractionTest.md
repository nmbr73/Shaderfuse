# SimpleRefractionTest

This Fuse is based on the Shadertoy '_[simple refraction test](https://www.shadertoy.com/view/flcSW2)_' by [drschizzo](https://www.shadertoy.com/user/drschizzo). Conversion to DCTL and encapsulation into a fuse done by [JiPi](../../Site/Profiles/JiPi.md). See [ShaderOfTheWeek](README.md) for more fuses in this category.

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE +++ IT WOULD BE A REALLY BAD IDEA +++ -->

A very nice shader with refraction, unfortunately the result can only be generated with Cuda. With OpenCL, compiling takes forever and only the cuboid appears as a result, the drops are only rendered rudimentarily.

![SimpleRefractionTest](https://user-images.githubusercontent.com/78935215/187634245-973d63f6-7805-41bd-9586-996403a7b6f7.gif)

[![Thumbnail](SimpleRefractionTest.png)](https://www.shadertoy.com/view/flcSW2 "View on Shadertoy.com")

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT EDIT ANY TEXT THAT COMES AFTER THIS LINE +++ TRUST ME: JUST DON'T DO IT +++ -->

## Compatibility

⬛ macOS / Metal: <span style="color:red; ">NOT TESTED!</span><br />
⬛ macOS / OpenCL: <span style="color:red; ">NOT TESTED!</span><br />
🟩 Windows / CUDA: <span style="color:green; ">checked</span><br />
🟥 Windows / OpenCL<br />


## Problems

Number of problems: 4

- Thumbnail seems to be not a 320x180 pixel PNG
- macOS_Metal compatibility not checked
- macOS_OpenCL compatibility not checked
- Windows_OpenCL compatibility: 💣 time-consuming and incomplete !



