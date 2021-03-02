# WildKifs4D.fuse


Based on '_[WildKifs4D](https://www.shadertoy.com/view/wttBzM)_' by [iapafoto](https://www.shadertoy.com/user/iapafoto) and ported by [JiPi](../Profiles/JiPi.md).

A very changing lump with great surface effects

[![Wildkif4D](WildKifs4D.png)](WildKifs4D.fuse)

In the original, a very interesting possibility has been created to make the appearance appear more realistic. This is achieved by calculating and merging the entire shader four more times with shifted parameters. Another kernel would be necessary for this. Since this is very performance-intensive, it was omitted here. He already looks very good :-)

The Fuse is tested with Cuda, OpenCL. Test for Metal is pending.

Have fun


## Compability
- [ ] Tested on macOS/Metal
- [ ] Tested on macOS/OpenCL
- [x] Tested on Windows/Cuda
- [x] Tested on Windows/OpenCL
