Trypophobia
==================

Based on '_[Trypophobia](https://www.shadertoy.com/view/WddXDf)_' by [warlock](https://www.shadertoy.com/user/warlock) and porting by [JiPi](Profiles/JiPi.md).

After the conversion, black glitches first appeared here. It took me some time to find the job at the Raymarcher. Obviously, WebGL is much more error-friendly with the code here.
But now I was only able to create one bump map. It felt like it took an eternity until I realized that the iChannel0 is obviously "lost" in the depths of the parameter transfers. The variant with global textures works perfectly. In a quiet minute I'll try the OpenCL variant again.


![Trypophobia](https://user-images.githubusercontent.com/78935215/114274665-df8aa080-9a1f-11eb-9ac2-132f2f167f0a.gif)

