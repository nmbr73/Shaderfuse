# AnisotropicBlurImage

This Fuse is based on the Shadertoy '_[Anisotropic Blur Image Warp](https://www.shadertoy.com/view/ldcSDB)_' by [cornusammonis](https://www.shadertoy.com/user/cornusammonis). Conversion to DCTL and encapsulation into a fuse done by [JiPi](../../Site/Profiles/JiPi.md). See [Recursive](README.md) for more fuses in this category.

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE +++ IT WOULD BE A REALLY BAD IDEA +++ -->

This conversion was created as part of a post in the WeSuckLessForum. A realistic oil shader was sought.
The basis is a diffusion reaction that is controlled with a noise pattern. If no noise pattern is applied to the second image input, the gold noise function is used. However, amazing effects can be created with a self-created pattern.
For those who want to play with the diffusion reaction, there is the OrgPar button, with which almost all parameters can be set.

Have fun playing


[![AnisotropicBlur](https://user-images.githubusercontent.com/78935215/173939861-554cd73b-f945-4af9-a775-42517b3e419d.gif)](AnisotropicBlurImage.fuse)

[![Thumbnail](AnisotropicBlurImage_screenshot.png)](https://www.shadertoy.com/view/ldcSDB "View on Shadertoy.com")

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT EDIT ANY TEXT THAT COMES AFTER THIS LINE +++ TRUST ME: JUST DON'T DO IT +++ -->

## Compatibility

⬛ macOS / Metal: <span style="color:red; ">NOT TESTED!</span><br />
⬛ macOS / OpenCL: <span style="color:red; ">NOT TESTED!</span><br />
🟩 Windows / CUDA: <span style="color:green; ">checked</span><br />
🟩 Windows / OpenCL: <span style="color:green; ">checked</span><br />


## Problems

Number of problems: 3

- Thumbnail seems to be not a 320x180 pixel PNG
- macOS_Metal compatibility not checked
- macOS_OpenCL compatibility not checked



