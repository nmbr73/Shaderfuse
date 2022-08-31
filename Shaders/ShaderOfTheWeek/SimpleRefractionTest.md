# SimpleRefractionTest
[![Download Installer](https://img.shields.io/static/v1?label=Download&message=SimpleRefractionTest-Installer.lua&color=blue)](https://github.com/nmbr73/Shadertoys/releases/download/V1.1/SimpleRefractionTest-Installer.lua "Installer")

Based on '_[simple refraction test](https://www.shadertoy.com/view/flcSW2)_' by [drschizzo](https://www.shadertoy.com/user/drschizzo) and ported by [JiPi](../../Site/Profiles/JiPi.md).


A very nice shader with refraction, unfortunately the result can only be generated with Cuda. With OpenCL, compiling takes forever and only the cuboid appears as a result, the drops are only rendered rudimentarily.

![SimpleRefractionTest](https://user-images.githubusercontent.com/78935215/187634245-973d63f6-7805-41bd-9586-996403a7b6f7.gif)

[![Thumbnail](SimpleRefractionTest.png)](https://www.shadertoy.com/view/flcSW2 "View on Shadertoy.com")



## Compatibility
- [ ] Tested on macOS/Metal
- [ ] Tested on macOS/OpenCL
- [X] Tested on Windows/Cuda
- [ ] Tested on Windows/OpenCL :bomb: time-consuming and incomplete !
